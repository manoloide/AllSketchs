int paleta[] = {
  #323E45, 
  #D96879, 
  #FD8579, 
  #FAA157, 
  #FFE5E3
};

void setup() {
  size(600, 600);


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
  stroke(rcol(), 80);
  int tt = int(random(5, 10));
  for (int i = -int (random (tt)); i < width+height; i+=tt) {
    line(-2, i, i, -2);
  }

  for (int c = 0; c < 6; c++) {
    for (int i = 0; i < 40; i++) {
      float x = random(width);
      float y = random(height);
      float t = 10+c*20;//random(2, 80);
      stroke(0, 5);
      noFill();
      for (int j = 6+c; j >= 1; j--) {
        strokeWeight(j);
        ellipse(x, y, t, t);
      }
      noStroke();
      fill(rcol());
      ellipse(x, y, t, t);
    }
  }

  int c = int(random(20));
  for (int i = 0; i < c; i++) {
    int cc = int(random(1, 4)); 
    int x = int(random(width));
    int y = int(random(height));
    int t = int(random(4, 20));
    stroke(rcol());
    for (int j = 0; j < cc; j++) {
      cruz(x+(t*1.4)*j, y, t);
    }
  }

  stroke(rcol());
  noFill();
  strokeWeight(16);
  rect(0, 0, width, height);

  strokeWeight(8);
  for (int i = 0; i < 5; i++) {
    int ttt = int(random(60, 300));
    float x = random(width-ttt);
    float y = random(height-ttt);
    rect(x, y, ttt, ttt);
  }

  strokeWeight(1);

  for (int i = 0; i < 5; i++) {
    int x = int(random(width));
    int y = int(random(height));
    int t = int(random(100, 400));
    color col = color(rcol(), 20);
    degrade(x, y, t, col);
  }
}
void degrade(int x, int y, int t, color col) {
  t = t/2;
  for (int j = y-t; j < y+t; j++) {
    for (int i = x-t; i < x+t; i++) {
      stroke(col, 255-256*(pow(x-i, 2)+pow(y-j, 2))/(t*t));
      point(i, j);
    }
  }
}

void cruz(float x, float y, float t) {
  t /= 2;
  strokeCap(SQUARE);
  strokeWeight(t*random(0.3, 0.7));
  line(x-t, y-t, x+t, y+t);
  line(x+t, y-t, x-t, y+t);
}

int rcol() {
  return paleta[int(random(paleta.length))];
}

void saveImage() {
  int n = (new File(sketchPath)).listFiles().length-1; 
  saveFrame(nf(n, 4)+".png");
}

