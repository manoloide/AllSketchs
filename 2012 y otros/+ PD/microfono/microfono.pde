import oscP5.*;

float global;
int c = 127;
OscP5 oscP5;

void setup() {
  size(400, 400);
  frameRate(60);
  colorMode(HSB);
  smooth();
  oscP5 = new OscP5(this, 12001);
  noStroke();
}

void draw() {
  fill(0, 10);
  rect(0, 0, width, height);
  fill(c, 255, 255, 20);
  float tam = global * 5 / 2 ;
  ellipse(width/2, height/2, tam, tam);
}


void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/1")==true) {
    float secondValue = theOscMessage.get(0).floatValue(); 
    global = secondValue;
  }
  if (theOscMessage.checkAddrPattern("/2")==true) { 
    int firstValue = theOscMessage.get(0).intValue(); 
    if (c > firstValue * 2) {
      c--;
    }
    else {
      c++;
    }
  }
}

