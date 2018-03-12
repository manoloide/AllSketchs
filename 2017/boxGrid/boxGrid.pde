ArrayList<Obj> objects;

void setup() {
  size(displayWidth, displayHeight, P3D); 
  rectMode(CENTER);
  objects = new ArrayList<Obj>();
}

void draw() {
  background(0);
  lights();
  if (frameCount%5 == 0) {
    objects.add(new Grid());
  }
  translate(width/2, height/2, 0);
  for (int i = 0; i < objects.size(); i++) {
    Obj o = objects.get(i);
    o.update();
    if (o.remove) objects.remove(i--);
  }
}

class Obj {
  boolean remove;
  PVector position;
  void update() {
  }
  void show() {
  }
}

class Grid extends Obj {
  int cw, ch;
  float w, h, s;
  boolean fill, ddd;
  int mod;
  float vz;
  Grid() {
    position = new PVector(0, 0, -4000);
    int c = int(random(1, 14))*2+1;
    cw = ch = c;
    w = h = min(width, height);
    mod = int(random(1, 3));
    vz = 40;//random(4, 40);
    fill = (random(1) < 0.5);
    ddd = (random(1) < 0.4);
    s = (w*1./cw)*int(random(1, 9));
  }
  void update() {
    position.z += vz;
    if (position.z > 2000) remove = true;

    show();
  }
  void show() {
    if (fill) {
      noStroke();
      fill(255, 80, 0);
    } else {
      stroke(255, 80, 0);
      noFill();
    }
    if (ddd) {
      fill(255, 80, 0);
      stroke(100, 0, 0);
    }
    //fill(255, 0, 0);
    pushMatrix();
    translate(position.x, position.y, position.z);
    float dx = w/cw;
    float dy = h/ch;
    for (int j = 0; j < ch; j++) {
      for (int i = 0; i < cw; i++) {
        if ((i+j)%mod == 1) {
          if (ddd) {
            pushMatrix();
            translate(dx*(i-cw*0.5+0.5), dy*(j-ch*0.5+0.5), 0);
            box(dx, dy, s);
            popMatrix();
          } else {
            rect(dx*(i-cw*0.5+0.5), dy*(j-ch*0.5+0.5), dx, dy);
          }
        }
      }
    }
    popMatrix();
  }
}