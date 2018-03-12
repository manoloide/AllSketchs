void actDis() {
  Disparo aux;
  for (int i = 0; i < disparos.size(); i++) {
    fill(180, 20, 120);
    aux = (Disparo) disparos.get(i);
    int rad = 5;
    if ((aux.x > width+rad)||(aux.x < -rad)||(aux.y > height+rad)||(aux.y < -rad)) {
      disparos.remove(i);
      i--;
    }
    aux.mover();
    aux.draw();
  }
}

void actMalo() {
  Malo aux;
  for (int i = 0; i < malos.size(); i++) {
    fill(120, 80, 20);
    aux = (Malo) malos.get(i);
    int rad = 5;

    Disparo aux2;
    for (int j = 0; j < disparos.size();j++) {
      aux2 = (Disparo) disparos.get(j);
      if (dist(aux.x, aux.y, aux2.x, aux2.y) <= (aux.dim+aux2.dim)/2) {
        println(dist(aux.x, aux.y, aux2.x, aux2.y)+" "+(aux.dim+aux2.dim)/2); 
        puntos += 10;
        disparos.remove(j);
        malos.remove(i);
        i--;
        break;
      }
    }

    aux.mover();
    aux.draw();
  }
}



void vision() {
  Punto c, p1, p2;
  float ang, dif;

  c = new Punto(width/2, height/2);

  ang = atan2(mouseY-c.y, mouseX-c.x);
  dif = PI/8;
  p1 = new Punto(c.x+cos(ang-dif)*400, c.y+sin(ang-dif)*400);
  p2 = new Punto(c.x+cos(ang+dif)*400, c.y+sin(ang+dif)*400);
  fill(0);
  beginShape ();
  if ((p1.x < c.x) && (p2.x < c.x)) {
    if ((p1.y < c.y) && (p2.y < c.y)) {
      vertex(p2.x, p2.y);
      vertex(c.x, c.y);
      vertex(p1.x, p1.y);
      vertex(0, height);
      vertex(width, height);
      vertex(width, 0);
      vertex(0, 0);
      vertex(p2.x, p2.y);
    }
    else {
      vertex(p2.x, p2.y);
      vertex(c.x, c.y);
      vertex(p1.x, p1.y);
      vertex(0, height);
      vertex(width, height);
      vertex(width, 0);
      vertex(0, 0);
      vertex(p2.x, p2.y);
    }
  }
  else {
    if ((p1.y < c.y) && (p2.y < c.y)) {
      vertex(p1.x, p1.y);
      vertex(c.x, c.y);
      vertex(p2.x, p2.y);
      vertex(width, 0);
      vertex(width, height);
      vertex(0, height);
      vertex(0, 0);
      vertex(p1.x, p1.y);
    }
    else {
      vertex(p2.x, p2.y);
      vertex(c.x, c.y);
      vertex(p1.x, p1.y);
      vertex(width, height);
      vertex(width, 0);
      vertex(0, 0);
      vertex(0, height);
      vertex(width, height);
      vertex(p2.x, p2.y);
    }
  }
  endShape ();
}

