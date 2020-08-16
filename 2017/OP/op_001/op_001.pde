
void setup() {
  size(960, 960, P3D);
  smooth(8);
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
  background(colors[0]);
  noFill();
  stroke(255, 100);



  float diag = dist(0, 0, width, height);
  float md = diag*0.5;
  translate(width/2, height/2);
  rotate(random(TWO_PI));
  float ss = random(10, 220);
  float sy = (ss*sqrt(3))/2;
  boolean inv = false;


  det = random(0.006);
  des = random(ss*3);
  for (float j = -md; j < md; j+=sy) {
    inv = !inv;
    float dx = (inv)? 0 : ss*0.5;
    for (float i = -md; i < md; i+=ss) {
      float x = i+dx;
      float y = j;
      //ellipse(x, y, 4, 4);
      float r = ss*0.5;
      float da = TWO_PI/6;


      for (int k = 0; k < 3; k++) {
        float ang = k*da*2;
        PVector aux;
        fill(colors[k+1]);
        beginShape();
        aux = new PVector(x, y);
        aux = des(aux);
        vertex(aux.x, aux.y);
        aux = new PVector(x+cos(ang)*r, y+sin(ang)*r);
        aux = des(aux);
        vertex(aux.x, aux.y);
        aux = new PVector(x+cos(ang+da)*r, y+sin(ang+da)*r);
        aux = des(aux);
        fill(lerpColor(colors[k+1], color(0), 0.7));
        vertex(aux.x, aux.y);
        aux = new PVector(x+cos(ang+da*2)*r, y+sin(ang+da*2)*r);
        aux = des(aux);
        fill(colors[k+1]);
        vertex(aux.x, aux.y);
        endShape(CLOSE);
      }
    }
  }
}

float det = 0.05;
float des = 30;
PVector des(PVector v) {
  float a = noise(v.x*det, v.y*det)*TWO_PI*2;
  float d = noise(v.x*det, v.y*det, 100.2);
  float x = v.x+cos(a)*des*d;
  float y = v.y+sin(a)*des*d;
  return new PVector(x, y);
}

int colors[] = {#240603, #4ABABB, #EA8559, #0B62A6, #F5F7DC, #0E1928, #355566, #82B0AD};
int rcol() {
  return colors[int(random(colors.length))];
}