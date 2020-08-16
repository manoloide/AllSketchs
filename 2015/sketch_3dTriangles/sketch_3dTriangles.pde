ArrayList<Triangle> triangles;

int pallete[] = {
  #2D4059, 
  #2D4059, 
  #F07B3F, 
  #FFD460
};

void setup() {
  size(960, 960, P3D);
  triangles = new ArrayList<Triangle>();
}

void draw() {
  hint(DISABLE_DEPTH_TEST);
  int vel = 120;
  color c1 = pallete[(frameCount/vel)%pallete.length];
  color c2 = pallete[(frameCount/vel+1)%pallete.length];
  background(lerpColor(c1, c2, sin(PI*0.5*(frameCount%vel)*1./vel)));
  hint(ENABLE_DEPTH_TEST);
  //lights();
  if (mousePressed) {
    for (int i = 0; i < 6; i++) {
      triangles.add(new Triangle(mouseX, mouseY, random(-300)));
    }
  }
  for (int i = 0; i < triangles.size (); i++) {
    Triangle t = triangles.get(i);
    t.update();
    if (t.remove) triangles.remove(i--);
  }
}

class Triangle {
  boolean remove;
  color col;
  float size, time, velocity, maxSize;
  float gravity;
  int maxTime;
  PVector movRot;
  PVector position, direction, rotation;

  Triangle(float x, float y, float z) {
    gravity = 0;
    position = new PVector(x, y, z);
    velocity = random(5)*random(1);
    rotation = new PVector(random(TWO_PI), random(TWO_PI), random(TWO_PI));
    direction = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
    direction.normalize();
    direction.mult(velocity);
    movRot = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
    movRot.normalize();
    movRot.mult(random(0.1)*random(1));
    col = rcol();
    maxSize = random(20, 40);
    maxTime = int(random(40, 80));
  }
  void update() {
    gravity += 0.02+random(0.01);
    time++;
    position.add(direction);
    position.add(new PVector(0, gravity, 0));
    rotation.add(movRot);
    if (time < maxTime) {
      size = map(time, 0, maxTime, 0, maxSize);
    } else {
      size = map(time, maxTime, maxTime+10, maxSize, 0);
      if (time > maxTime+10) remove = true;
    }
    show();
  }
  void show() {
    pushMatrix();
    translate(position.x, position.y, position.z);
    rotateX(rotation.x);
    rotateY(rotation.y);
    rotateZ(rotation.z);
    stroke(0, 140);
    fill(col);
    float da = TWO_PI/3;
    beginShape();
    vertex(cos(da*0)*size, sin(da*0)*size);
    vertex(cos(da*1)*size, sin(da*1)*size);
    vertex(cos(da*2)*size, sin(da*2)*size);
    endShape(CLOSE);
    popMatrix();
  }
}

int rcol() {
  return pallete[int(random(pallete.length))];
}

