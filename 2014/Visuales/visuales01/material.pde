class Material {
  void act() {
  }
  void dibujar() {
  }
}  

class MLineas extends Material {
  color col1, col2;
  int cant;
  float tam, ang, des, vel;
  PApplet f;
  MLineas(PApplet f, float tam, float ang, float des) {
    this.f = f;
    this.tam = tam;
    this.ang = ang;
    this.des = des;
    vel = 1;
    col1 = color(0);
    col2 = color(255);
  }
  void act() {
    des += vel;
    des %= tam*2;
    ang += 0.01;
    cant = int(dist(0, 0, width, height)/tam);
    dibujar();
  }
  void dibujar() {
    f.strokeWeight(tam);
    //noStroke();
    for (int i = -cant/2-1; i < cant/2; i++) {
      float dd = (i*tam)+des;
      float x = width/2+cos(ang)*dd;
      float y = height/2+sin(ang)*dd;
      if (i%2 == 0) stroke(col1);
      else stroke(col2);
      float dx = cos(ang+PI/2)*height*2;
      float dy = sin(ang+PI/2)*height*2;
      f.line(x+dx, y+dy, x-dx, y-dy);
      /*
      float tx = cos(ang)*tam/2;
       float ty = sin(ang)*tam/2;
       beginShape();
       vertex(x+dx+tx, y+dy+ty);
       vertex(x-dx+tx, y-dy+ty);
       vertex(x-dx-tx, y-dy-ty);
       vertex(x+dx-tx, y+dy-ty);
       endShape(CLOSE);
       */
    }
    f.strokeWeight(1);
  }
}
