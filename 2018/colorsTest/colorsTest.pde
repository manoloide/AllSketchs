void setup() {
  size(600, 600, P2D);

  int sub = 16;
  float ss = width*1./sub;
  for (int j = 0; j < sub; j++) {
    for (int i = 0; i < sub; i++) {
      float val = map(i, 0, sub-1, 0, 255);
      if (j == 0) fill(val);
      if (j == 1) fill(val, 0, 0);
      if (j == 2) fill(0, val, 0);
      if (j == 3) fill(0, 0, val);
      if (j == 4) fill(val, val, 0);
      if (j == 5) fill(val, 0, val);
      if (j == 6) fill(0, val, val);
      if (j == 7) fill(val, 255, 255);
      if (j == 8) fill(255, val, 255);
      if (j == 9) fill(255, 255, val);
      if (j == 10) fill(255, 255-val, val);
      if (j == 11) fill(255-val, 255, val);
      if (j == 12) fill(val, 255, 255-val);
      if (j == 13) fill(val, 255-val, 255);
      if (j == 14) fill(255, val, 255-val);
      if (j == 15) fill(255-val, val, 255);
      rect(i*ss, j*ss, ss, ss);
    }
  }
  
  saveFrame("grid.tif");
  saveFrame("grid.tar");
  saveFrame("grid.png");
  saveFrame("grid.jpg");
}