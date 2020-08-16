ArrayList<Particle> particles;

void setup() {
  size(440, 1080, P3D);
  frameRate(60);
  ((javax.swing.JFrame) frame).getContentPane().setBackground(new java.awt.Color(#000000));
  particles = new ArrayList<Particle>();
}

void draw() {
  //lights();
  //background(0);
  fill(0, 4);
  rect(0, 0, width, height);
  for (int i = 0; i < 5; i++)
    particles.add(new Particle(random(-240, width+240), random(-200, -140)));

  for (int i = 0; i < particles.size (); i++) {
    Particle p = particles.get(i);
    p.moved();
  }
  for (int i = 0; i < particles.size (); i++) {
    Particle p = particles.get(i);
    p.update();
    if (p.remove) particles.remove(i--);
    p.show();
  }
}

class Particle {
  ArrayList<Particle> brothers;
  boolean remove;
  color col;
  float size; 
  PVector position, des;
  Particle(float x, float y) {
    brothers = new ArrayList<Particle>();
    position = new PVector(x, y);
    des = new PVector();
    size = random(2, 12);
    col = color(random(256), random(256), random(256));
  }
  void moved() {
    des = new PVector();
    float distance = 60;
    for (int i = 0; i < brothers.size (); i++) {
      Particle p = brothers.get(i);
      float dis = position.dist(p.position);
      float vel = (dis-distance)*0.12;
      PVector vec = new PVector(p.position.x, p.position.y, p.position.z);
      vec.sub(position);
      vec.normalize();
      vec.mult(vel); 
      des.add(vec);
    }
  }
  void update() {
    if (brothers.size() < 6) {
      searchBrothers();
    }
    position.add(des);
    float det = 0.01;
    float vel = 2.5;
    position.add(new PVector(0, (noise(position.x*det, position.y*det)+0.2)*vel));
    if (position.y-size > height) remove = true;
  }

  void show() {

    /*
    noStroke();
     pushMatrix();
     translate(position.x, position.y, position.z);
     //sphere(size);
     ellipse(0, 0, size, size);
     popMatrix();*/

    stroke(255);
    //showFill();
    showConnections();
  }

  void showFill() {
    for (int i = 0; i < brothers.size (); i++) {
      Particle b = brothers.get(i);
      for (int j = 0; j < b.brothers.size (); j++) {
        Particle a = b.brothers.get(j);
        if (brothers.contains(a)) {
          beginShape();
          fill(col);
          vertex(position.x, position.y, position.z);
          fill(a.col);
          vertex(a.position.x, a.position.y, a.position.z);
          fill(b.col);
          vertex(b.position.x, b.position.y, b.position.z);
          endShape(CLOSE);
        }
      }
    }
  }

  void showConnections() {
    for (int i = 0; i < brothers.size (); i++) {
      Particle p = brothers.get(i);
      float dist = position.dist(p.position);
      //strokeWeight(map(dist, 200, 0, 0, 4));
      stroke(map(dist, 40, 0, 180, 255), 120);
      line(position.x, position.y, position.z, p.position.x, p.position.y, p.position.z);
    }
  }

  void searchBrothers() {
    float disMax = 200;
    for (int i = 0; i < particles.size (); i++) {
      Particle p = particles.get(i);
      if (p == this || brothers.contains(p)) continue;
      float dis = position.dist(p.position);
      if (dis < disMax) {
        brothers.add(p);
        if (brothers.size() >= 6) {
          break;
        }
      }
    }
  }

  void connect(Particle p) {
    if (!brothers.contains(p) && p.brothers.size() < 6) {
      brothers.add(p);
      p.connect(this);
    }
  }
}

