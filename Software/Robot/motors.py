# Copyright 2020 I.S. "A. Sobrero" - SoRobot Team. All rights reserved.
# Use of this source code is governed by the GPL 3.0 license that can be
# found in the LICENSE file.

import machine
from machine import Pin
import ujson

class motor_controller:
	def __init__(self, sda, scl, addr):
		self.sda = Pin(sda)
		self.scl = Pin(scl)
		self.i2c = machine.I2C(scl=self.scl, sda=self.sda)

		self.motorAddr = addr

	def discovery(self):
		connected_devices = self.i2c.scan()
		return self.motorAddr in connected_devices

	def motor_forward(self):
		self.i2c.writeto(self.motorAddr, b'\xA2')
		self.i2c.writeto(self.motorAddr, b'\xB2')

	def motor_reverse(self):
		self.i2c.writeto(self.motorAddr, b'\xA3')
		self.i2c.writeto(self.motorAddr, b'\xA3')

	def motor_left(self):
		self.i2c.writeto(self.motorAddr, b'\xA3')
		self.i2c.writeto(self.motorAddr, b'\xB2')

	def motor_right(self):
		self.i2c.writeto(self.motorAddr, b'\xA2')
		self.i2c.writeto(self.motorAddr, b'\xB3')

	def motor_stop(self):
		self.i2c.writeto(self.motorAddr, b'\xA1')
		self.i2c.writeto(self.motorAddr, b'\xA1')