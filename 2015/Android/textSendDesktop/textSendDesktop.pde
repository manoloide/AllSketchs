import oscP5.*;
import netP5.*;

OscP5 oscP5;
//NetAddress address;

String msg = ""; 

void setup() {
  size(400, 400);
  oscP5 = new OscP5(this, 12008);
  //address = new NetAddress("192.168.0.8", 12008);
}

void draw() {
  background(255, 128, 0);
  textAlign(CENTER, CENTER);
  textSize(48);
  fill(255);
  text(msg, width/2, height/2);
}

void oscEvent(OscMessage theOscMessage) {
  msg = theOscMessage.get(0).toString();
}