int paleta[] = {
  #058789, 
  #503D2E, 
  #D54B1A, 
  #E3A72F, 
  #F0ECC9
};

void setup() {
  size(600, 800);
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
  stroke(255, 16);
  int des = int(random(2, 8));
  for (int i = -des; i < width+height; i+=des) {
    line(-2, i, i, -2);
  }
  for (int i = 0; i < 500; i++) {
    float x = width*0.5+width*0.5*random(-1, 1)*random(1); 
    float y = height*0.5+height*0.5*random(-1, 1)*random(1); 
    float t = random(20, 100)*random(1)*random(1);
    float a = random(PI);
    int c1 = rcol();
    int c2 = rcol();
    while (c1 == c2) c2 = rcol();
    stroke(0, 4);
    noFill();
    for (int j = 5; j >= 1; j--) {
      strokeWeight(j);
      ellipse(x, y, t, t);
    }
    noStroke();
    fill(c1);
    arc(x, y, t, t, PI*1.5+a, PI*3.5-a, 1);
    fill(c2);
    arc(x, y, t, t, PI*1.5-a, PI*1.5+a, 1);
    
    stroke(rcol());
    float tt = t*0.10;    
    strokeWeight(tt*0.5);
    int cc = int(random(-4, 6));
    for(int k = 0; k < cc; k++){
       cruz(x+t*0.65+tt*k*1.6, y-t*0.25, tt); 
    }
  }
}

void saveImage() {
  int n = (new File(sketchPath)).listFiles().length+1;
  saveFrame(nf(n, 4)+".png");
}

int rcol() {
  return paleta[int(random(paleta.length))];
}

void cruz(float x, float y, float d) {
  float r = d*0.5;
  line(x-r, y-r, x+r, y+r);
  line(x-r, y+r, x+r, y-r);
}
