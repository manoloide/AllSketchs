int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {
  background(rcol());

  noStroke();
  for (int c = 0; c < 100; c++) {
    float ss = width/pow(2, int(random(1, 9)));
    float x = random(width+ss);
    float y = random(height+ss);
    x -= x%ss;
    y -= y%ss;

    float dd = ss*random(1);

    /*
    fill(0, 80);
     beginShape();
     vertex(x, y, ss, ss);
     vertex(x+ss, y, ss, ss);
     fill(0, 0);
     vertex(x+ss+dd, y+dd, ss, ss);
     */



    beginShape();
    fill(0, 50);
    vertex(x+ss, y);
    vertex(x+ss, y+ss);
    fill(0, 0);
    vertex(x+ss+dd, y+ss+dd);
    vertex(x+ss+dd, y+dd);
    endShape(CLOSE);

    beginShape();
    fill(0, 50);
    vertex(x, y+ss);
    vertex(x+ss, y+ss);
    fill(0, 0);
    vertex(x+ss+dd, y+ss+dd);
    vertex(x+dd, y+ss+dd);
    endShape(CLOSE);

    fill(rcol());
    beginShape();
    vertex(x, y);
    vertex(x+ss, y);
    vertex(x+ss, y+ss);
    vertex(x, y+ss);
    endShape(CLOSE);

    fill(rcol());
    beginShape();
    fill(0, 10);
    vertex(x+ss, y+ss);
    fill(0, 0);
    vertex(x, y+ss);
    vertex(x, y);
    vertex(x+ss, y);
    endShape(CLOSE);

    fill(rcol());
    beginShape();
    fill(255, 10);
    vertex(x, y);
    fill(255, 0);
    vertex(x+ss, y);
    vertex(x+ss, y+ss);
    vertex(x, y+ss);
    endShape(CLOSE);

    if (ss > 10 && random(1) < 0.95) {
      float bb = ss*random(0.1, 0.1)*random(0.5, 1);
      int sb = 3;

      int col = rcol();
      fill(0, 12);
      beginShape();
      vertex(x+bb, y+bb);
      vertex(x+ss-bb, y+bb);
      vertex(x+ss-bb+sb, y+bb+sb);
      vertex(x+ss-bb+sb, y+ss-bb+sb);
      vertex(x+bb+sb, y+ss-bb+sb);
      vertex(x+bb, y+ss-bb);
      endShape(CLOSE);

      int cw = int(random(2, 16));
      int ch = int(random(2, 16));
      float dw = (ss-bb*2.)/cw;
      float dh = (ss-bb*2.)/ch;

      if (true) {//dw > sb && dh > sb) {
        dw += sb/(cw-1.);
        dh += sb/(ch-1.);
      }

      for (int j = 0; j < ch; j++) {
        for (int i = 0; i < cw; i++) {
          fill(col);
          beginShape();
          vertex(x+bb+dw*i, y+bb+dh*j);
          vertex(x+bb+dw*(i+1)-sb, y+bb+dh*j);
          vertex(x+bb+dw*(i+1)-sb, y+bb+dh*(j+1)-sb);
          vertex(x+bb+dw*i, y+bb+dh*(j+1)-sb);
          endShape(CLOSE);
          beginShape();
          fill(255, 4);
          vertex(x+bb+dw*i, y+bb+dh*j);
          fill(255, 0);
          vertex(x+bb+dw*(i+1)-sb, y+bb+dh*j);
          vertex(x+bb+dw*(i+1)-sb, y+bb+dh*(j+1)-sb);
          vertex(x+bb+dw*i, y+bb+dh*(j+1)-sb);
          endShape(CLOSE);
        }
      }
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//https://coolors.co/f2f2e8-ffe41c-ef3434-ed0076-3f9afc
int colors[] = {#B14027, #476086, #659173, #9293A2, #262A2C, #D38644};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}

void shuffleArray(int[] array) {
  for (int i = array.length; i > 1; i--) {
    int j = int(random(i));
    int tmp = array[j];
    array[j] = array[i-1];
    array[i-1] = tmp;
  }
}