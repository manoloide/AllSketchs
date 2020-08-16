
void setup() {
  size(960, 960);
  frameRate(30);
  smooth(8);
  generate();
}

void draw() {
  float time = frameCount/30.;
  show(time);
  println(frameRate);



  if (frameCount < 30*50) {
    saveFrame("####.png");
  } else {
    exit();
  }
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String name = nf(day(), 2)+nf(hour(), 2)+nf(minute(), 2)+nf(second(), 2);
  saveFrame(name+".png");
}


float rot;
float ss;
float det;
float des;
float nz;
float dang, dx, dy;

float vr, nv, vz;

void generate() {
  rot = random(TWO_PI);
  ss = 40;
  det = 0.0028;
  des = 220;

  dang = random(TWO_PI);
  dx = 0;
  dy = 0;

  vr = 0.016;
  vz = 0.003;
}

void show(float time) {
  dang += random(0.1, 0.1);
  dx += cos(dang)*0.000016;
  dy += sin(dang)*0.000016;
  nz += vz;

  background(colors[0]);
  noFill();
  stroke(255, 60);

  float diag = dist(0, 0, width, height);
  float md = diag*0.6;
  translate(width/2, height/2);
  rotate(rot+time*vr);
  float sy = (ss*sqrt(3))/2;
  boolean inv = false;
  for (float j = -md; j < md; j+=sy) {
    inv = !inv;
    float dx = (inv)? 0 : ss*0.5;
    for (float i = -md; i < md; i+=ss) {
      float x = i+dx;
      float y = j;
      float r = ss*0.577;
      float da = TWO_PI/6;


      int rot = 0;//int(random(3));
      for (int k = 0; k < 3; k++) {
        float ang = (k+0.25+rot)*da*2;
        PVector aux;
        float col = colors[k+1];
        fill(col);
        beginShape();
        aux = new PVector(x, y);
        aux = des(aux, det, des);
        vertex(aux.x, aux.y);
        aux = new PVector(x+cos(ang)*r, y+sin(ang)*r);
        aux = des(aux, det, des);
        vertex(aux.x, aux.y);
        aux = new PVector(x+cos(ang+da)*r, y+sin(ang+da)*r);
        aux = des(aux, det, des);
        fill(lerpColor(color(col), color(0), 0.2));
        vertex(aux.x, aux.y);
        aux = new PVector(x+cos(ang+da*2)*r, y+sin(ang+da*2)*r);
        aux = des(aux, det, des);
        fill(col);
        vertex(aux.x, aux.y);
        endShape(CLOSE);
      }
    }
  }
}

void circle(float x, float y, float s, float det, float des) {

  float r = s*0.5;
  int res = max(8, int(PI*r*0.5));
  float da = TWO_PI/res;

  beginShape();
  for (int i = 0; i < res; i++) {
    PVector aux = new PVector(x+cos(da*i)*r, y+sin(da*i)*r);
    aux = des(aux, det, des);
    vertex(aux.x, aux.y);
  }
  endShape(CLOSE);
}

PVector des(PVector v, float det, float des) {
  float a = noise(v.x*det+dx, v.y*det+dy)*TWO_PI*2;
  float d = pow(noise(v.x*det, v.y*det, nz), 3);
  float x = v.x+cos(a)*des*d;
  float y = v.y+sin(a)*des*d;
  return new PVector(x, y);
}

int colors[] = {0, 10, 70, 255};
int rcol() {
  return colors[int(random(colors.length))];
}