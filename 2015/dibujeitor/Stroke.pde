class Stroke {
  ArrayList<PVector> vectores;
  color col;
  Stroke() {
    col = color(255, 0, 50);
    vectores = new ArrayList<PVector>();
  }
  void show(PGraphics gra) {
    gra.stroke(col);
    for (int i = 1; i < vectores.size (); i++) {
      PVector ant = vectores.get(i-1);
      PVector act = vectores.get(i);
      //gra.strokeWeight(act.z);
      //gra.line(ant.x, ant.y, act.x, act.y);
      lineSize(gra, ant, act);
    }
  }

  void lineSize(PGraphics gra, PVector p1, PVector p2) {
    lineSize(gra, p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);
  }

  void lineSize(PGraphics gra, float x0, float y0, float s0, float x1, float y1, float s1) {
    float ang = atan2(y1-y0, x1-x0);
    float r = s0*0.5;
    //gra.pushStyle();
    gra.fill(gra.strokeColor);
    gra.noStroke();
    gra.beginShape();
    vertex(x0-cos(ang+HALF_PI)*r, y0-sin(ang+HALF_PI)*r);
    vertex(x0-cos(ang)*r, y0-sin(ang)*r);
    vertex(x0+cos(ang+HALF_PI)*r, y0+sin(ang+HALF_PI)*r);
    r = s1*0.5;
    vertex(x1+cos(ang+HALF_PI)*r, y1+sin(ang+HALF_PI)*r);
    vertex(x1+cos(ang)*r, y1+sin(ang)*r);
    vertex(x1-cos(ang+HALF_PI)*r, y1-sin(ang+HALF_PI)*r);
    gra.endShape(CLOSE);
    gra.ellipse(x1, y1, 2, 2);
    gra.stroke(gra.fillColor);
  }
}
