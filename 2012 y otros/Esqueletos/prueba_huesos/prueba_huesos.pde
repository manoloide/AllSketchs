Hueso h1;
void setup() {
  size(400, 400);
  smooth();
  h1 = new Hueso(width/2, height/2, 100);
}

void draw() {
  h1.act();
}

