
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

  float s1 = random(1, 40);
  float s2 = s1;
  if (random(1) < 0.1) s2 *= random(0.5, 2);
  float a = random(TWO_PI);
  float r = (random(1) < 0.5)? HALF_PI : random(PI);
  PImage t1 = tex(s1, a);
  PImage t2 = tex(s2, a+r);
  PImage mask = (random(1) < 0.5)? mosaic(int(random(180)*random(1))) : cubic(int(random(180)*random(1)));
  if (random(1) < 0.3) mask = tex(random(30), random(TWO_PI));
  PImage res = mix(t1, t2, mask);
  image(res, 0, 0);
}

PImage tex(float s, float a) {
  PGraphics aux = createGraphics(width, height);

  float diag = dist(0, 0, width, height);

  aux.beginDraw();
  aux.background(0);
  aux.translate(width/2, height/2);
  aux.rotate(a);
  aux.rectMode(CENTER);
  boolean f = true;
  aux.noStroke();
  aux.fill(255);
  for (float i = -diag; i < diag; i+=s*2) {
    aux.rect(i, 0, s, diag);
  }
  aux.endDraw();


  return aux.get();
}

PImage mix(PImage img1, PImage img2, PImage mask) {
  PImage aux = createImage(img1.width, img1.height, RGB);
  for (int i = 0; i < img1.pixels.length; i++) {
    float val = brightness(mask.pixels[i])/255.;
    aux.pixels[i] = lerpColor(img1.pixels[i], img2.pixels[i], val);
  }
  return aux;
}

PImage mosaic(int s) {
  PGraphics aux = createGraphics(width, height);
  float ss = width*1./s;
  aux.beginDraw();
  aux.noStroke();
  for (float j = 0; j < s; j++) {
    for (float i = 0; i < s; i++) {
      aux.fill(255);
      if ((i+j)%2 == 0) aux.fill(0);
      aux.rect(i*ss, j*ss, ss, ss);
    }
  }
  aux.endDraw();

  return aux.get();
}

PImage cubic(int s) {
  PGraphics aux = createGraphics(width, height);
  aux.beginDraw();
  aux.noStroke();
  aux.rectMode(CENTER);
  for (float i = 0; i < s; i++) {
    float ss = map(i, 0, s, width, 0);
    aux.fill(255);
    if (i%2 == 0) aux.fill(0);
    aux.rect(width/2, height/2, ss, ss);
  }
  aux.endDraw();

  return aux.get();
}

int colors[] = {#240603, #4ABABB, #EA8559, #0B62A6, #F5F7DC, #0E1928, #355566, #82B0AD};
int rcol() {
  return colors[int(random(colors.length))];
}