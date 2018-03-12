void actualizar() {
  Rama raux;
  Semilla saux;
  stroke(0);
  for (int i = 0; i < ramas.size();i++) {
    raux = (Rama) ramas.get(i);
    raux.draw();
  } 
  for (int i = 0; i < semillas.size();i++) {
    saux = (Semilla) semillas.get(i);
    saux.draw();
  }
}

void fondo() {
  noStroke();
  fill(200, 255, 250);
  rect(0, 0, width, 500);
  fill(87, 193, 2);
  rect(0, 500, width, 600);
}

//dibujar rama... 
void dibujar(float x1, float y1, float x2, float y2, float t1, float t2) {
  float ang, p1x1, p1y1, p1x2, p1y2, p2x1, p2y1, p2x2, p2y2;
  ang = atan2(y1-y2, x1-x2);
  noStroke();
  fill(0);
  p1x1 = x1 + cos(ang+PI/2) * t1/2;
  p1y1 = y1 + sin(ang+PI/2) * t1/2;
  p1x2 = x1 + cos(ang-PI/2) * t1/2;
  p1y2 = y1 + sin(ang-PI/2) * t1/2;
  p2x1 = x2 + cos(ang+PI/2) * t2/2;
  p2y1 = y2 + sin(ang+PI/2) * t2/2;
  p2x2 = x2 + cos(ang-PI/2) * t2/2;
  p2y2 = y2 + sin(ang-PI/2) * t2/2;
  quad(p1x1, p1y1, p1x2, p1y2, p2x2, p2y2, p2x1, p2y1);
  ellipse(x1, y1, t1, t1);
  ellipse(x2, y2, t2, t2);
  fill(255, 100, 60);
  ellipse(p1x1, p1y1, 1, 1);
  ellipse(p1x2, p1y2, 1, 1);
}
