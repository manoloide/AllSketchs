/*
click derecho dibujas
click izquierdo cambias posicionas el "clonador"
con la ruedita agrandas/achicar el grosor del pincel... 
*/

int desx, desy;
int punx, puny;
float puntam = 12;

PImage img;

void setup() {
  size(800, 600);
  frame.setResizable(true);
  img = loadImage("http://www.fondoswiki.com/Uploads/fondoswiki.com/ImagenesGrandes/montanas.jpg");
  for(int i = 0; i < 20; i++){
    float tt = random(20, 30);
    int xx = int(random(img.width));
    int yy = int(random(img.height));
    clonarImagen(img, xx, yy, int(random(tt/2, img.width-tt/2)), int(random(tt/2, img.height-tt/2)), tt);
  }
}

void keyPressed(){
   //img = loadImage("http://www.franciscoizuzquiza.com/wp-content/uploads/2014/03/culo.jpg");
   /*
   for(int i = 0; i < 200; i++){
    float tt = random(20, 300);
    clonarImagen(img, int(random(img.width)), int(random(img.height)), int(random(tt/2, img.width-tt/2)), int(random(tt/2, img.height-tt/2)), tt);
  }
  */
}

void draw() {
  background(120);
  translate(desx, desy);
  image(img, 0, 0);

  noFill();
  stroke(120, 80);
  strokeWeight(2);
  ellipse(punx, puny, puntam, puntam);
  point(punx, puny);
  strokeWeight(1);
  stroke(0, 200, 256);
  ellipse(punx, puny, puntam, puntam);
  point(punx, puny);
}

void mouseDragged() {
  if (mouseButton == LEFT) {
    punx -= pmouseX-mouseX; 
    puny -= pmouseY-mouseY;
    int cx = mouseX-desx; 
    int cy = mouseY-desy;
    clonarImagen(img, cx, cy, punx, puny, puntam);
  }
  if (mouseButton == CENTER) {
    desx -= pmouseX-mouseX; 
    desy -= pmouseY-mouseY;
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    int cx = mouseX-desx; 
    int cy = mouseY-desy;
    clonarImagen(img, cx, cy, punx, puny, puntam);
  }
  if (mouseButton == RIGHT) {
    punx = mouseX-desx;
    puny = mouseY-desy;
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  puntam -= e;
}

void clonarImagen(PImage img, int cx, int cy, int punx, int puny, float puntam) {
  int cc = ceil(puntam)/2;
  for (int j = -cc; j <= cc; j++) {
    for (int i = -cc; i <= cc; i++) {
      int xx = cx+i;
      int yy = cy+j;
      int clonx = punx+i;
      int clony = puny+j;
      if (xx < 0 || yy < 0 || clonx < 0 || clony < 0 || xx >= img.width || yy >= img.height || clonx >= img.width || clony >= img.height) continue; 
      float alp = map(dist(cx, cy, xx, yy), 0, cc, 1, 0);
      img.loadPixels();
      img.set(xx, yy, lerpColor(img.get(xx, yy), img.get(clonx, clony), alp));
      img.updatePixels();
    }
  }
}
