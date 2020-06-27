import 'dart:convert';

import 'package:flutter/material.dart';

class RobotMovement {
  final String direction, timing;
  // _direction = 0 avanti
  // 1 indietro
  // 2 destra
  // 3 sinistra
  int _direction, _timing;

  RobotMovement({
    @required this.direction,
    @required this.timing,
  }) {
    assert(direction != null);
    assert(timing != null);
    _timing = int.parse(timing.replaceAll(" sec", ""));
    _direction = 0;
    if (direction == "Indietro") _direction = 1;
    if (direction == "Destra") _direction = 2;
    if (direction == "Sinistra") _direction = 3;
  }

  int get finalDirection => _direction;
  int get finalTiming => _timing;

  Map<String, dynamic> toJson() =>
      {
        'direction': _direction,
        'duration': _timing,
      };

  static String generateConfigString(List<RobotMovement> movements){
    var serialized = jsonEncode(movements);
    return serialized.toString();
  }
}

EdgeInsets appPadding = EdgeInsets.only(left: 15, right: 15);

class CommunicationDetails {
  static String broker = "test.mosquitto.org";
  static int port = 1883;
  static String sequenceTopic = "sopem/sequence";
  static String configTopic = "sopem/config";
  static String pm10Topic = "sopem/pm10";
}