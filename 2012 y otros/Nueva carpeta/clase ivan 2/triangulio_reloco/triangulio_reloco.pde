float rotacion = 0;

void setup() {
  size(400, 400);
  noFill();
}

void draw() {
  background(255);
  rotacion += 0.1;
  //float ang = map(mouseX, 0, 400, 0,TWO_PI*2);
  //float dis = dist(width/2,height/2,mouseX,mouseY);
  for (int j = 50; j < height; j+=50) {
    for (int i = 50; i < width; i+=50) {
      float dis = dist(i,50,mouseX,mouseY);
      dis = map(dis,0,400,60,0);
      triangulo(i, j, dis, rotacion);
    }
  }
}

void triangulo(float cx, float cy, float rad, float ang) {
  ellipse(cx, cy, rad*2, rad*2);
  float p1x, p1y, p2x, p2y, p3x, p3y;
  float variacion = TWO_PI/3; 
  p1x = cx+cos(ang)*rad;
  p1y = cy+sin(ang)*rad;
  p2x = cx+cos(ang+variacion)*rad;
  p2y = cy+sin(ang+variacion)*rad;
  p3x = cx+cos(ang+variacion*2)*rad;
  p3y = cy+sin(ang+variacion*2)*rad;
  triangle(p1x, p1y, p2x, p2y, p3x, p3y);
}

