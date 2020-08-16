int fps = 30;
float seconds = 4;
boolean export = false;

int frames = int(fps*seconds);
float time = 0;

void setup() {
  size(640, 640, P3D);
  smooth(8);
  frameRate(fps);
}

void draw() {
  if (export) time = map(frameCount-1, 0, frames, 0, 1);
  else time = map((millis()/1000.)%seconds, 0, seconds, 0, 1);

  render();

  if (export) {
    if (time >= 1) exit();
    else saveFrame("export/f####.gif");
  }
}

void render() {

  background(0);

  float fov = PI/1.6;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/100.0, cameraZ*100.0);


  translate(width/2, height/2, 0);
  //scale(1.4+cos(TWO_PI*time)*0.2);
  rotateX(HALF_PI);

  rotateZ(-TWO_PI*time);
  //rotateY(cos(time*PI)*HALF_PI);

  float detail = 120;
  float detail2 = 80;
  float maxSize = 800;
  float size = 400;
  stroke(255);
  noFill();
  strokeWeight(1);
  float da = TWO_PI/detail2;
  for (float i = 0; i < detail; i++) {
    float d1 = map(i, 0, detail, 0, TWO_PI); 
    float d2 = map(i+1, 0, detail, 0, TWO_PI); 
    float h1 = cos(d1)*size;
    float h2 = cos(d2)*size;
    float r1 = (maxSize*1.1f + sin(d1) * maxSize)*0.5;
    float r2 = (maxSize*1.1f + sin(d2) * maxSize)*0.5;
    noStroke();
    stroke(0, 40);
    float det = 20;
    for (float j = 0; j < detail2; j++) {
      float a1 = da*j; 
      float a2 = da*(j+1); 
      fill(getColor(noise(i*det, j*det, 10+sin(time*TWO_PI+j))*colors.length));
      beginShape();
      vertex(cos(a1)*r1, sin(a1)*r1, h1);
      vertex(cos(a2)*r1, sin(a2)*r1, h1);
      vertex(cos(a2)*r2, sin(a2)*r2, h2);
      vertex(cos(a1)*r2, sin(a1)*r2, h2);
      endShape(CLOSE);
    }
  }
}

int colors[] = {#000000, #000000, #EA1A40, #50BBEA};
int rcol() { 
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = v%(colors.length);
  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  float m = v%1;
  m = pow(m, 2);
  return lerpColor(c1, c2, m);
}