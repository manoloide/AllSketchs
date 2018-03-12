import processing.serial.*;
import cc.arduino.*;

Arduino arduino;

int ledPin=13;
boolean led=false;

void setup(){
  size(200,200);
  arduino = new Arduino(this, Arduino.list()[1],57600);
  arduino.pinMode(ledPin, Arduino.OUTPUT);
  arduino.digitalWrite(ledPin, Arduino.HIGH);
}

void draw(){
  
}

void mousePressed(){
  if(led){
     arduino.digitalWrite(ledPin, Arduino.HIGH);
  } 
  else{
     arduino.digitalWrite(ledPin, Arduino.LOW); 
  }
  led =!led;
}
