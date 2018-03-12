//cargar StanderFirmata en el arduino

import processing.serial.*;
import cc.arduino.*;

Arduino arduino;

import ddf.minim.*;

Minim minim;
AudioSample kick;

int ledPin=13;
int ana = 0;
float valor, ant;

void setup() {
  size(400, 400);
  arduino = new Arduino(this, Arduino.list()[1], 57600);
  arduino.pinMode(ledPin, Arduino.OUTPUT);
  arduino.digitalWrite(ledPin, Arduino.LOW);

  minim = new Minim(this);
  kick = minim.loadSample("kick.wav", 2048);

  background(0);
  smooth();
  noStroke();

  ant = 0;
}

void draw() {
  fill(0, 10);
  rect(0, 0, width, height);
  valor = arduino.analogRead(ana);
  valor = map(valor, 0, 1023, 0, width);
  fill(255);
  ellipse(width/2, width-valor, 20, 20);
  if (valor > 25 && ant < valor) { 
    println(valor);
    kick.trigger();
  }
  ant = valor;
}

void stop()
{
  // always close Minim audio classes when you are done with them
  kick.close();
  minim.stop();

  super.stop();
}

