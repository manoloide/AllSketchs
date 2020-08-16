void setup() {
  size(960, 960);
  rectMode(CENTER);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  background(0);
  translate(width/2, height/2);

  float ss = random(60, 320);
  boolean triangles = (random(1) < 0.5);
  boolean second = (random(1) < 0.5);
  float amp = random(0.4, 1);
  float amp2 = random(0.4, 1);

  float dx = ss * 2 * (3./4);
  float dy = (sqrt(3)*ss)/4;
  int cw = int(width/dx)+2;
  int ch = int(height/dy)+2;

  noFill();
  for (int j = -ch/2; j <= ch/2; j++) {
    for (int i = -cw/2; i <= cw/2; i++) {
      float x = ((j%2==0)? i : i+0.5)*dx;
      float y = j*dy;
      strokeWeight(1);
      stroke(#b49f55);
      //fill(0);
      //hex(x, y, ss);
      if (triangles) hexTri(x, y, ss);

      strokeWeight(ss*0.025);
      noFill();
      hex(x, y, ss*amp);

      if (second) {
        float ang = PI/3;
        float x1 = x+ss*cos(ang)*0.5;
        float y1 = y+ss*sin(ang)*0.5;
        strokeWeight(ss*0.025);
        stroke(#b49f55);
        hex(x1, y1, ss*amp);
        strokeWeight(ss*0.01);
        hex(x1, y1, ss*amp2);
      }
    }
  }
}


void hex(float x, float y, float s) {
  float r = s*0.5;
  float da = TWO_PI/6;

  beginShape();
  for (int i = 0; i < 6; i++) {
    float ang = da*i;  
    vertex(x+cos(ang)*r, y+sin(ang)*r);
  }
  endShape(CLOSE);
}

void hexTri(float x, float y, float s) {
  float r = s*0.5;
  float da = TWO_PI/6;

  for (int i = 0; i < 6; i++) {
    float ang = da*i;  
    float ang2 = da*(i+1);  
    beginShape();
    vertex(x, y);
    vertex(x+cos(ang)*r, y+sin(ang)*r);
    vertex(x+cos(ang2)*r, y+sin(ang2)*r);
    endShape(CLOSE);
  }
}