ScrollH s1, s2, s3;
PImage lienzo = createImage(600, 600, RGB);
color c;
float tam, antx, anty;

void setup() {
  size(800, 620);
  background(80);
  noStroke();
  frameRate(60);

  nuevoLienzo(lienzo);

  s1 = new ScrollH(620, 200, 170, 10, 0, 255, 0);
  s2 = new ScrollH(620, 220, 170, 10, 0, 255, 0);
  s3 = new ScrollH(620, 240, 170, 10, 0, 255, 0);
  c = color(0);
  tam = 6;
}

void draw() {
  s1.act();
  s2.act();
  s3.act();
  c = color(s1.val, s2.val, s3.val);

  if (mousePressed) {
    //circulo(lienzo, mouseX-10, mouseY-10, tam);
    /*
    int i = (mouseY-10)*lienzo.width+mouseX-10;
     if ((i >= 0) && (i < 600*600)) {
     lienzo.loadPixels();
     lienzo.pixels[i] = color(c);
     lienzo.updatePixels();
     }
     */
    linea(lienzo, antx, anty, mouseX, mouseY, tam);
    antx = mouseX;
    anty = mouseY;
  }

  fill(c);
  rect(620, 10, 170, 170);
  fill(255);
  image(lienzo, 10, 10);
  println(frameRate);
}

void nuevoLienzo(PImage img) {
  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    img.pixels[i] = color(255);
  }
  img.updatePixels();
}

void linea(PImage img, float x1, float y1, float x2, float y2, float dis) {
  float ang, x, y;
  ang = atan2(y1-y2, x1-x2);
  x = cos(ang);
  y = sin(ang);
  for (int i = 0; i <= dist(x1,y1,x2,y2); i++) {
    circulo(img, x1+x*i, y1+y*i, dis);
  }
}

void circulo(PImage img, float cx, float cy, float dis) {
  for (int i = int(round(cy - dis)); i <= cy + dis; i++) {
    int lu = i * img.width;
    for (int j = int(round(cx - dis)); j <= cx+ dis; j++) {
      if ((i>=0)&&(i<img.height)&&(j<img.width)&&(j>=0)) {
        if (dist(j, i, cx, cy) <= dis) {
          img.loadPixels();
          img.pixels[lu+j] = color(c);
          img.updatePixels();
        }
      }
    }
  }
}

