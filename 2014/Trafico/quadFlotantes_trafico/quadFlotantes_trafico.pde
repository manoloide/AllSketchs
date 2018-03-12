int paleta[] = {
  #512B52, 
  #635274, 
  #7BB0A8, 
  #A7DBAB, 
  #E4F5B1
};

void setup() {
  size(7200, 7200); 
  generar();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else generar();
}

void generar() {
  background(rcol());
  noStroke();
  int maxx = 10;
  int tt = int(pow(2,maxx));
  for (int j = 1; j <= maxx+1; j++) {
    for (int i = 0; i < 40000/tt; i++) {
      int x = int(random(width/tt))*tt;
      int y = int(random(height/tt))*tt;
      stroke(0, 8);
      for(int s = 3; s >= 1; s--){
        strokeWeight(s);
        rect(x, y, tt, tt);
      }
      noStroke();
      fill(rcol());
      rect(x, y, tt, tt);
    }
    tt /= 2;
  }
}

int rcol() {
  return paleta[int(random(paleta.length))];
}

void saveImage() {
  int n = (new File(sketchPath)).listFiles().length;
  saveFrame(nf(n, 3)+".png");
}
