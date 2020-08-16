float gridSize = 10;
int seed = 8;//int(random(99999999));

boolean save = false;

void setup() {
  size(1920, 1080);
  smooth(2);
  pixelDensity(2);
  frameRate(25);
  rectMode(CENTER);
  generate();
}

float values[][];

void draw() {

  if (frameCount%(25*10) == 0) generate();

  float time = millis()*0.001*random(1);
  if (save) time = frameCount/25.;

  randomSeed(seed);
  noiseSeed(seed);

  float amp = random(0.4, 0.6);

  background(0);

  float tt = time*random(3)*random(1)*random(1);

  float lh1 = noise(tt*random(1), 8);
  float lh2 = noise(tt*random(1), 45);
  float lv1 = noise(tt*random(1), 677);
  float lv2 = noise(tt*random(1), 85);

  float oscVel = random(-1, 1)*random(1);
  float oscDesX = random(-1, 1)*random(1)*random(0.6, 1);
  float oscDesY = random(-1, 1)*random(1)*random(0.6, 1);

  float des = random(1000);
  float det = random(0.04)*random(1)*random(0.5, 1);

  boolean oscActive = random(1) < 0.8;
  boolean invActive = random(1) < 0.8;
  boolean noiActive = random(1) < 0.8;
  
  float velLoad = 0.2;//random(0.8)*random(1);
  float fade = 0.99;//random(random(0.95, 1), 1);
  
  fade = 0;
  velLoad = 0;
  

  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      boolean invert = false;
      if (i*1./width < lh1) invert = !invert;
      if (i*1./width > lh2) invert = !invert;
      if (j*1./height < lv1) invert = !invert;
      if (j*1./height > lv2) invert = !invert;
      boolean on = noise(des+i*det, des+j*det, tt) > amp;
      if (!noiActive) on = false;
      float osc = cos(oscVel*time+oscDesX*i+ oscVel*time+oscDesY*j);
      if (oscActive && osc < 0) on = !on;
      if (invActive && invert) on = !on;
      if (on) values[i][j] = lerp(1, values[i][j], velLoad);
      else {
        values[i][j] *= fade;
      }
      noStroke();
      fill(240, values[i][j]*500);
      rect(i*gridSize, j*gridSize, 4, 4);
    }
  }

  if (save) {
    saveFrame("export3/frame####.png");
    if (time >= 60) exit();
  }
}

void keyPressed() {
  generate();
}

int cw, ch;
void generate() {
  seed = int(random(99999999));
  
  randomSeed(seed);
  noiseSeed(seed);
  
  cw = int(width/gridSize);
  ch = int(width/gridSize);
  
  values = new float[cw][ch];
  
  for (int j = 0; j <= ch; j+=gridSize) {
    for (int i = 0; i <= cw; i+=gridSize) {
      values[i][j] = 0;
    }
  }
}
