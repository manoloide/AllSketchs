size(400, 400);
noStroke();
for (int j = 0; j < height; j+=40) {
  for (int i = 0; i < width; i+=40) {
    if ( (i+j)%80== 0) {
      fill(255);
    }
    else {
      fill(0);
    }
    rect(i, j, 40, 40);
  }
}

