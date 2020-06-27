import 'dart:async';

import 'package:flutter/material.dart';

import 'package:sopem_companion/app_main/definitions.dart';
import 'package:sopem_companion/app_main/widgets.dart';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MainApplication extends StatefulWidget {
  MainApplication({Key key}) : super(key: key);

  @override
  _MainApplicationState createState() => _MainApplicationState();
}

class _MainApplicationState extends State<MainApplication>{
  List<String> _directions = ['Avanti', 'Indietro', 'Destra', 'Sinistra'];
  List<String> _duration = ['1 sec', '2 sec', '3 sec', '4 sec'];

  List<RobotMovement> _movements = List<RobotMovement>();

  final MqttClient client = MqttServerClient('test.mosquitto.org', '');

  String _selectedDirection, _selectedTiming, _actualPM10 = "N/D";

  StreamSubscription subscription;

  int _connectionStatus = -1;


  void setStatus(int status){
    setState(() {
      _connectionStatus = status;
    });
  }

  void connectToBroker() async {
    client.logging(on: false);
    client.keepAlivePeriod = 20;

    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier('Mqtt_MyClientUniqueId')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    print('Connessione al broker in corso');
    client.connectionMessage = connMess;

    try {
      await client.connect();
    } on Exception catch (e) {
      print('Exception durante la connessione: $e');
      client.disconnect();
      setStatus(-1);
      return;
    }

    if (client.connectionStatus.state == MqttConnectionState.connected) {
      setStatus(0);
      print('Client connesso al broker');
      client.subscribe(CommunicationDetails.pm10Topic, MqttQos.atLeastOnce);
      client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
        final MqttPublishMessage recMess = c[0].payload;
        if (c[0].topic == CommunicationDetails.pm10Topic){
          setState(() {
            _actualPM10 = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
          });
        }
      });
    } else {
      setStatus(1);
      client.disconnect();
      return;
    }
  }

  @override
  void initState(){
    super.initState();
    connectToBroker();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: SoPEMAppBar(
        status: _connectionStatus,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(30),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Valore attuale di PM10",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _actualPM10,
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                    Text("ug/m3"),
                  ],
                ),
              ),
            ),
            Padding(
              padding: appPadding,
              child: Row(
                children: <Widget>[
                  Text(
                    "Movimenti registrati",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () => setState(
                            () => _movements = List<RobotMovement>(),
                      ),
                  ),
                ],
              ),
            ),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 30,
                    spreadRadius: 10
                  ),
                ],
              ),
              child: ListView.builder(
                itemCount: _movements.length,
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: <Widget>[
                      Text(_movements[i].direction),
                      Spacer(),
                      Text(_movements[i].timing),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownButton<String>(
                  value: _selectedDirection,
                  hint: Icon(Icons.directions),
                  items: _directions.map((value) => DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  )).toList(),
                  onChanged: (value) => setState(
                        () => _selectedDirection = value,
                  ),
                ),
                DropdownButton<String>(
                  value: _selectedTiming,
                  hint: Icon(Icons.access_time),
                  items: _duration.map((value) => DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  )).toList(),
                  onChanged: (value) => setState(() => _selectedTiming = value),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => setState(() => _movements.add(
                      RobotMovement(
                        direction: _selectedDirection,
                        timing: _selectedTiming,
                      )
                  ))
                ),
              ],
            ),
            Container(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  OutlineButton(
                    child: Text("Invia a SoPEM"),
                    onPressed: _connectionStatus == 0 ? () {
                      MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
                      builder.addString(
                        RobotMovement.generateConfigString(_movements)
                      );
                      client.publishMessage(
                        CommunicationDetails.sequenceTopic,
                        MqttQos.atLeastOnce,
                        builder.payload,
                      );
                    } : null,
                  ),
                  OutlineButton(
                    child: Text("Esegui sequenza"),
                    onPressed: _connectionStatus == 0 ? () {
                      MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
                      builder.addString("run");
                      client.publishMessage(
                        CommunicationDetails.configTopic,
                        MqttQos.atLeastOnce,
                        builder.payload,
                      );
                    } : null,
                  ),
                  OutlineButton(
                    child: Text("Ottieni valori"),
                    onPressed: _connectionStatus == 0 ? () {
                      MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
                      builder.addString("get");
                      client.publishMessage(
                        CommunicationDetails.configTopic,
                        MqttQos.atLeastOnce,
                        builder.payload,
                      );
                    } : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}