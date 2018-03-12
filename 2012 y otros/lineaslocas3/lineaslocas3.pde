ArrayList puntos;
Punto p1, p2;
float ang, vel, var;

void setup() {
  size(600, 600);
  background(255);
  smooth();
  stroke(0, 50);

  ang =  radians(random(360));
  vel = 2;
  var = 0.1;

  puntos = new ArrayList();
  p1 = new Punto(width/2, height/2);
  
  ang =  atan2(mouseY-p1.y,mouseX-p1.x);
  
  p2 = new Punto(p1.x + cos(ang)*vel, p1.y += sin(ang)*vel);
  puntos.add(p1);
  puntos.add(p2);
}

void draw() {
  if (dist(p2.x,p2.y,mouseX,mouseY) > 50){
  p1 = p2;
  ang =  atan2(mouseY-p1.y,mouseX-p1.x);
  p2 = new Punto(p1.x + cos(ang)*vel, p1.y += sin(ang)*vel);
  line(p1.x, p1.y, p2.x, p2.y);
  puntos.add(p2);

  for (int i = 0; i < puntos.size()-1;i++) {
    Punto aux = (Punto) puntos.get(i);
    if (dist(aux.x, aux.y, p2.x, p2.y)<random(100)) {
      line(aux.x, aux.y, p2.x, p2.y);
    }
  }

  ang += random(-var, var);
  if ((p2.x < 0)||(p2.x > width)||(p2.y < 0)||(p2.y > height)) {
    ang += PI;
  }
  }
}

