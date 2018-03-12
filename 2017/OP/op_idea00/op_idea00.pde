
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
  PImage tex1 = circular(s*random(1), random(1), random(1));
  PImage tex2 = circular(s*random(1), random(1), random(1));
  PImage mask = circular(s*random(1), random(1), random(1));

  PImage aux = mix(tex1, tex2, mask);

  image(aux, 0, 0);
}


PImage circular(float s, float x, float y) {
  PGraphics aux = createGraphics(width, height);
  float diag = dist(0, 0, width, height)*2;
  int cc = int(diag*1./s)+1;
  float xx = width*x;
  float yy = height*y;
  aux.beginDraw();
  aux.noStroke();
  for (int i = 0; i < cc; i++) {
    aux.fill(255);
    if (i%2 == 0) aux.fill(0);
    float ss = map(i, 0, cc, diag, 0);
    aux.ellipse(xx, yy, ss, ss);
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