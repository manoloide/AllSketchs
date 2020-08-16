int fps = 15;
float seconds = 8;
boolean export = false;

int frames = int(fps*seconds);
float time = 0;
int cycle = 0;

int seed = 2905337;

void setup() {
  size(640, 640, P3D);
  smooth(8);
  if (!export) pixelDensity(2);
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

  ///lights();
  
 

  randomSeed(seed);
  noiseSeed(seed);
  background(230);
  translate(width*0.5, height*0.5);
  rotateX(PI*time);
  rotateY(PI*time);
  rotateZ(PI*time);

  line(-200, 0, 0, 200, 0, 0);
  line(0, -200, 0, 0, 200, 0);
  line(0, 0, -200, 0, 0, 200);
  
  rectMode(CENTER);
  if(time < 0.1){
     float v = time*10.;
     noFill();
     stroke(255);
     strokeWeight(v*5);
     rect(0, 0, v*200, v*200);
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
