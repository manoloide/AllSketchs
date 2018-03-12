int paleta[] = {
  #512B52, 
  #635274, 
  #7BB0A8, 
  #A7DBAB, 
  #E4F5B1
};

PGraphics render;
float zoom = 1;
int cx, cy;

void setup() {
  size(960, 960);
  render = createGraphics(960, 960);
  generar();
}

void draw() {
  scale(zoom);
  background(40);
  image(render, cx, cy);
}

void keyPressed() {
  if (key == 's') saveImage();
  else generar();
}

void mouseDragged() {
  cx -= (pmouseX-mouseX)*4;
  cy -= (pmouseY-mouseY)*4;
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  zoom += e*0.01;
}

void generar() {
  render.beginDraw();
  render.background(rcol());
  render.noStroke();
  int maxx = 8;
  float tt = width/2.;//int(pow(2, maxx));
  for (int j = 1; j <= maxx+1; j++) {
    for (int i = 0; i < 40000/tt; i++) {
      float x = int(random(render.width));
      float y = int(random(render.height));
      x -= x%tt;
      y -= y%tt;
      render.stroke(0, 4);
      for (int s = 3; s >= 1; s--) {
        render.strokeWeight(s);
        render.rect(x, y, tt, tt);
      }
      render.noStroke();
      render.fill(rcol());
      render.rect(x, y, tt, tt);
    }
    tt /= 2.;
  }
  render.endDraw();
}

int rcol() {
  return paleta[int(random(paleta.length))];
}

void saveImage() {
  render.save(frameCount+".png");
}