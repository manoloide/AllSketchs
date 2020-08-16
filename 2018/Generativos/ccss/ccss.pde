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
  for (int c = 0; c < 2000; c++) {
    float ww = width/pow(2, int(random(2, 9)));
    float hh = width/pow(2, int(random(2, 9)));
    float x = random(width+ww);
    float y = random(height+hh);
    x -= x%ww;
    y -= y%hh;

    float dd = min(ww, hh)*random(1);

    beginShape();
    fill(0, 50);
    vertex(x+ww, y);
    vertex(x+ww, y+hh);
    fill(0, 0);
    vertex(x+ww+dd, y+hh+dd);
    vertex(x+ww+dd, y+dd);
    endShape(CLOSE);

    beginShape();
    fill(0, 50);
    vertex(x, y+hh);
    vertex(x+ww, y+hh);
    fill(0, 0);
    vertex(x+ww+dd, y+hh+dd);
    vertex(x+dd, y+hh+dd);
    endShape(CLOSE);

    fill(rcol());
    beginShape();
    vertex(x, y);
    vertex(x+ww, y);
    vertex(x+ww, y+hh);
    vertex(x, y+hh);
    endShape(CLOSE);

    fill(rcol());
    beginShape();
    fill(0, 6);
    vertex(x+ww, y+hh);
    fill(0, 0);
    vertex(x, y+hh);
    vertex(x, y);
    vertex(x+ww, y);
    endShape(CLOSE);

    fill(rcol());
    beginShape();
    fill(255, 6);
    vertex(x, y);
    fill(255, 0);
    vertex(x+ww, y);
    vertex(x+ww, y+hh);
    vertex(x, y+hh);
    endShape(CLOSE);

    int cw = int(random(1, 20));
    int ch = int(random(1, 20));
    float w = ww*1./cw;
    float h = hh*1./ch;

    for (int j = 0; j < ch; j++) {
      for (int i = 0; i < cw; i++) {
        fill(rcol());
        rect(x+w*i, y+h*j, w, h);
      }
    }

    float shw = random(200)*random(1);
    for (int i = 0; i < cw; i++) {
      float s1, s2;
      s1 = s2 = shw;
      if (i%2 == 0) s1 = 0;
      else s2 = 0;
      beginShape();
      fill(0, s1);
      vertex(x+w*(i+0), y);
      vertex(x+w*(i+1), y);
      fill(0, s2);
      vertex(x+w*(i+1), y+hh);
      vertex(x+w*(i+0), y+hh);
      endShape(CLOSE);
    }

    for (int i = 0; i < ch; i++) {
      float s1, s2;
      s1 = s2 = shw;
      if (i%2 == 0) s1 = 0;
      else s2 = 0;
      beginShape();
      fill(0, s1);
      vertex(x, y+h*(i+0));
      vertex(x, y+h*(i+1));
      fill(0, s2);
      vertex(x+ww, y+h*(i+1));
      vertex(x+ww, y+h*(i+0));
      endShape(CLOSE);
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