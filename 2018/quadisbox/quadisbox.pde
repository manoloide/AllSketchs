import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus

float amp1 = 1;
float amp2 = 1;

void setup() {
  size(400, 400);
  background(0);

  //MidiBus.list();
  myBus = new MidiBus(this, 0, -1);
}

int scene = 1;

void draw() {

  background(0);

  noStroke();
  fill(255);
  amp1 = amp1*0.8;
  ellipse(width/2, height/2, width*amp1, height*amp1);

  int cc = 5;
  float ss = width/cc;
  amp2 = amp2*0.95;

  rectMode(CENTER);
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      rect((i+0.5)*ss, (j+0.5)*ss, ss*amp2, ss*amp2);
    }
  }

  if (scene == 1) text("scene1", 20, 20);
  if (scene == 2) text("scene2", 20, 20);
  if (scene == 3) text("scene3", 20, 20);
  if (scene == 4) text("scene4", 20, 20);
}

void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn
  println();
  println("Note On:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
}

void noteOff(int channel, int pitch, int velocity) {
  // Receive a noteOff
  println();
  println("Note Off:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);

  if (pitch == 12) scene = 1;
  if (pitch == 13) scene = 2;
  if (pitch == 14) scene = 3;
  if (pitch == 15) scene = 4;

  if (pitch == 60) amp2 = 1;
  if (pitch == 84) amp1 = 1;
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
}
