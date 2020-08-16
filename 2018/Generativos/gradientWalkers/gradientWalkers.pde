int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%60 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {
  background(0);

  int cc = int(random(8, random(20, 40)));
  float ss = width*1./cc;

  int values[][] = new int[cc][cc];

  noStroke();
  stroke(0, 10);
  noFill();
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      values[i][j] = -1;
      rect(i*ss, j*ss, ss, ss);
    }
  }

  for (int i = 0; i < 100; i++) {
    int xx = int(random(cc));
    int yy = int(random(cc));
    //xx = cc/2; 
    //yy = cc/2;
    int dir = int(random(4));
    int adir = dir;
    int ndir = -1;
    for (int j = 0; j < 200; j++) {
      xx += int(cos(dir*HALF_PI));
      yy += int(sin(dir*HALF_PI));
      adir = dir;
      if (random(1) < 0.25) {
        dir += int(random(-2, 2));
        if (dir < 0) dir = 3;
        if (dir > 3) dir = 0;
      }
      //ndir = (adir+dir+8)%8;
      ndir = dir*2;

      if (xx >= 0 && xx < cc && yy >= 0 && yy < cc) {
        values[xx][yy] = ndir;
      }
    }
  }

  noStroke();
  float ms = ss*0.5;
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float x = i*ss;
      float y = j*ss;
      int val = values[i][j];

      if (val == 0 || val == 4) {
        beginShape();
        fill(0, 0);
        vertex(x, y-ss);
        vertex(x+ss, y-ss);
        fill(0, 240);
        vertex(x+ss, y);
        vertex(x, y);
        endShape(CLOSE);

        beginShape();
        fill(0, 0);
        vertex(x, y+ss*2);
        vertex(x+ss, y+ss*2);
        fill(0, 240);
        vertex(x+ss, y+ss);
        vertex(x, y+ss);
        endShape(CLOSE);
      }

      if (val == 2 || val == 6) {
        beginShape();
        fill(0, 0);
        vertex(x-ss, y+ss);
        vertex(x-ss, y);
        fill(0, 240);
        vertex(x, y);
        vertex(x, y+ss);
        endShape(CLOSE);

        beginShape();
        fill(0, 0);
        vertex(x+ss*2, y+ss);
        vertex(x+ss*2, y);
        fill(0, 240);
        vertex(x+ss, y);
        vertex(x+ss, y+ss);
        endShape(CLOSE);
      }

      if (val == 0) {
        beginShape();
        fill(255);
        vertex(x, y+ss);
        vertex(x, y);
        fill(0);
        vertex(x+ss, y);
        vertex(x+ss, y+ss);
        endShape(CLOSE);
      }

      if (val == 2) {
        beginShape();
        fill(255);
        vertex(x, y);
        vertex(x+ss, y);
        fill(0);
        vertex(x+ss, y+ss);
        vertex(x, y+ss);
        endShape(CLOSE);
      }

      if (val == 4) {
        beginShape();
        fill(0);
        vertex(x, y+ss);
        vertex(x, y);
        fill(255);
        vertex(x+ss, y);
        vertex(x+ss, y+ss);
        endShape(CLOSE);
      }

      if (val == 6) {
        beginShape();
        fill(0);
        vertex(x, y);
        vertex(x+ss, y);
        fill(255);
        vertex(x+ss, y+ss);
        vertex(x, y+ss);
        endShape(CLOSE);
      }

      /*
      if (val == 1) line(x, y+ms, x+ms, y+ss);
       if (val == 3) line(x+ms, y, x, y+ms);
       if (val == 5) line(x+ss, y+ms, x+ms, y);
       if (val == 7) line(x+ms, y+ss, x+ss, y+ms);
       */
    }
  }
}
void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#EE3425, #000000, #D3D3D3, #FEFEFE};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}