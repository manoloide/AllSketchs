int paleta[] = {
  #87ffe1, 
  #f5871e, 
  #eb4b9b, 
  #faf08c
};

PImage degrade;

void setup() {
  size(1024, 768);
  degrade = degradeLineal(paleta[1], paleta[2], PI/4);
  generar();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else generar();
}

void saveImage() {
  int n = (new File(sketchPath)).listFiles().length+1;
  saveFrame(nf(n, 3)+".png");
}  
void generar() {
  background(rcol());
  image(degrade, 0, 0);
}

int rcol() {
  return paleta[int(random(paleta.length))];
}


PImage degradeLineal(int c1, int c2, float angle) {
  int w = 1024; 
  int h = 1024;
  PGraphics aux =  createGraphics(w, h);
  float diag = dist(0, 0, w, h);
  float md = diag/2+1;
  aux.beginDraw();
  aux.strokeWeight(3);
  
  for(float i = -md; i < md; i++){
      float dx = cos(angle+PI/2)*i;
      float dy = sin(angle+PI/2)*i;
      aux.stroke(lerpColor(color(c1), color(c2), (i+md)/diag));
      aux.line(w/2-cos(angle)*md+dx, h/2-sin(angle)*md+dy, w/2+cos(angle)*md+dx, h/2+sin(angle)*md+dy);
  }
  aux.endDraw();
  return aux.get();
}
