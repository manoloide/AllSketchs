
void setup() {
  size(960, 960);
  smooth(8);
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
  String name = nf(day(), 2)+nf(hour(), 2)+nf(minute(), 2)+nf(second(), 2);
  saveFrame(name+".png");
}

void generate() {
  background(0);
  float diag = dist(0, 0, width, height);

  float s = random(20, 520);
  int cc = int(random(30));
  boolean vc = random(1) < 0.01;
  float str = random(1, s/((cc+3)*10));

  float vr = TWO_PI/4;//(int(random(1, 10)));
  float minAmp = random(1);
  for (int i = 0; i < 200; i++) {
    float x = random(width);
    float y = random(height);
    float a = random(TWO_PI);
    a -= a%vr;
    float amp = random(minAmp, 1);
    pushMatrix();
    translate(x, y);
    rotate(a);
    noStroke();
    fill(0);
    /*
    rect(0, 0, diag*2, s);
     */
    float ms = s*0.5;
    beginShape();
    vertex(-diag, ms*amp);
    vertex(+diag, ms);
    vertex(+diag, -ms);
    vertex(-diag, -ms*amp);
    endShape(CLOSE);
    if (vc) cc = int(random(30));
    float dd = s/cc;
    noStroke();
    fill(255);
    for (int j = 0; j < cc; j++) {
      float xx = diag;
      float y1 = (j-cc/2+0.5)*dd*amp;
      float y2 = (j-cc/2+0.5)*dd;
      float mstr = str;
      beginShape();
      vertex(-xx, y1-mstr*amp);
      vertex(+xx, y2-mstr);
      vertex(+xx, y2+mstr);
      vertex(-xx, y1+mstr*amp);
      endShape(CLOSE);
      /*
      float dx = ;
       float dy = (j-cc/2+0.5)*dd;
       line(-dx, dy, dx, dy);
       */
    }

    popMatrix();
  }
}

int colors[] = {#240603, #4ABABB, #EA8559, #0B62A6, #F5F7DC, #0E1928, #355566, #82B0AD};
int rcol() {
  return colors[int(random(colors.length))];
}