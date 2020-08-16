import themidibus.*;

MidiBus midi; // The MidiBus

int gridSize = 10;
int seed = int(random(99999999));

PFont chivo;

PGraphics mask;
float SCALE = 1;
int swidth, sheight;

void settings() {
  swidth = 960;
  sheight = 540;
  size(int(swidth*SCALE), int(sheight*SCALE), P3D);
}

void setup() {
  rectMode(CENTER);

  chivo = createFont("Chivo-Bold", 30, true);

  drawMask();
  initData();

  //MidiBus.list();
  midi = new MidiBus(this, 0, -1);

  generate();
}

float values[][];

void draw() {

  //if (frameCount%(25*10) == 0) generate();

  float time = millis()*0.001*random(0.1, 1)*0.001;

  if (frameCount%(60*4) == 0) generate();
  //if (frameCount%30 == 0) drawMask();

  scale(SCALE);
  randomSeed(seed);
  noiseSeed(seed);

  float amp = random(0.4, 0.6);

  background(0);

  float tt = time*random(3)*random(random(1));

  float lh1 = noise(tt*random(1), 8);
  float lh2 = noise(tt*random(1), 45);
  float lv1 = noise(tt*random(1), 677);
  float lv2 = noise(tt*random(1), 85);

  float oscVel = random(-1, 1)*random(1);
  float oscDesX = random(-1, 1)*random(1)*random(0.6, 1);
  float oscDesY = random(-1, 1)*random(1)*random(0.6, 1);

  float des = random(1000);
  float det = random(0.09)*random(1)*random(0.5, 1);

  boolean oscActive = random(1) < 0.8;
  boolean invActive = random(1) < 0.8;
  boolean noiActive = random(1) < 0.8;
  boolean ranActive = random(1) < 0.8;
  boolean masActive = true;
  
  noiActive = true;
  oscActive = invActive = ranActive = false;

  //invActive = noiActive = ranActive = false;
  //oscActive = true;

  float velLoad = random(0.006, random(random(random(0.5))))*random(0.1, 1);//random(0.0, 1);//random(0.8)*random(1);
  float fade = random(random(1))*random(1);//random(random(0.95, 1), 1);

  //fade = 0;
  //velLoad = 0;

  float timeNoise = time*random(20)*random(random(0.2, 1));
  float ampNoise = random(0.4, 0.6);

  float pwr = random(random(0.2, 1), 1);
  if (random(1) < 0.5) pwr = random(1, random(1, 5));

  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      boolean on = false;
      if (noiActive) on = (noise(des+i*det, des+j*det, tt) > amp)? on : !on;
      if (ranActive) on = (noise(random(100), timeNoise) > ampNoise)? on : !on;
      float osc = cos(oscVel*time+oscDesX*i+ oscVel*time+oscDesY*j);
      if (oscActive && osc < 0) on = !on;

      boolean invert = false;
      if (i*10./swidth < lh1) invert = !invert;
      if (i*10./swidth > lh2) invert = !invert;
      if (j*10./sheight < lv1) invert = !invert;
      if (j*10./sheight > lv2) invert = !invert;
      if (invActive && invert) on = !on;

      if (masActive) {
        if (brightness(mask.get(i, j)) > 200) on = !on;
      }

      if (on) values[i][j] = lerp(values[i][j], 1, velLoad);
      else {
        values[i][j] *= fade;
      }

      noStroke();
      fill(getColor(i*random(1)+j*random(1)+time*random(10000)), pow(values[i][j], pwr)*500);
      rect(i*gridSize, j*gridSize, 4, 4);
    }
  }

  float randomSet = random(-100, 100);
  for (int i = 0; i < randomSet; i++) {
    int xx = int(random(cw));
    int yy = int(random(ch));
    values[xx][yy] = int(random(2));
  }

  //image(mask, 0, 0);

  text(frameRate, 10, 10);
}

void keyPressed() {
  if(key == ' ') generate();
  if(key == 'i') invert();
}

void drawMask() {
  int maskWidth = swidth/gridSize;
  int maskHeight = sheight/gridSize;
  mask = createGraphics(maskWidth, maskHeight);
  mask.beginDraw();
  mask.background(0);
  mask.textFont(chivo);
  mask.textAlign(CENTER, CENTER);
  String words[] = {"test", "not", "problem", "", "", "", ""};
  String word = words[int(random(words.length))];
  mask.text(word, maskWidth*0.5, maskHeight*0.46);
  mask.endDraw();
}

int cw, ch;
void generate() {
  seed = int(random(99999999));

  randomSeed(seed);
  noiseSeed(seed);
  
  drawMask();
}

void initData() {
  cw = int(swidth/gridSize);
  ch = int(sheight/gridSize);
  values = new float[cw][ch];

  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      values[i][j] = 0;
    }
  }
}

void invert(){
  println("ads");
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      values[i][j] = 1-values[i][j];
    }
  }
}

void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn
  println();
  println("Note On:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
  if (channel == 0) {
    int x = int(pitch);
    println(x);
    for (int j = 0; j < ch; j++) {
      values[x][j] = 1;//random(random(1), 1);
    }
  }
  if(channel == 1) invert();
}

void noteOff(int channel, int pitch, int velocity) {
  // Receive a noteOff
  /*
  println();
   println("Note Off:");
   println("--------");
   println("Channel:"+channel);
   println("Pitch:"+pitch);
   println("Velocity:"+velocity);
   */
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

int colors[] = {#FF3D20, #FC9D43, #3998C2, #3E56A8, #090D0E};
//int colors[] = {#687FA1, #AFE0CD, #FDECB4, #F63A49, #FE8141};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}
