int gridSize = 10;
int seed = int(random(99999999));

PFont chivo;
PGraphics mask;

void setup() {
  size(1920, 1080, P3D);
  rectMode(CENTER);

  chivo = createFont("Chivo-Bold", 30, true);

  drawMask();
  initData();

  generate();
}

float values[][];

void draw() {

  //if (frameCount%(25*10) == 0) generate();

  float time = millis()*0.001*random(0.1, 1);

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
  float det = random(0.04)*random(1)*random(0.5, 1);

  boolean oscActive = random(1) < 0.6;
  boolean invActive = random(1) < 0.6;
  boolean noiActive = random(1) < 0.6;
  boolean ranActive = random(1) < 0.6;
  boolean masActive = true;

  oscActive = false;

  float velLoad = 0.02*random(1);//random(0.8)*random(1);
  float fade = 0.2;//random(random(0.95, 1), 1);

  //fade = 0;
  //velLoad = 0;
  
  if(frameCount%(60*20) == 0) generate();

  if (frameCount%30 == 0) drawMask();


  float timeNoise = time*random(20)*random(random(0.2, 1));
  float ampNoise = random(0.4, 0.6);

  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      boolean on = false;
      if (noiActive) on = (noise(des+i*det, des+j*det, tt) > amp)? on : !on;
      if (ranActive) on = (noise(random(100), timeNoise) > ampNoise)? on : !on;
      float osc = cos(oscVel*time+oscDesX*i+ oscVel*time+oscDesY*j);
      if (oscActive && osc < 0) on = !on;

      boolean invert = false;
      if (i*10./width < lh1) invert = !invert;
      if (i*10./width > lh2) invert = !invert;
      if (j*10./height < lv1) invert = !invert;
      if (j*10./height > lv2) invert = !invert;
      if (invActive && invert) on = !on;

      if (masActive) {
        if (brightness(mask.get(i, j)) > 200) on = !on;
      }

      if (on) values[i][j] = lerp(values[i][j], 1, velLoad);
      else {
        values[i][j] *= fade;
      }

      noStroke();
      fill(240, values[i][j]*500);
      rect(i*gridSize, j*gridSize, 4, 4);
    }
  }

  //image(mask, 0, 0);

  text(frameRate, 10, 10);
}

void keyPressed() {
  generate();
}
void drawMask() {
  int maskWidth = width/gridSize;
  int maskHeight = height/gridSize;
  mask = createGraphics(maskWidth, maskHeight);
  mask.beginDraw();
  mask.background(0);
  mask.textFont(chivo);
  mask.textAlign(CENTER, CENTER);
  String words[] = {"test", "not", "problem"};
  String word = words[int(random(words.length))];
  mask.text(word, maskWidth*0.5, maskHeight*0.46);
  mask.endDraw();
}

int cw, ch;
void generate() {
  seed = int(random(99999999));

  randomSeed(seed);
  noiseSeed(seed);
}

void initData() {
  cw = int(width/gridSize);
  ch = int(width/gridSize);

  values = new float[cw][ch];

  for (int j = 0; j <= ch; j+=gridSize) {
    for (int i = 0; i <= cw; i+=gridSize) {
      values[i][j] = 0;
    }
  }
}
