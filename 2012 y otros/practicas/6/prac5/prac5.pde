size(400, 400);
noStroke();
int tam = 40;
for (int j = 0; j < height/tam; j++) {
  for (int i = 0; i < width/tam; i++) {
    if ((i+j)%2 == 0) {
      rect(i*tam, j*tam, 40, 40);
    }
    else {
      ellipse(i*tam+tam/2, j*tam+tam/2, 40, 40);
    }
    
  }
}

