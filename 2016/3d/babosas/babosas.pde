ArrayList<Cosi> cosis;

void setup() {
  size(640, 640, P3D);
  sphereDetail(5);
  cosis = new ArrayList<Cosi>();
}

void draw() {
  if (frameCount%20 == 0) cosis.add(new Cosi());
  background(250);
  //lights();
  noStroke();
  translate(width/2, height/2, 0);
  float v = 1.2;
  rotateX(frameCount*0.03*v);
  rotateY(frameCount*0.0037*v);
  rotateZ(frameCount*0.019*v);
  for (int i = 0; i < cosis.size (); i++) {
    Cosi c = cosis.get(i);
    c.update();
    c.show();
  }
}

class Cosi {
  ArrayList<PVector> points;
  color c1, c2;
  float velocity, amp;
  int cant, seg;
  PVector direction;
  Cosi() {
    points = new ArrayList<PVector>();
    cant = int(random(10, 20));
    for (int i = 0; i < cant; i++) {
      points.add(new PVector());
    }
    velocity = random(0.2, 1.2);
    c1 = color(0);
    c2 = color(255);
    direction = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
  }
  void update() { 
    float rm = 0.12+cos(frameCount*0.1)*0.05;
    direction.add(new PVector(random(-rm, rm), random(-rm, rm), random(-rm, rm)));
    direction.normalize();

    PVector mov = new PVector();
    mov.add(direction);
    mov.mult(velocity);
    points.get(0).add(mov);

    PVector ant = points.get(0);
    float v = 0.2;
    for (int i = 1; i < cant; i++) {
      PVector act = points.get(i);
      float av = v-i*0.008;
      act.x += (ant.x-act.x)*av;
      act.y += (ant.y-act.y)*av;
      act.z += (ant.z-act.z)*av;
      ant = act;
    }
  }

  void show() {
    //stroke(80);
    int cc = 9; 
    float da = TWO_PI/cc;
    for (int i = 1; i < cant; i++) {
      PVector ant = points.get(i-1);
      PVector act = points.get(i);
      float ampAnt = sin(map(i-1, 0, cant-1, 0, PI))*10+1;
      float ampAct = sin(map(i, 0, cant-1, 0, PI))*10+1;
      color colAnt = lerpColor(c1, c2, (i-1.)/cant);
      color colAct = lerpColor(c1, c2, (i+0.)/cant);
      //line(ant.x, ant.y, ant.z, act.x, act.y, act.z);
      if (i == 1 || i == cant-1) {
        colAnt = c1;
        if (i == cant-1) {
          PVector aux = ant;
          ant = act;
          act = aux;
          ampAct = ampAnt;
          colAnt = c2;
        }
        for (int j = 0; j < cc; j++) {
          beginShape();
          fill(colAct);
          vertex(act.x+cos(da*j)*ampAct, act.y+sin(da*j)*ampAct, act.z);
          vertex(act.x+cos(da*(j-1))*ampAct, act.y+sin(da*(j-1))*ampAct, act.z);
          fill(colAnt);
          vertex(ant.x, ant.y, ant.z);
          endShape();
        }
      } else {
        for (int j = 0; j < cc; j++) {
          beginShape();
          fill(colAct);
          vertex(act.x+cos(da*j)*ampAct, act.y+sin(da*j)*ampAct, act.z);
          vertex(act.x+cos(da*(j-1))*ampAct, act.y+sin(da*(j-1))*ampAct, act.z);
          fill(colAnt);
          vertex(ant.x+cos(da*(j-1))*ampAnt, ant.y+sin(da*(j-1))*ampAnt, ant.z);
          vertex(ant.x+cos(da*j)*ampAnt, ant.y+sin(da*j)*ampAnt, ant.z);
          endShape();
        }
      }
      ant = act;
    }
  }
}

