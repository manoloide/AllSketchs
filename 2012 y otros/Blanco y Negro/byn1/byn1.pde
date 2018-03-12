float valores[];

int cant = 300;
int dim = 150;

void setup() {
  size(400, 400);
  valores = new float[cant];
  for (int i = 0; i < cant; i++) {
    valores[i] = ((2*PI)/cant) * i;
  }
  noFill();
  stroke(200, 3);
  background(0);
}

void draw() {
  float x, y;
  //background(0);
  fill(0,20);
  rect(0,0,width,height);
  noFill();
  
  dim = int(dist(width/2,height/2,mouseX,mouseY));
  
  for (int i = 0; i < cant; i++) {
    x = width/2 + cos(valores[i]) * dim/2;
    y = height/2 + sin(valores[i]) * dim/2;
    ellipse(x, y, dim, dim);
    valores[i] += random(0.1);
  }
}

