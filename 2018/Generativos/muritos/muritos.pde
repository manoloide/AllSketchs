int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
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

  background(rcol());

  lights();

  for (int k = 0; k < 1; k++) {
    pushMatrix();
    float fov = PI/random(1.02, 2.6);
    float cameraZ = (height/2.0) / tan(fov/2.0);
    perspective(fov, float(width)/float(height), cameraZ/100.0, cameraZ*100.0);

    translate(width/2, height/2, 0);
    float mr = HALF_PI*0.14;
    rotateX(random(-mr, mr));
    rotateY(random(-mr, mr));
    rotateZ(random(TWO_PI));

    int cc = int(random(8, 160));
    float ss = width*4./cc;
    float a1 = random(0.6, 0.95);
    float a2 = random(0.1, 0.3);
    noStroke();
    fill(rcol());
    for (int j = 0; j < cc; j++) {
      for (int i = 0; i < cc; i++) {
        float ww = ss*a1;
        float hh = ss*a2;
        if ((i+j)%2==0) {
          ww = hh;
          hh = ss*a1;
        }
        box((i-cc*0.5)*ss, (j-cc*0.5)*ss, -ss*3+200, ww, hh, ss*6, ss);
      }
    }
    popMatrix();
  }
}

void box(float x, float y, float z, float w, float h, float d, float s) {
  int c1 = rcol();
  int c2 = rcol();
  float mw = w*0.5;
  float mh = h*0.5;
  float md = d*0.5;
  float ms = s*0.5;
  pushMatrix();
  translate(x, y, z);
  beginShape();
  fill(c1);
  vertex(-mw, -mh, md);
  vertex(+mw, -mh, md);
  vertex(+mw, +mh, md);
  vertex(-mw, +mh, md);
  endShape(CLOSE);

  fill(c2);
  beginShape();
  vertex(-ms, -ms, -md);
  vertex(+ms, -ms, -md);
  vertex(+ms, +ms, -md);
  vertex(-ms, +ms, -md);
  endShape(CLOSE);

  beginShape();
  fill(c2);
  vertex(-ms, -ms, -md);
  vertex(+ms, -ms, -md);
  fill(c1);
  vertex(+mw, -mh, +md);
  vertex(-mw, -mh, +md);
  endShape(CLOSE);

  beginShape();
  fill(c2);
  vertex(-ms, +ms, -md);
  vertex(+ms, +ms, -md);
  fill(c1);
  vertex(+mw, +mh, +md);
  vertex(-mw, +mh, +md);
  endShape(CLOSE);

  beginShape();
  fill(c2);
  vertex(-ms, -ms, -md);
  vertex(-ms, +ms, -md);
  fill(c1);
  vertex(-mw, +mh, +md);
  vertex(-mw, -mh, +md);
  endShape(CLOSE);

  beginShape();
  fill(c2);
  vertex(+ms, -ms, -md);
  vertex(+ms, +ms, -md);
  fill(c1);
  vertex(+mw, +mh, +md);
  vertex(+mw, -mh, +md);
  endShape(CLOSE);
  //box(w, h, d);
  popMatrix();
}



void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#FACD00, #FB4F00, #F277C5, #7D57C6, #00B187, #3DC1CD};
//int colors[] = {#F19617, #251207, #15727F, #CEAB81, #BD3E36};
//int colors[] = {#FFDA05, #E01C54, #E92B1E, #E94F17, #125FA4, #6F84C5, #54A18C, #F9AB9D, #FFEA9F, #131423};
//int colors[] = {#5C9FD3, #F19DA2, #FEED2D, #9DC82C, #33227E};
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