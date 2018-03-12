import processing.video.*;

Capture video;
PImage captura;
boolean espejar = false;
Boton b1;
scrollH s1,s2,s3,s4,s5,s6,s7;
void setup() {
  size(840, 480);
  frameRate(30);
  noStroke();
  //video
  video = new Capture(this, width-200, height);
  captura = createImage(video.width, video.height, RGB);
  //gui
  b1 = new Boton(650, 10, 10, 10, false, "esp");
  s1 = new scrollH(650, 30, 180, 10, -128, 128, 0, "hue");
  s2 = new scrollH(650, 50, 180, 10, -100, 100, 0, "sat");
  s3 = new scrollH(650, 70, 180, 10, -100, 100, 0, "bri");
  s4 = new scrollH(650, 100, 180, 10, -128, 128, 0, "red");
  s5 = new scrollH(650, 120, 180, 10, -128, 128, 0, "gre");
  s6 = new scrollH(650, 140, 180, 10, -128, 128, 0, "blu");
  s7 = new scrollH(650, 160, 180, 10, 0, 1, 0.5, "mes");
  video.start();
}

void draw() {
  if (video.available()) {
    video.read();
    captura = video;
    captura = preProcesar(captura);
  }
  image(captura, 0, 0);
  menu();
  println(frameRate + " " + espejar);
}

void stop() {
  video.stop();
  super.stop();
}

PImage preProcesar (PImage original) {
  PImage procesada = createImage(original.width, original.height, RGB);
  int loc;
  original.loadPixels();
  procesada.loadPixels();
  for (int y=0; y<original.height; y++) {
    for (int x=0; x<original.width; x++) {
      if (espejar) {
        loc = (original.width - x - 1) + y * original.width;
      }
      else {
        loc = x + y * original.width;
      }
      color c = original.pixels[loc];
      colorMode(HSB,256);
      float h = (hue(c)+s1.val+256)%256;
      float s = saturation(c)+s2.val;
      float br = brightness(c)+s3.val;
      color n = color(h,s,br);
      colorMode(RGB,256);
      float r = red(c) + s4.val;
      float g = green(c) + s5.val; 
      float b = blue(c) + s6.val;
      n = lerpColor(n,color(r,g,b),s7.val);
      procesada.pixels[x + y * original.width] = n;
    }
  }
  procesada.updatePixels();
  original.updatePixels();
  return procesada;
}
