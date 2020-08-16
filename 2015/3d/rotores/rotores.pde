ArrayList<Number> numbers;

PFont helve;
void setup() {
  size(800, 600, P3D);
  smooth(8);
  helve = createFont("Helvetica Neue Bold", 80, true);
  numbers = new ArrayList<Number>();
  for (int j = 0; j < 5; j++) {
    for (int i = 0; i < 4; i++) {
      numbers.add(new Number(220*i, j*100, 0));
    }
  }
}

void draw() {
  background(120);
  //lights();
  //ambientLight(100,100,100);
  for (int i = 0; i < numbers.size (); i++) {
    Number n = numbers.get(i);
    n.update();
    if (n.remove) numbers.remove(i--);
  }
}

class Number {
  boolean remove, rotated;
  float x, y, z, rx;
  int w, h, d;
  int val;
  PImage texture;

  Number(float x, float y, float z) {
    this.x = x; 
    this.y = y;
    this.z = z;  
    w = 200;
    h = 80; 
    d = 80;
    val = int(random(20));
    changeValue(val);
  }

  void update() {
    rx = -frameCount*0.04;
    show();
  }
  void show() {
    pushMatrix();
    translate(x, y, z);
    rotateX(rx);
    textureMode(NORMAL);
    noStroke();
    beginShape();
    texture(texture);
    vertex(-w/2, -h/2, d/2, 0, 0);
    vertex(w/2, -h/2, d/2, 1, 0);
    vertex(w/2, h/2, d/2, 1, 1);
    vertex(-w/2, h/2, d/2, 0, 1);
    endShape();
    fill(10);
    beginShape();
    vertex(-w/2, -h/2, -d/2);
    vertex(w/2, -h/2, -d/2);
    vertex(w/2, h/2, -d/2);
    vertex(-w/2, h/2, -d/2);
    endShape();

    beginShape();
    vertex(-w/2, -h/2, -d/2);
    vertex(w/2, -h/2, -d/2);
    vertex(w/2, -h/2, d/2);
    vertex(-w/2, -h/2, d/2);
    endShape();

    beginShape();
    vertex(-w/2, h/2, -d/2);
    vertex(w/2, h/2, -d/2);
    vertex(w/2, h/2, d/2);
    vertex(-w/2, h/2, d/2);
    endShape();

    beginShape();
    vertex(w/2, -h/2, -d/2);
    vertex(w/2, -h/2, d/2);
    vertex(w/2, h/2, d/2);
    vertex(w/2, h/2, -d/2);
    endShape();

    beginShape();
    vertex(-w/2, -h/2, -d/2);
    vertex(-w/2, -h/2, d/2);
    vertex(-w/2, h/2, d/2);
    vertex(-w/2, h/2, -d/2);
    endShape();

    popMatrix();
  }
  void changeValue(int val) {
    this.val = val;
    PGraphics aux = createGraphics(w, h);
    float bb = (w+h)*0.05;
    aux.beginDraw();
    aux.background(10);
    aux.fill(250);
    aux.textFont(helve);
    aux.textAlign(RIGHT, DOWN);
    aux.textSize(h*0.6);
    aux.text(val, w-bb, h-bb);
    aux.endDraw();
    texture = aux.get();
  }
}
