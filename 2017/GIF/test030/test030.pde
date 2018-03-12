int fps = 30;
float seconds = 8;
boolean export = true;

int frames = int(fps*seconds);
float time = 0;

void setup() {
  size(640, 640, P3D);
  smooth(8);
  frameRate(fps);
  background(255);
}

void draw() {
  if (export) time = map((frameCount-1), 0, frames, 0, 1);
  else time = map((millis()/1000.)%seconds, 0, seconds, 0, 1);

  render();

  if (export) {
    if (time >= 1) exit();
    else saveFrame("export/f####.gif");
  }
}

void render() {

  background(40);
  randomSeed(4545);
  translate(width/2, height/2);

  ArrayList<PVector> points = new ArrayList<PVector>();
  //stroke(0, 10);
  for (int i = 0; i < 4000000; i++) {
    float ang = random(TWO_PI);
    float dis = random(1);
    float sis = 0.1+pow(cos(HALF_PI*dis), 0.8)*0.9;
    sis = width*0.1*sis*random(random(0.1, 1), 1);
    dis = width*0.4*dis;
    float xx = cos(ang)*dis;
    float yy = sin(ang)*dis;
    //ellipse(xx, yy, sis, sis);
    boolean add = true;
    for (int k = 0; k < points.size(); k++) {
      PVector p2 = points.get(k); 
      if (dist(xx, yy, p2.x, p2.y) < (sis+p2.z)*0.5) {
        add = false; 
        break;
      }
    }
    if (add) points.add(new PVector(xx, yy, sis));
  }
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    ellipse(p.x, p.y, p.z, p.z);
  }
}