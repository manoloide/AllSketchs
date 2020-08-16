int fps = 30;
float seconds = 4;
boolean export = false;

int frames = int(fps*seconds);
float time = 0;
int cycle = 0;

int seed = 2905337;

void setup() {
  size(640, 640, FX2D);
  //smooth(8);
  //if (!export) pixelDensity(2);
  frameRate(fps);

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

  //println(cycle, time, seed);

  render();

  if (export) {
    if (cycle > 0) exit();
    else saveFrame("export/f####.gif");
  }
}

void render() {
  //println(seed);

  randomSeed(seed);
  noiseSeed(seed);

  background(20);


  int cc = 9;
  float ss = width*1./cc;

  rectMode(CENTER);
  noStroke();
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float tt = time+i*0.02+j*0.02;
      tt = tt%1;
      float dt = tt*5;//PI*4*(0.02+sin(time*PI)*0.98);
      float xx = ss*(i+0.5);
      float yy = ss*(j+0.5);
      float dd = dist(width/2, height/2, xx, yy)*0.25;
      //dd = lerp(dd, dd-dd%1, sin(tt*TAU));
      float s1 = ss*(0.2+cos(tt*TAU)*0.08+cos(dd*TAU+dt*2.0)*0.5);
      float s2 = ss*(0.2+cos(tt*TAU+PI)*0.08+cos(dd*TAU+dt*2.0+PI)*0.5);
      //s1 *= 1+cos((dt+i)*3*TAU)*0.08;
      //s2 *= 1+cos((dt+j)*3*TAU+PI)*0.08;
      strokeWeight(s1*0.2);
      fill(255);
      rect(xx, yy, s1, s2);
      fill(0);
      rect(xx, yy, s1*0.8, s2*0.8);
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
