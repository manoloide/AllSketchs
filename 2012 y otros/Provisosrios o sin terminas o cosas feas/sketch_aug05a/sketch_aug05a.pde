int tam = 40;
float distancia1 = dist(cos(0)*tam/2, sin(0)*tam/2, cos(TWO_PI/3)*tam/2, sin(TWO_PI/3)*tam/2);
float distancia2 = dist(cos(0)*tam/2, sin(0)*tam/2, cos(TWO_PI/6)*tam/2, sin(TWO_PI/6)*tam/2);
float desh;

void setup() {
  size(320, 240);
  desh = tam/2+distancia2/2;
  for ( int j = 0; j < height/tam; j++) {
    for ( int i = 0; i < width/tam; i++) {
      float desv = (i%2==0) ? 0:distancia1/2;
      hexa(i*(desh), j*distancia1+desv, tam/2);
    }
  }
}

void draw() {
}

void hexa(float x, float y, float rad) {
  float porcion = TWO_PI/6;
  beginShape();
  for (int i = 0; i < 6; i++) {
    vertex(x+cos(porcion*i)*rad, y+sin(porcion*i)*rad);
  }
  endShape(CLOSE);
}

