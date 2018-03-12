size(400, 400);
noStroke();
int tam = 40;
for (int j = 0; j < height/tam; j++) {
  for (int i = 0; i < width/tam; i++) {
    if (i!=j) {
      fill(255);
    }
    else {
      fill(0);
    }
    rect(i*tam, j*tam, 40, 40);
  }
}

