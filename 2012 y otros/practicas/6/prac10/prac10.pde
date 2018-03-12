int tam = 20;
void setup() {
  size(400, 400);
}
void draw() {
  float mover= map(mouseX,0,width,0,tam/2);
  for (int i = width;i >= tam; i-=tam) {
    if (i%(tam*2) == 0) {
      fill(255);
      ellipse(width/2, height/2, i, i);
    } 
    else {
      fill(0);
      ellipse(width/2+mover, height/2, i, i);
    }
  }
}

