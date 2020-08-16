import peasy.PeasyCam;
PeasyCam cam;

int seed = int(random(9999999));

public void setup() {
  size(1280, 720, P3D);
  cam = new PeasyCam(this, 400);
}

long timePrev, initTime;
float delta;
float actTime = 0;
public void draw() {

  float fov = PI/2.2;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/10.0, cameraZ*10.0);
    
  long time = (System.currentTimeMillis()-initTime)%100000;
  if (frameCount == 1) {
    initTime = System.currentTimeMillis();
  }
  delta = (time - timePrev -initTime) / 1000.0f;
  actTime += delta;
  timePrev = time;

  noiseSeed(seed);
  randomSeed(seed);

  background(230);

  lights();
  //float time = millis()*0.001;
  time *= 0.001;
  float val = 120;
  directionalLight(val, val*0.4, val, cos(random(10)+random(2)*time), random(10)+cos(random(2)*time), random(10)+cos(random(2)*time));
  directionalLight(val*0.4, val, val, cos(random(10)+random(2)*time), random(10)+cos(random(2)*time), random(10)+cos(random(2)*time));
  directionalLight(val, val, val*0.4, cos(random(10)+random(2)*time), random(10)+cos(random(2)*time), random(10)+cos(random(2)*time));

  float div = int(pow(2, int(random(5, 8))));
  float size = width*0.25;
  noStroke();
  for (int i = 0; i < 100; i++) {
    float x = random(-size, size);
    float y = random(-size, size);
    float z = random(-size, size); 

    float w = div*pow(random(1), 0.8)*5;
    float h = div*pow(random(1), 0.8)*5;
    float d = div*pow(random(1), 0.8)*5;

    if (random(1) < 0.8) {
      x -= x%div;
      y -= y%div;
      z -= z%div;
    }

    pushMatrix();
    translate(x, y, z);
    fill(lerpColor(rcol(), color(255), pow(cos(time*random(40)*random(1)+random(1)), random(1, 2))));
    box(w, h, d);
    popMatrix();
  }
}

void keyPressed() {
  seed = int(random(999999999));
}

int colors[] = {#808080, #000000, #ccff00};
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
  return lerpColor(c1, c2, pow(v%1, 1.4));
}
