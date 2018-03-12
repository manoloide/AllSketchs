int seed = int(random(999999));

PGraphics render;
void setup() {
  size(800, 800, P2D);
  smooth(8);
  frameRate(20);
  //pixelDensity(2);
  render = createGraphics(4096, 4096, P2D);
  render.smooth(8);
  generate();
}

float camX = 0; 
float camY = 0;

void draw() {
  background(20);
  //if (frameCount%40 == 0) generate();
  translate(width/2, height/2);
  translate(camX, camY);
  scale(0.18);
  imageMode(CENTER);
  image(render, 0, 0);
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void mouseDragged() {
  camX += mouseX-pmouseX;
  camY += mouseY-pmouseY;
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  render.save(timestamp+".png");
}

void generate() {
  newPallet();
  seed = int(random(999999));

  render.beginDraw();
  render.background(0);

  int cw = int(random(80, random(80, 340)));
  int ch = cw;//int(max(cw*random(0.01, random(0.1, 1)*random(0.1, 1)), 1));
  float ww = render.width*1./cw;
  float hh = render.height*1./ch;

  float minp = 0;//random(1);
  float p1 = randPow(6*random(minp, 1));
  float p2 = randPow(6*random(minp, 1));
  float p3 = randPow(6*random(minp, 1)); 
  float p4 = randPow(6*random(minp, 1));

  render.noStroke();
  float det1 = random(0.006);
  float det2 = random(0.006);
  PVector p;
  float vc1 = int(random(900, 1000))+random(0.01);//random(1000)*random(1);
  float vc2 =  int(random(900, 1000))+random(0.01);//random(1000)*random(1);
  println(vc1, vc2);
  for (int j = -1; j < ch+1; j++) {
    for (int i = -1; i < cw+1; i++) {
      float dd = (i%2==0)? 0 : hh*0.5;
      float dy1 = noise(i*det1, j*det2)*hh-dd;
      float dy2 = noise((i+1)*det1, j*det2)*hh-dd;
      float x1 = (i+0)*ww;
      float x2 = (i+1)*ww;
      float y1 = (j+0)*hh+dy1;
      float y2 = (j+1)*hh+dy2;
      int col = getColor(vc1+vc2+i*vc1+j*vc2);
      render.fill(col);
      render.beginShape();
      p = pointTrans(x1, y1, p1, p2, p3, p4);
      render.vertex(p.x, p.y); 
      p = pointTrans(x2, y1, p1, p2, p3, p4);
      render.vertex(p.x, p.y);
      render.fill(lerpColor(col, color(0), 0.8));
      p = pointTrans(x2, y2, p1, p2, p3, p4);
      render.vertex(p.x, p.y);
      p = pointTrans(x1, y2, p1, p2, p3, p4);
      render.vertex(p.x, p.y);
      render.endShape(CLOSE);
    }
  }
  render.endDraw();
}

float randPow(float val) {
  if (random(1) < 0.5) {
    return random(1, val);
  }
  return 1./random(1, val);
}

PVector pointTrans(float x, float y, float p1, float p2, float p3, float p4) {
  x /= render.width; 
  y /= render.height;

  float sx = (x > 0)? 1 : -1;
  float sy = (y > 0)? 1 : -1;

  x = abs(x);
  y = abs(y);

  float xx = lerp(pow(x, p1), pow(x, p2), y)*render.width;
  float yy = lerp(pow(y, p3), pow(y, p4), x)*render.height;

  return new PVector(xx*sx, yy*sy);
}

int original[] = {#48272A, #0D8DBA, #6DC6D2, #4F3541, #A43409, #BA622A};
int colors[];
void newPallet() {
  colors = new int[original.length]; 
  colorMode(HSB, 360, 100, 100);
  float mod = random(180, 200);
  println(mod);
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