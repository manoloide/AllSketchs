int fps = 15;
float seconds = 30;
boolean export = false;

int frames = int(fps*seconds);
float time = 0;
int cycle = 0;

int seed = 518072;

PImage sprite;

void setup() {
  size(960, 960, P3D);
  smooth(8);
  if (!export) pixelDensity(2);
  frameRate(fps);

  sprite = loadImage("diente.png");

  background(0);
  generate();
}

void draw() {
  if (export) {
    time = map((frameCount-1)%frames, 0, frames, 0, 1);
    cycle = int((frameCount-1)/frames);
  } else {
    time = map((millis()/1000.)%seconds, 0, seconds, 0, 1);
    cycle = int((millis()/1000.)/seconds);
  }

  render();

  if (export) {
    if (cycle > 0) exit();
    else saveFrame("export/f####.jpg");
  }
}

void render() {

  randomSeed(seed);
  noiseSeed(seed);

  hint(DISABLE_DEPTH_TEST);

  translate(width*0.5, height*0.5);
  background(0);

  rotateX(pow(time, 1.05)*TAU);
  rotateY(pow(time, 0.95)*TAU);

  rectMode(CENTER);

  int cc = int(random(30, 40)*0.9);
  float amp = random(500, 940)/cc;
  noStroke();
  blendMode(ADD);
  float det = random(0.01);
  for (int j = 0; j < cc; j++) {
    pushMatrix();
    translate(0, 0, (j-cc*0.5)*amp);
    fill(getColor(j*0.5+time*colors.length), 15);

    float y1 = constrain(noise(sin(det*j*TAU/cc), 100, sin(time*PI)*3)*3-1, 0, 1);
    float y2 = constrain(noise(100, cos(det*j*TAU/cc), sin(time*PI)*3)*3-1, 0, 1);

    float hh = abs(y1-y2);
    float y = min(y1, y2)+hh*0.5-0.5;
    rotateZ(time*TAU+time*PI+j*1./cc);
    rect(0, y*height*2, width*2, hh*height*2);
    popMatrix();
  }
}

void keyPressed() {

  seed = int(random(9999999));
  generate();
}

void generate() {
  randomSeed(seed);
  noiseSeed(seed);
  println("seed:", seed);
}

int colors[] = {#DD1616, #72522A, #EDF4F9, #EA9FB6, #202DA3};
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
