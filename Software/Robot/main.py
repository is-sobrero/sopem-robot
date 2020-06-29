# Copyright 2020 I.S. "A. Sobrero" - SoRobot Team. All rights reserved.
# Use of this source code is governed by the GPL 3.0 license that can be
# found in the LICENSE file.

# Svuota la RAM dalla spazzatura all'avvio dello script
# Utile durante il debug se si avvia lo script dalla REPL
import gc, halo
gc.collect()

# Workaround per usare i pin di halocode con machine,
# il firmware di default sembra fare pasticci sui pin,
# facendo così sembra l'unico modo per rimediare
halo.pin0.write_digital(0)
halo.pin1.write_digital(0)
halo.pin2.write_digital(0)
halo.pin3.write_digital(0)

import machine
from machine import Pin
import ujson
import network
import time
from umqttsimple import MQTTClient
import ubinascii
from motors import motor_controller
from pm10_sense import pm10_sensor

# D0 = Pin 2
# D1 = Pin 15
# A2 = Pin 33
# A3 = Pin 32

# Carica la configurazione SW
with open("config.json") as cfg:
	config = ujson.loads(cfg.read())

net = network.WLAN(network.STA_IF)
machine_id = machine.unique_id()
client_id = ubinascii.hexlify(machine_id).decode('utf-8')

# Istanzia la classe del motor controller
mc = motor_controller(21, 22, 0x77)

# Istanzia la classe del sensore pm10
pm10 = pm10_sensor(2, 33) # cambiare pin

sequence_str = ""

# funzione per gestire gli errori
def on_error(desc):
	halo.led.show_ring("black black red red red red red red red black black black") # :(
	print("[E] " + desc)
	print("[I] Uscita dallo script")
	quit()

def network_connect():
	# se già connesso è inutile fare tutta la procedura
	if net.isconnected() == True:
		print("SoPEM connesso, ifconfig:")
		print(net.ifconfig())
		return

	# Cerca di connettersi alla rete wifi, se fallisce
	# visualizza una faccia triste
	net.active(True)
	net.connect(config["wifi"]["ssid"], config["wifi"]["password"])

    # timeout di connessione
	timeout = time.time() + 30

	while not net.isconnected():
		# se non riesce a connettersi entro 30 secondi,
		# esce dallo script
		halo.led.show_animation('meteor')
		if time.time() > timeout:
			on_error("Impossibile connettersi alla rete wifi")

	print("SoPEM connesso, ifconfig:")
	print(net.ifconfig())

def run_sequence(response):
	global mc, pm10, client, config
	average_pm10 = 0
	sequence = ujson.loads(response)
	for movement in sequence:
		if movement["direction"] == 0:
			print("fwd")
	    	mc.motor_forward()
		if movement["direction"] == 1:
			print("rev")
			mc.motor_reverse()
		if movement["direction"] == 2:
			print("dx")
			mc.motor_right()
		if movement["direction"] == 3:
			print("sx")
			mc.motor_left()
		time.sleep(movement["duration"])
		mc.motor_stop()
		average_pm10 += pm10.get_pm10()

	average_pm10 /= len(sequence)	
	send_topic = str.encode(config["mqtt"]["topics"]["pm10"])
	send_msg = str(average_pm10).encode('utf-8')
	client.publish(send_topic, send_msg)

def get_pm10(send_to_broker = False):
	global client, config, pm10
	
	concentration = pm10.get_pm10()
	
	if send_to_broker:
		send_topic = str.encode(config["mqtt"]["topics"]["pm10"])
		send_msg = str(concentration).encode('utf-8')
		print(send_topic)
		client.publish(send_topic, send_msg)

def on_message(topic, msg):
	global sequence_str, config
	msg_str = msg.decode("utf-8")
	topic_str = topic.decode("utf-8")
	print(topic)

	if topic_str == config["mqtt"]["topics"]["config"]:
		if msg_str == "run" and not sequence_str == "":
			run_sequence(sequence_str)
		if msg_str == "get":
			get_pm10(True)

	if topic_str == config["mqtt"]["topics"]["sequence"]:
		sequence_str = msg_str

def get_client(client_id, uri, uname, upass):
	client = MQTTClient(client_id, uri)
	client.set_callback(on_message)
	client.connect()
	print("Connesso al broker")
	return client

# Configurazione iniziale del robot
network_connect()

if not mc.discovery():
	on_error("Controller dei motori non connesso!")

try:
	client = get_client(
		client_id,
		config["mqtt"]["broker"],
		config["mqtt"]["username"],
		config["mqtt"]["password"]
	)
	client.subscribe(config["mqtt"]["topics"]["config"])
	client.subscribe(config["mqtt"]["topics"]["sequence"])
except OSError as e:
	on_error(e.args[0])

halo.led.show_ring("green green green black black black black black green green green green") # :)

while True:
	try:
		client.check_msg()
	except OSError as e:
		print(e.args[0])