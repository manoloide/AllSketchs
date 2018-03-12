int tam = 40;

void setup() {
  size(400, 400);
  rectMode(CENTER);
}

void draw() {
  for (int i = 10; i > 0; i--) {
    fill(map(i, 10, 0, 200, 50));
    if (i%2 == 0) {
      rect(width/2, height/2, tam*i, tam*i);
    } 
    else {
      rect(width/2+tam/2, height/2+tam/2, tam*i, tam*i);
    }
  }
}

