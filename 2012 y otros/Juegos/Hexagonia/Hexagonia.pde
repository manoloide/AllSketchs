int tam = 40;
float distancia1 = dist(cos(0)*tam/2, sin(0)*tam/2, cos(TWO_PI/3)*tam/2, sin(TWO_PI/3)*tam/2);
float distancia2 = dist(cos(0)*tam/2, sin(0)*tam/2, cos(TWO_PI/6)*tam/2, sin(TWO_PI/6)*tam/2);
float desh;
float x = 0, y = 0;

void setup() {
  size(400, 400);
  smooth();
  desh = tam/2+distancia2/2;
}

void draw() {
  translate(x, y);
  background(0);
  float minx = 0, miny = 0, dismin = 1000;
  for ( int j = 0; j < height/tam; j++) {
    for ( int i = 0; i < width/tam; i++) {
      float desv = (i%2==0) ? 0:distancia1/2;
      float xn = i*desh;
      float yn = j*distancia1+desv;
      hexa(xn, yn, tam/2);
      if (dist(xn, yn, mouseX-x, mouseY-y) < dismin) {
        dismin = dist(xn, yn, mouseX-x, mouseY-y);
        minx = xn;
        miny = yn;
      }
    }
  }
  fill(0, 255, 0);
  hexa(minx, miny, tam/2);
  fill(255);
  if (mouseX < 100) {
    x += map(mouseX, 0, 100, 2, 0);
  }
  else if (mouseX > width-100) {
    x -= map(mouseX, width-100, width, 0, 2);
  } 
  if (mouseY < 100) {
    y += map(mouseY, 0, 100, 2, 0);
  }
  else if (mouseY > height-100) {
    y -= map(mouseY, height-100, height, 0, 2);
  }
}

void hexa(float x, float y, float rad) {
  float porcion = TWO_PI/6;
  beginShape();
  for (int i = 0; i < 6; i++) {
    vertex(x+cos(porcion*i)*rad, y+sin(porcion*i)*rad);
  }
  endShape(CLOSE);
}

