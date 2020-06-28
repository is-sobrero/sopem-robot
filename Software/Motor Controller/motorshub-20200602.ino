// Copyright 2020 I.S. "A. Sobrero". All rights reserved.
// Use of this source code is governed by the GPL 3.0 license that can be
// found in the LICENSE file.

#define CFG_I2C_DEFAULT_ADDRESS 0x77

#define CFG_I2C_DESTINATION_MOTOR_A 0x0A
#define CFG_I2C_DESTINATION_MOTOR_B 0x0B
#define CFG_I2C_COMMAND_MOTOR_STOP 0x01
#define CFG_I2C_COMMAND_MOTOR_FWD 0x02
#define CFG_I2C_COMMAND_MOTOR_REV 0x03

#define CFG_HBRIDGE_MA1 1
#define CFG_HBRIDGE_MA2 3
#define CFG_HBRIDGE_MB1 4
#define CFG_HBRIDGE_MB2 5

#include <Wire.h>

void setup() {
  pinMode(CFG_HBRIDGE_MA1, OUTPUT);
  pinMode(CFG_HBRIDGE_MA2, OUTPUT);
  pinMode(CFG_HBRIDGE_MB1, OUTPUT);
  pinMode(CFG_HBRIDGE_MB2, OUTPUT);
  Wire.begin(CFG_I2C_DEFAULT_ADDRESS);
  Wire.onReceive(receiveISR);
}

void loop() {
  // watchdog trigger!
  delay(100);
}

void receiveISR(int len){
  while(Wire.available() > 0){
    uint8_t data = Wire.read();
    
    uint8_t destination = data >> 4;
    uint8_t command = data & 0x0F;

    if (destination == CFG_I2C_DESTINATION_MOTOR_A){
      if (command == CFG_I2C_COMMAND_MOTOR_STOP){
        digitalWrite(CFG_HBRIDGE_MA1, HIGH);
        digitalWrite(CFG_HBRIDGE_MA2, HIGH);
      }
      if (command == CFG_I2C_COMMAND_MOTOR_FWD){
        digitalWrite(CFG_HBRIDGE_MA1, LOW);
        digitalWrite(CFG_HBRIDGE_MA2, HIGH);
      }
      if (command == CFG_I2C_COMMAND_MOTOR_REV){
        digitalWrite(CFG_HBRIDGE_MA1, HIGH);
        digitalWrite(CFG_HBRIDGE_MA2, LOW);
      }
    }

    if (destination == CFG_I2C_DESTINATION_MOTOR_B){
      if (command == CFG_I2C_COMMAND_MOTOR_STOP){
        digitalWrite(CFG_HBRIDGE_MB1, HIGH);
        digitalWrite(CFG_HBRIDGE_MB2, HIGH);
      }
      if (command == CFG_I2C_COMMAND_MOTOR_FWD){
        digitalWrite(CFG_HBRIDGE_MB1, LOW);
        digitalWrite(CFG_HBRIDGE_MB2, HIGH);
      }
      if (command == CFG_I2C_COMMAND_MOTOR_REV){
        digitalWrite(CFG_HBRIDGE_MB1, HIGH);
        digitalWrite(CFG_HBRIDGE_MB2, LOW);
      }
    }
  }
}
