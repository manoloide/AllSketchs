int paleta[] = {
  #E4DED0, 
  #ABCCBD, 
  #7DBEB8, 
  #181619, 
  #E32F21
};

void setup() {
  size(600, 800);
  generar();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else generar();
}

void generar() {
  background(rcol());
  strokeWeight(2);
  for (int i = 0; i < 2000; i++) {
    int x = int(random(width));
    int y = int(random(height));
    color c1 = color(rcol());
    color c2 = color(rcol());
    int dx = x;
    int dy = y;
    while (dx > 0 && dy < height) {
      int x1 = dx;
      int y1 = dy;
      int x2 = dx;
      int y2 = dy;
      if (random(1) < 0.5) {
        int cant = int(random(50, 100));
        x2 -= cant;
        y2 += cant;
      } else {
        int cant = int(random(10, 50));
        y2 += cant;
      }
      stroke(c2);
      line(x1, y1+3, x2, y2+3);
      stroke(c1);
      line(x1, y1+1, x2, y2+1);
      dx = x2;
      dy = y2;
    }
    noStroke();
    fill(c2);
    rect(x, y+2, 80, 10);
    fill(c1);
    rect(x, y, 80, 10);
  }
}

int rcol() {
  return paleta[int(random(paleta.length))];
}

void saveImage() {
  int n = (new File(sketchPath)).listFiles().length-1;
  saveFrame(nf(n, 3)+".png");
}
