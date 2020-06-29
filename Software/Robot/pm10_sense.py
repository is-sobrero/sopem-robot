# Copyright 2020 I.S. "A. Sobrero" - SoRobot Team. All rights reserved.
# Use of this source code is governed by the GPL 3.0 license that can be
# found in the LICENSE file.

import machine
import halo
from machine import Pin
import ujson

class pm10_sensor:
	def __init__(self, led_ctrl, sensor):
		# Carica la configurazione SW
		with open("config.json") as cfg:
			self.config = ujson.loads(cfg.read())
		self.led = Pin(led_ctrl, Pin.OUT)
		self.sensor = machine.ADC(Pin(sensor))

	def get_pm10(self):
		halo.led.show_animation('meteor')

		# ottiene il rumore di fondo del sensore
		# eliminando gran parte delle radiazioni solari
		self.led.value(0)
		machine.sleep(1)
		background = self.sensor.read() / 1024.0 * 3.3
		machine.sleep(2)

		# accende il led per rilevare riflessioni
		self.led.value(1)
		machine.sleep(1)
		voltage_val = self.sensor.read() / 1024.0 * 3.3
		self.led.value(0)

		final_val = voltage_val - background

		# Ottengo il valore centrato alla massa virtuale
		referenced_v = final_val - self.config["sensor"]["reference_voltage"]

		# Applico i valori ottenuti dal Fitter
		m = self.config["sensor"]["linear_m"]
		q = self.config["sensor"]["linear_q"]
		pm10 = referenced_v * m + q

		halo.led.show_ring("green green green black black black black black green green green green") # :)

		return pm10