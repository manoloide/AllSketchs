int fps = 30;
float seconds = 5;
boolean export = false;

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
  background(#1A7CB7);
  translate(width/2, height/2);

  ArrayList<PVector> points = new ArrayList<PVector>();
  int cc = 12; 
  float sep = 80;
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float x = sep*(i-cc*0.5);
      float y = sep*(j-cc*0.5);

      int vv = int(time*4);
      float tt = (time%.25)*(5+noise(j, i)*0.3);
      if (tt > 1) tt = 1;

      tt = Easing.QuintInOut(tt, 0, 1, 1);

      float xx = x; 
      float yy = y; 
      float ss = 30-sin(tt*PI)*1;

      if (vv == 0) { 
        xx += (tt*sep)*((j%2 == 0)? -1 : 1);
      }

      if (vv == 1) {
        if ((i%2 == 0) && (j%2 == 0)) xx += sep*tt; 
        if ((i%2 == 1) && (j%2 == 0)) yy += sep*tt; 
        if ((i%2 == 0) && (j%2 == 1)) yy -= sep*tt; 
        if ((i%2 == 1) && (j%2 == 1)) xx -= sep*tt;
      }

      if (vv == 2) {
        yy += (tt*sep)*((i%2 == 0)? -1 : 1);
      }

      if (vv == 3) {
        if ((i%2 == 0) && (j%2 == 0)) xx -= sep*tt; 
        if ((i%2 == 1) && (j%2 == 0)) yy -= sep*tt; 
        if ((i%2 == 0) && (j%2 == 1)) yy += sep*tt; 
        if ((i%2 == 1) && (j%2 == 1)) xx += sep*tt;
      }

      points.add(new PVector(xx, yy, ss));
    }
  }
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    noStroke();
    fill(0, 160);
    ellipse(p.x+8, p.y+8, p.z, p.z);
  }

  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i); 
    noStroke();
    fill(255);
    ellipse(p.x, p.y, p.z, p.z);
  }
}