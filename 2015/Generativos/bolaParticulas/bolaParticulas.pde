int paleta[] = {
  #FFE80F, 
  #D7EBF2, 
  #FA2157, 
  #52F097, 
  #FFC981
};

void setup() {
  size(800, 800);
  generar();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else generar();
}

void generar() {
  background(230);
  stroke(236);
  int sep = int(random(10, 32));
  strokeWeight(sep/3);
  for (int i = -int (random (sep)); i < width+height; i+=sep) {
    line(-2, i, i, -2);
  }
  
    for (int j = 0; j < 200; j++) {
    int c1 = rcol();
    int c2 = rcol();
    float x = width/2;
    float y = height/2; 
    float a = random(TWO_PI); 
    float t = random(20, 60);
    float vel = random(0.8, 2);
    noStroke();
    int cc = int(random(80, 220));
    for (int i = 0; i < cc; i++) {
      a += random(-0.1, 0.1);
      x += cos(a)*vel;
      y += sin(a)*vel;
      t *= random(0.98, 1);
      fill(lerpColor(c1, c2, i*1./cc));
      ellipse(x, y, t, t);
      if(t < 0.5) break;
    }
  }

  strokeCap(SQUARE);
  stroke(252);
  for (int i = 0; i < 40; i++) {
    float ang = random(TWO_PI);
    float ss = noise(i)*width/2*random(1);
    float xx = width/2+cos(ang)*ss;
    float yy = height/2+sin(ang)*ss;
    float tt = random(8);
    fill(120, 200);
    noStroke();
    ellipse(xx, yy, tt*4, tt*4);
    noFill();
    stroke(252);
    strokeWeight(tt*0.2);
    float a1 = random(TWO_PI);
    float a2 = a1+random(TWO_PI);
    arc(xx, yy, tt*4, tt*4, a1, a2); 
    stroke(252);
    strokeWeight(tt*0.7);
    line(xx-tt, yy-tt, xx+tt, yy+tt);
    line(xx+tt, yy-tt, xx-tt, yy+tt);
  }  

}

void saveImage() {
  int n = (new File(sketchPath)).listFiles().length-1;
  saveFrame(nf(n, 4)+".png");
}

int rcol() {
  return paleta[int(random(paleta.length))];
}

