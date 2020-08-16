int paleta[] = {
  #261C21, 
  #6E1E62, 
  #B0254F, 
  #DE4126, 
  #EB9605
};

int mt = 1; 
float mz = 0.5;

void setup() {
  size(800, 400, P3D);
  generar();
}

void draw() {
  lights();
  generar();
}

void keyPressed() {
  if (key == 's') saveImage();
  else generar();
}

void mousePressed() {
  mt = int(random(1, 10)); 
  mz = random(-2, 2);
}

void saveImage() {
  int n = (new File(sketchPath)).listFiles().length-1;
  saveFrame(nf(n, 4)+".png");
}

void generar() {
  background(rcol());
  float tt = 10*mt; 
  noStroke();
  pushMatrix();
  float det = 0.005;
  for (int j = 0; j < height; j+=tt) {
    for (int i = 0; i < width; i+=tt) {
      pushMatrix();
      float col = noise((i+frameCount*0.1)*det, (j+frameCount)*det)*paleta.length;
      fill(lerpColor(paleta[int(col)], paleta[(int(col)+1)%paleta.length], col%1));
      float x = i+tt/2;
      float y = j+tt/2;
      float z = noise((i+frameCount*0.007), (j+frameCount*0.007))*tt*0.6;
      float zz = dist(x, y, mouseX, mouseY)*mz;
      translate(x, y, z+zz);
      box(tt);
      //rect(i, j, tt, tt);
      popMatrix();
    }
  }
  popMatrix();
}

int rcol() {
  return paleta[int(random(paleta.length))];
}

