ArrayList<Parti> partis;
Camera camera;
float size = 40;
float dsize = dist(size, 0, 0, size/2);
PShader post;


void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);
  camera = new Camera();
  post = loadShader("post.glsl");
  post.set("resolution", float(width), float(height));
  generate();
}

void draw() {
  background(#21131C);

  pushMatrix();
  camera.update();
  for (int i = 1; i < partis.size(); i++) {
    Parti p = partis.get(i);
    p.update();
  }
  popMatrix();

  if (frameCount%120 == 0) {
    camera.randomPosition();
  }

  post.set("time", millis()/1000.);
  filter(post);
}

void keyPressed() {
  generate();
}

void generate() {
  partis = new ArrayList<Parti>();
  for (int i = 0; i < 120; i++) {
    partis.add(new Parti(new PVector()));
  }
}

class Camera {
  PVector pos, rot;
  PVector vpos, vrot;
  Camera() {
    pos = new PVector();
    rot = new PVector();
    randomPosition();
  }
  void update() {
    pos.add(vpos);
    rot.add(vrot);
    translate(width/2, height/2, 0);
    translate(pos.x, pos.y, pos.z);
    rotateX(rot.x);
    rotateY(rot.y);
    rotateZ(rot.z);
  }

  void randomPosition() {
    pos = new PVector();
    float vp = 0.1;
    float vr = 0.001;
    PVector nrot = new PVector(random(1), random(1), random(1));
    while (nrot.dist(rot) < 0.05) nrot = new PVector(random(1), random(1), random(1));
    rot = nrot;
    vrot = new PVector(random(-vr, vr), random(-vr, vr), random(-vr, vr)); 
    vpos = new PVector(random(-vp, vp), random(-vp, vp), random(-vp, vp));
  }
}

class Parti {
  ArrayList<PVector> points;
  int dir, zcor;
  PVector pos, tar, ant;
  Parti(PVector pos) {
    this.pos = pos;
    this.ant = pos.copy();
    this.tar = pos.copy();
    points = new ArrayList<PVector>();
    randPos();
  }

  void randPos() {
    int ndir = int(random(9));
    while (ndir == dir) ndir = int(random(9));

    dir = ndir;

    if (dir < 6) {
      float des = TWO_PI/6;
      float ang = dir*des;
      tar.add(new PVector(cos(ang)*size, sin(ang)*size));
    } else if (dir < 9) {
      zcor++;
      float des = TWO_PI/3;
      float ang = (dir+zcor)*des;
      float x = cos(ang)*size*0.5;
      float y = sin(ang)*size*0.5;
      float z = dsize;
      tar.add(new PVector(x, y, z));
    }
    /*
    if (dir == 7) {
     tar.add(new PVector(0, 0, -size));
     }
     */

    points.add(pos.copy());
  }

  void update() {
    PVector vel = tar.copy();
    vel.sub(pos);
    vel.mult(0.2);
    ant = pos.copy();
    pos.add(vel);
    if (tar.dist(pos) < 0.04) {
      randPos();
    }
    show();
  }

  void show() {
    stroke(255, 50);
    PVector act, sig;
    sig = points.get(0);
    for (int i = 0; i < points.size()-1; i++) {
      act = points.get(i);
      sig = points.get(i+1);
      line(act.x, act.y, act.z, sig.x, sig.y, sig.z);
    }
    line(sig.x, sig.y, sig.z, pos.x, pos.y, pos.z);
    stroke(255, 220);
    line(ant.x, ant.y, ant.z, pos.x, pos.y, pos.z);
  }
}