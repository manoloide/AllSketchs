class Forma {
  Punto p1, p2, p3, p4;
  float x, y;

  Forma(float nx, float ny) {
    int cambio = 100;
    x = nx;
    y = ny;
    p1 = new Punto(x+cambio, y+cambio);
    p2 = new Punto(x+cambio, y-cambio);
    p3 = new Punto(x-cambio, y-cambio);
    p4 = new Punto(x-cambio, y+cambio);
  }

  void draw() {
    fill(20,255,40,50);
    stroke(10,240,30);
    strokeWeight(2);
    beginShape();
    curveVertex(p1.x, p1.y);
    curveVertex(p2.x, p2.y);
    curveVertex(p3.x, p3.y);
    curveVertex(p4.x, p4.y);
    curveVertex(p1.x, p1.y);
    curveVertex(p2.x, p2.y);
    curveVertex(p3.x, p3.y);
    endShape();
    fill(255,20,40);
    noStroke();
    ellipse(p1.x,p1.y,5,5);
    ellipse(p2.x,p2.y,5,5);
    ellipse(p3.x,p3.y,5,5);
    ellipse(p4.x,p4.y,5,5);
  }

  void cambiar() {
    p1.x += random(-0.5, 0.5);
    p1.y += random(-0.5, 0.5);
    p2.x += random(-0.5, 0.5);
    p2.y += random(-0.5, 0.5);
    p3.x += random(-0.5, 0.5);
    p3.y += random(-0.5, 0.5);
    p4.x += random(-0.5, 0.5);
    p4.y += random(-0.5, 0.5);
    
    if (dist(p1.x,p1.y,p3.x,p3.y) > 290){
      Punto aux = new Punto(0,0);
      aux.x -= cos(atan2(p1.y-p3.y,p1.x-p3.y))* dist(p1.x,p1.y,p3.x,p3.y)/2;
      aux.y -= sin(atan2(p1.y-p3.y,p1.x-p3.y))* dist(p1.x,p1.y,p3.x,p3.y)/2;
      formas.add(aux);
      noLoop();
    }else if (dist(p2.x,p2.y,p4.x,p4.y) > 400){
      print("dfsdfds"); 
    }
  }
}

