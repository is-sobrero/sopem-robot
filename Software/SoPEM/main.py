# Copyright 2020 I.S. "A. Sobrero" - SoRobot Team. All rights reserved.
# Use of this source code is governed by the GPL 3.0 license that can be
# found in the LICENSE file.

import halo
import machine
from machine import Pin
import ujson
import network
import time
from umqttsimple import MQTTClient
import gc
import ubinascii

# avvia il garbage collector, non si sa mai :)
gc.collect()

# Workaround per usare i pin di halocode con machine
# il firmware di default sembra fare pasticci sui pin,
# facendo così sembra l'unico modo per rimediare
halo.pin0.write_digital(0)
halo.pin0.write_digital(1)
halo.pin0.write_digital(2)
halo.pin0.write_digital(3)

net = network.WLAN(network.STA_IF)
machine_id = machine.unique_id()
client_id = ubinascii.hexlify(machine_id).decode('utf-8')

sda = Pin(21)
scl = Pin(22)

i2c = machine.I2C(scl=scl, sda=sda)

# funzione per gestire gli errori
def on_error(desc):
	halo.led.show_ring("black black red red red red red red red black black black") # :(
	print("[E] " + desc)
	print("[I] Uscita dallo script")
	quit()

# Carica la configurazione SW
with open("config.json") as cfg:
	config = ujson.loads(cfg.read())

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

def motors_config():
	connected_devices = i2c.scan()
	if not config["motors"]["address"] in connected_devices:
		on_error("Controller dei motori non connesso!")

pm10 = 7.3
invokMot = False
getPM10 = False

def on_message(topic, msg):
	global invokMot, getPM10, pm10
	msg_str = msg.decode("utf-8")
	print("MESS")
	print(topic)
	print(msg_str)
	if msg_str == "start":
		invokMot = True
	if msg_str == "pm10":
		halo.led.show_animation('meteor')
		halo.led.show_ring("green green green black black black black black green green green green") # :)
		if invokMot:
			pm10 = 8.1
		getPM10 = True

def get_client(client_id, uri, uname, upass):
	client = MQTTClient(client_id, uri)
	client.set_callback(on_message)
	client.connect()
	print("Connesso al broker")
	return client

network_connect()
#motors_config()

halo.led.show_ring("green green green black black black black black green green green green") # :)

try:
	client = get_client(
		client_id, 
		config["mqtt"]["broker"], 
		config["mqtt"]["username"], 
		config["mqtt"]["password"]
	)
	client.subscribe(config["mqtt"]["topics"]["config"])
except OSError as e:
	on_error(e.strerror)

while True:
	try:
		if getPM10:
			getPM10 = False
			client.publish(b"sopem/pm10", str.encode(str(pm10)))
		client.check_msg()
	except OSError as e:
		on_error(e.strerror)
