int paleta[] = {
  #FF9900, 
  #424242, 
  #E9E9E9, 
  #BCBCBC, 
  #3299BB
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
  background(rcol());
  stroke(250, 20);
  float des = random(2, 5);
  for (int i = -int (random (des)); i < width+height; i+=des) {
    line(i, -2, -2, i);
  }
  for (int i = 0; i < 5000; i++) {
   float x = random(-1.1, 1.1)*(width/2)+width/2; 
     float y = random(-1.1, 1.1)*(height/2)+height/2; 
/*
    float a = random(TWO_PI);
    float d = (width/2)*random(0.7);
    float x = width/2+cos(a)*d;
    float y = height/2+sin(a)*d;
    */
    float ang = random(TWO_PI);
    float t = random(40);
    float vel = random(0.4, 2);
    while (t > 0) {
      ang += random(-0.5, 0.5);
      x += cos(ang)*vel;
      y += sin(ang)*vel;
      t *= random(0.9, 1);
      t -= random(0.1);
      noStroke();
      fill(rcol());
      ellipse(x, y, t, t);
      fill(255, 20);
      arc(x, y, t, t, PI, PI*1.5);
      fill(0, 20);
      arc(x, y, t, t, 0, PI*0.5);
    }
  }
}

void saveImage() {
  int n = 0;//(new File(sketchPath)).listFiles().length-1;
  saveFrame(nf(n, 3)+".png");
}

int rcol() {
  return paleta[int(random(paleta.length))];
}