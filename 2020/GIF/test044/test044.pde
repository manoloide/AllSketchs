int fps = 15;
float seconds = 50;
boolean export = true;

int frames = int(fps*seconds);
float time = 0;
int cycle = 0;

int seed = 2905337;

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

  hint(DISABLE_DEPTH_TEST);


  translate(width*(0.5+cos(time*TAU)*0.03), height*(0.5+sin(time*TAU)*0.03));

  background(0);
  blendMode(ADD);

  lights();

  sphereDetail(16);

  int cc = (120/3)*4;
  float da = TAU/cc;
  float r = width*0.23;
  noStroke();
  rectMode(CENTER);
  imageMode(CENTER);
  for (int i = 0; i < cc; i++) {
    float a = da*(i+time)+TAU*time;
    float s = 240*(cos(time*TAU+da*i*4)*0.8+0.2);
    pushMatrix();
    translate(cos(a+time*TAU)*r, sin(a+da*i+time*TAU)*r);
    //rotateX(time*TAU*4+(da*i)*0.5);
    //rotateY(time*TAU*3+PI+(da*i));
    //rotateZ(time*PI*6);
    float alp = 8;
    fill(getColor((time*2+i*(1.0/cc))*colors.length*2), alp);
    ellipse(0, 0, s*2, s*2);
    //sphere(s);
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
