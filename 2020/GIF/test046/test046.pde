int fps = 15;
float seconds = 10;
boolean export = false;

int frames = int(fps*seconds);
float time = 0;
int cycle = 0;

int seed = 518072;

PImage sprite;

void setup() {
  size(960, 960, P3D);
  smooth(2);
  if (!export) pixelDensity(2);
  frameRate(fps);

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

  int cc = 200;
  noStroke();
  blendMode(ADD);
  for (int j = 0; j < 8; j++) {
    float v2 = j*1./8;
    float des = width*0.7*v2;
    for (int i = 0; i < cc; i++) {
      float v = i*1./cc;
      float vv = v+sin(v*TAU*5)*0.1;
      float ss = cos((i+vv)*TAU*3)*80*v2*cos((time*1+v2)*TAU);
      float a = (v+time)*TAU;
      fill(getColor(v*colors.length+j), 40);
      ellipse(cos(a)*des*sin(v*TAU*2), sin(a)*des*cos(v*TAU*2+j), ss, ss);
    }
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
