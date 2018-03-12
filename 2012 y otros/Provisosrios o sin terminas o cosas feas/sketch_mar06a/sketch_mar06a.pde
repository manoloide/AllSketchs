Punto p1, p2;

void setup() {
  size(600, 600);
  frameRate(60);
  background(255);
  stroke(0);
  p1 = new Punto(random(width), random(height));
  p2 = new Punto(random(width), random(height));
  fill(255, 20, 32);
  ellipse(p1.x, p1.y, 5, 5);
  ellipse(p2.x, p2.y, 5, 5);
  
  float m,y,c;
  m = (p1.y-p2.y)/(p1.x-p2.x);
  c = (-m * p1.x)+p1.y;
  for (float x = p1.x; x <= p2.x; x++){
     y = m * x + c;
     point(x,y);
  }
}

