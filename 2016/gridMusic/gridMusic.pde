import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus

float attackTime = 0.001;
float sustainTime = 0.004;
float sustainLevel = 0.2;
float releaseTime = 0.2;

int tonic = 0;
int chord = 0;
int[] chords = {0, 3, 4, 1};
int[] scale = {0, 2, 4, 5, 7, 9, 11};

int duration = 300;
int trigger = 0; 
int note = -1; 
int initMillis = -1;

boolean actived[][];
float light[][];


PFont font;

void setup() {
  size(960, 960);
  rectMode(CENTER);
  font = createFont("Code-Pro-Bold-LC", 48, true);
  textFont(font);

  MidiBus.list();
  myBus = new MidiBus(this, -1, 2);

  generate();
}


void draw() {
  background(#0F0D1A);
  translate(width/2, height/2);

  blendMode(ADD);
  noStroke();
  fill(200, 20);
  rect(0, 0, 720, 720, 16);
  float ss = (720-80)/8;
  float des = -ss*4+ss*0.5;
  for (int j = 0; j < 8; j++) {
    for (int i = 0; i < 8; i++) {
      fill(200, 20);
      stroke(0, 10);
      if (actived[i][j]) fill(120, 140, 200, 90);
      rect(des+ss*i, des+ss*j, ss*0.9, ss*0.9, 4);
      noStroke();
      if (light[i][j] > 0) {
        if (actived[i][j])  fill(120, 140, 200, 180*light[i][j]); 
        else fill(255, 20*light[i][j]);
        rect(des+ss*i, des+ss*j, ss*0.9, ss*0.9, 4);
      }
      light[i][j] *= 0.9;
    }
  }

  for (int i = 0; i < chords.length; i++) {
    float x = (i-2)*ss*2+ss;
    float y = -ss*5;
    fill(200, 10);
    if (chord == i) fill(200, 20);
    rect(x, y, ss*2-2, ss-2);
    fill(240, 220); 
    textAlign(CENTER, CENTER);
    text( chords[i]+1, x, y);
  }

  if (millis() > trigger) {
    if (initMillis == -1) initMillis= millis();
    note++; 
    note %= 8;
    if (note == 0) {
      chord++;
      chord%= 4;
    }
    for (int i = 0; i < 8; i++) {
      light[note][i] = 1;
      if (actived[note][i]) {
        //sinOsc.play(midiToFreq(getNote(28+i)), 0.8);
        myBus.sendNoteOn(0, getNote(28+i+getNote(chords[chord])), 100);
      }
    }
    trigger = millis() + duration;
  }
}

void keyPressed() {
  generate();
}

void mousePressed() {
  float ss = (720-80)/8;
  float des = width/2-ss*4;

  int xx = floor((mouseX-des)/ss);
  int yy = floor((mouseY-des)/ss);

  if (xx >= 0 && xx < 8 && yy >= 0 && yy < 8) {
    actived[xx][yy] = !actived[xx][yy];
  }
}

int getNote(int n) {
  int alt = n/7;
  int not = n%7;

  return tonic + scale[not] + alt * 12;
}


void generate() {
  actived = new boolean[8][8];
  light = new float[8][8];
  for (int j = 0; j < 8; j++) {
    for (int i = 0; i < 8; i++) {
      actived[i][j] = (random(1) < 0.1)? true : false;
      light[i][j] = 0;
    }
  }
}

// This function calculates the respective frequency of a MIDI note
float midiToFreq(int note) {
  return (pow(2, ((note-69)/12.0)))*440;
}