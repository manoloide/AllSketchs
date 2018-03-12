int fps = 30;
float seconds = 8;
boolean export = true;

int frames = int(fps*seconds);
float time = 0;

void setup() {
  size(640, 640);
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
    saveFrame("export/f####.gif");
  }
}

void keyPressed() {
  seed = int(random(9999999));
  println(seed);
}

int seed = 1271405; 
void render() {

  background(255);
  translate(width/2, height/2);

  ArrayList<Circle> circles = new ArrayList<Circle>();
  float da = TWO_PI/3;
  float r = width*(0.15+cos(TWO_PI*time)*0.05);
  float s = width*(0.3-cos(TWO_PI*time)*0.2); 
  for (int i = 0; i < 3; i++) {
    float ang = da*i+time*TWO_PI;
    float xx = cos(ang)*r;
    float yy = sin(ang)*r;
    circles.add(new Circle(xx, yy, s));
  }


  noFill();
  strokeWeight(2);
  blendMode(DARKEST);
  int colors [] = {#F2670A, #0A8FF2, #F20A7A};
  for (int i = 0; i < circles.size(); i++) {
    Circle c = circles.get(i);
    noStroke();
    fill(colors[i%colors.length]);
    c.show();
  }
}

class Circle {
  //ArrayList<Range> ranges;
  float x, y, s;
  Circle(float x, float y, float s) {
    this.x = x; 
    this.y = y; 
    this.s = s; 
    //ranges = new ArrayList<Range>();
  }

  void show() {
    ellipse(x, y, s, s);
  }

  void sub(Circle c) {
  }
}