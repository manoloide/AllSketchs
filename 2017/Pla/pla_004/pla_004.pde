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
  background(rcol());



  seed = int(random(999999));
  background(0);

  int cw = int(random(160, 400));
  int ch = int(cw*random(0.3));

  float ww = width*1./cw;
  float hh = height*1./ch;

  noStroke();
  float det = random(0.01);
  for (int i = -1; i < cw+1; i++) {
    float dd = (i%2==0)? 0 : hh*0.5;
    for (int j = -1; j < ch+1; j++) {
      float dy1 = noise(i*det, j)*hh-dd;
      float dy2 = noise((i+1)*det, j)*hh-dd;
      int col = getColor(random(colors.length*2));
      fill(col);
      beginShape();
      vertex((i+0)*ww, (j+0)*hh+dy1); 
      vertex((i+1)*ww, (j+0)*hh+dy2);
      fill(lerpColor(col, color(0), 0.8));
      vertex((i+1)*ww, (j+1)*hh+dy2);
      vertex((i+0)*ww, (j+1)*hh+dy1);
      endShape(CLOSE);
      //rect(i*ww, j*hh+dy, ww, hh);
    }
  }

  /*
  noStroke();
   for (int k = 0; k < 1; k++) {
   int sep = int(random(2, 20));
   int c1 = rcol();//getColor(random(colors.length));
   int c2 = lerpColor(color(c1), rcol(), random(0.9));//lerpColor(color(c1), getColor(random(colors.length)), random(0.4));
   int cc = int(random(1, 30-k*4));
   float dd = (width*1./cc);
   float s1 = dd*random(0.4, 1);
   float s2 = dd*random(0.4, 1);
   int res = int(random(3, 12));
   res = 64;
   for (int dy = 0; dy < cc; dy++) {
   for (int dx = 0; dx < cc; dx++) {
   float xx = (dx+0.5)*dd;
   float yy = (dy+0.5)*dd;
   float ss = map(max(abs(width*0.5-xx), abs(height*0.5-yy)), 0, width*0.5, s1, s2);
   poly(xx, yy, ss, res, c1, c2);
   }
   }
   }
   */
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
int colors[] = {#48272A, #0D8DBA, #6DC6D2, #4F3541, #A43409, #BA622A};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}