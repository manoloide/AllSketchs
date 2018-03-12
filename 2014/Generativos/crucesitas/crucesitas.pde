int paleta[] = {
  #FCEFE1, 
  #FCC07F, 
  #FC6D82, 
  #823954, 
  #070526
};

void setup() {
  size(600, 600);
  generar();
}

void draw() {
}

void generar() {
  background(rcol());
  for (int i = 0; i < 150; i++) {
    if (i%10 == 0) filter(BLUR, 1);
    float x = random(width);
    float y = random(height);
    float t = random(3, 10);
    int c = int(random(1, 15));
    float dx = 0; 
    float dy = 0;
    if (random(1) < 0.5) dx = random(2, 3);
    else dy = random(2, 3);
    strokeWeight(t*0.3); 
    stroke(rcol());
    strokeCap(SQUARE);
    for (int j = -c; j < c; j++) {
      line(x+t*j*dx-t, y+t*j*dy-t, x+t*j*dx+t, y+t*j*dy+t);
      line(x+t*j*dx+t, y+t*j*dy-t, x+t*j*dx-t, y+t*j*dy+t);
    }
  }
  //blendMode(ADD);
  for (int i = 0; i< 100; i++) {
    float x = random(width);
    float y = random(height);
    float t = random(3, 120);
    strokeWeight(1);
    stroke(255, 12);
    fill(255, 8);
    ellipse(x, y, t, t);
  }

  PGraphics gra = createGraphics(width, height);
  gra.beginDraw();
  for (int i = 0; i < 20; i++) {
    float x = random(width);
    float y = random(height);
    float t = random(1, 5);
    int c = int(random(1, 6));
    float dx = 0; 
    float dy = 0;
    dy = random(2, 3);
    gra.strokeWeight(t*random(0.3, 0.9)); 
    gra.stroke(rcol());
    gra.strokeCap(SQUARE);
    for (int j = -c; j < c; j++) {
      float tt = t *random(1, 10);
      gra.line(x, y+t*j*dy, x+tt, y+t*j*dy+tt);
    }
  }
  gra.endDraw();
  PImage aux = gra.get();
  gra.beginDraw();
  gra.clear();
  gra.image(aux,0,0);
  gra.filter(BLUR, 1);
  gra.image(aux, 0, 0);
  gra.endDraw();
  image(gra, 0, 0);
}

void keyPressed() {
  if (key == 's') saveImage();
  else generar();
}

void saveImage() {
  int n = (new File(sketchPath)).listFiles().length-2;
  saveFrame(nf(n, 3)+".png");
}

int rcol() {
  return paleta[int(random(paleta.length))];
}  
