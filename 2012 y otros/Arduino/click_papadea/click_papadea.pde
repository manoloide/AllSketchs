//cargar StanderFirmata en el arduino

import processing.serial.*;
import cc.arduino.*;

Arduino arduino;

int ledPin=13;
boolean blink=false;

void setup() {
  size(200, 200);
  arduino = new Arduino(this, Arduino.list()[1], 57600);
  arduino.pinMode(ledPin, Arduino.OUTPUT);
  arduino.digitalWrite(ledPin, Arduino.LOW);
}

void draw() {
  if (blink) {
    arduino.digitalWrite(ledPin, Arduino.HIGH);
    delay(100);
    arduino.digitalWrite(ledPin, Arduino.LOW);
    delay(100);
  }else{
    arduino.digitalWrite(ledPin, Arduino.LOW);
  }
}

void mousePressed() {
  blink = !blink;
}

