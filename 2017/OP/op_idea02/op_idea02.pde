
void setup() {
  size(960, 960);
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
  background(0);

  float s = random(400*random(1));
  PImage tex1 = moisaic(int(random(1, 100)));
  PImage mask = randCircles(int(random(1, 100)), random(600));
  //PImage mask = moisaic(int(random(1, 100)));

  PImage aux = invert(tex1, mask);

  image(aux, 0, 0);
}

PImage moisaic(int c) {
  PGraphics aux = createGraphics(width, height);
  float sw = width*1./c;
  float sh = height*1./c;
  aux.beginDraw();
  for (int j = 0; j < c; j++) {  
    for (int i = 0; i < c; i++) {
      if ((i+j)%2 == 0) aux.fill(0);
      else aux.fill(255);
      aux.rect(i*sw, j*sh, sw, sh);
    }
  }
  aux.endDraw();
  return aux.get();
}

PImage randCircles(int c, float maxSize) {
  PGraphics aux = createGraphics(width, height);
  aux.beginDraw();
  aux.background(0);
  aux.noStroke();
  aux.fill(255);
  for (int i = 0; i < c; i++) {
    float x = random(width);
    float y = random(height);
    float s = random(maxSize);
    aux.ellipse(x, y, s, s);
  }
  aux.endDraw();
  return aux.get();
}

PImage invert(PImage img, PImage mask) {
  PImage aux = createImage(img.width, img.height, RGB);
  for (int i = 0; i < img.pixels.length; i++) {
    float val = brightness(img.pixels[i]);
    if (brightness(mask.pixels[i]) > 127) val = 255-val;
    aux.pixels[i] = color(val);
  }
  return aux;
}

PImage mix(PImage img1, PImage img2, PImage mask) {
  PImage aux = createImage(img1.width, img1.height, RGB);
  for (int i = 0; i < img1.pixels.length; i++) {
    float val = brightness(mask.pixels[i])/255.;
    aux.pixels[i] = lerpColor(img1.pixels[i], img2.pixels[i], val);
  }
  return aux;
}