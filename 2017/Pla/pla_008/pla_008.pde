int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
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
  newPallet();
  background(rcol());



  seed = int(random(999999));
  background(0);

  int cw = int(random(80, 340));
  int ch = cw;//int(max(cw*random(0.01, 0.1), 1));
  float ww = width*1./cw;
  float hh = height*1./ch;


  float p1 = randPow(8*random(1));
  float p2 = randPow(8*random(1));
  float p3 = randPow(8*random(1));
  float p4 = randPow(8*random(1));

  //p1 = p2 = p3 = p4 = 1.0;

  noStroke();
  float det1 = random(0.006);
  float det2 = random(0.006);
  PVector p;
  float vc1 = 3.01;//random(1000)*random(1);
  float vc2 = 1;//random(1000)*random(1);
  for (int j = -1; j < ch+1; j++) {
    for (int i = -1; i < cw+1; i++) {
      float dd = (i%2==0)? 0 : hh*0.5;
      float dy1 = noise(i*det1, j*det2)*hh-dd;
      float dy2 =noise((i+1)*det1, j*det2)*hh-dd;
      float x1 = (i+0)*ww;
      float x2 = (i+1)*ww;
      float y1 = (j+0)*hh+dy1;
      float y2 = (j+1)*hh+dy1;
      int col = getColor(vc1+vc2+i*vc1+j*vc2);
      fill(col);
      beginShape();
      p = pointTrans(x1, y1, p1, p2, p3, p4);
      vertex(p.x, p.y); 
      p = pointTrans(x2, y1, p1, p2, p3, p4);
      vertex(p.x, p.y);
      fill(lerpColor(col, color(0), 0.8));
      p = pointTrans(x2, y2, p1, p2, p3, p4);
      vertex(p.x, p.y);
      p = pointTrans(x1, y2, p1, p2, p3, p4);
      vertex(p.x, p.y);
      endShape(CLOSE);
      //rect(i*ww, j*hh+dy, ww, hh);
    }
    //poly(random(width), (j+0)*hh+random(hh*2), width*random(0.4)*random(1), 4, rcol(), rcol());
  }
}

float randPow(float val) {
  if (random(1) < 0.5) {
    return random(1, val);
  }
  return 1./random(1, val);
}

PVector pointTrans(float x, float y, float p1, float p2, float p3, float p4) {
  x /= width; 
  y /= height;

  float sx = (x > 0)? 1 : -1;
  float sy = (y > 0)? 1 : -1;

  x = abs(x);
  y = abs(y);

  float xx = lerp(pow(x, p1), pow(x, p2), y)*width;
  float yy = lerp(pow(y, p3), pow(y, p4), x)*height;

  return new PVector(xx*sx, yy*sy);
}

void poly(float x, float y, float s, int res, int c1, int c2) {
  float r = s*0.5; 
  float a = random(TWO_PI); 
  float cr = r*random(0.85); 
  PVector cen = new PVector(x+cos(a)*cr, y+sin(a)*cr); 
  float da = TWO_PI/res; 
  PVector ant, act; 
  for (int i = 1; i <= res; i++) {
    ant = new PVector(x+cos(da*i)*r, y+sin(da*i)*r); 
    act = new PVector(x+cos(da*i+da)*r, y+sin(da*i+da)*r); 
    beginShape(); 
    fill(c1); 
    vertex(ant.x, ant.y); 
    vertex(act.x, act.y); 
    fill(c2); 
    vertex(cen.x, cen.y); 
    endShape();
  }
}

//https://coolors.co/181a99-5d93cc-454593-e05328-e28976
//int colors[] = {#EFF2EF, #9BCDD5, #65C0CB, #308AA5, #308AA5, #85A33C, #F4E300, #E8DBD1, #CE5367, #202219}; 
//int colors[] = {#181A99, #5D93CC, #84ACD6, #454593, #E05328, #E28976};
int original[] = {#48272A, #0D8DBA, #6DC6D2, #4F3541, #A43409, #BA622A};
int colors[];

void newPallet() {
  colors = new int[original.length]; 
  colorMode(HSB, 360, 100, 100);
  float mod = random(360)*random(1)*random(1);
  for (int i = 0; i < original.length; i++) {
    colors[i] = color((hue(original[i])+mod)%360, saturation(original[i]), brightness(original[i]));
  }
  colorMode(RGB, 256, 256, 256);
}

int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}