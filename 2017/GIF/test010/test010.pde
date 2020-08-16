int fps = 30;
float seconds = 3;
boolean export = true;

int frames = int(fps*seconds);
float time = 0;

void setup() {
  size(640, 640);
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
  translate(width/2, height/2);
  //rotate(PI*time);

  rectMode(CENTER);
  noStroke();
  int cc = 20; 
  int rep = 6; 
  for (int i = 0; i < cc+rep*2; i++) {
    float s = pow(map(i+time*rep-rep, rep, cc+rep, 1, 0), 100)*width*2;
    if (s < 0) continue;
    float w = s;
    float h = s;
    pushMatrix();
    if (time < 0.6) {
      float t = sin(map(time, 0, 0.6, 0, 1)*PI);
      t = easeInOut(t, 0, 1, 2);
      w *= map(t, 0, 1, 1, 10);
      h *= map(t, 0, 1, 1, 0.02);
    } else {
      float t = sin(map(time, 0.6, 1, 0, 1)*PI);
      t = easeInOut(t, 0, 1, 2);
      h *= map(t, 0, 1, 1, 10);
      w *= map(t, 0, 1, 1, 0.02);
      rotate(sin(map(time, 0.7, 1, 0, HALF_PI))*PI);
    }
    if (i%2 == 0) fill(0);
    else fill(255);
    rect(0, 0, w, h, min(w, h));
    popMatrix();
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

float easeInOut (float t, float b, float c, float d) {
  if ((t/=d/2) < 1) return c/2*t*t*t + b;
  return c/2*((t-=2)*t*t + 2) + b;
}