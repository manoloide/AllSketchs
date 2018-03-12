int paleta[] = {
  #8100C1, 
  #4EEDE7, 
  #FB5899, 
  #FBE427, 
  #CCCCCC
};

void setup() {
  size(600, 600);
  generar();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else generar();
}

void generar() {
  backDeg();

  backLines();

  for (int i = 0; i < 10; i ++) {
    color col = rcol();
    float x = random(width);
    float y = random(height);
    float d = random(width*0.2);

    noStroke();
    fill(col);
    ellipse(x, y, d*0.5, d*0.5);
    noFill();
    stroke(col);
    strokeWeight(d *0.15 );
    ellipse(x, y, d, d);
    
    }

    polyDef(width/2, height/2, width*0.4, 4, PI/4, random(0.3));


  /*
  for (int j = 0; j < height; j++) {
   for (int i = 0; i < width; i++) {
   color col = lerpColor(get(i, j), color(random(256)), j*0.2/height); 
   set(i, j, col);
   }
   }
   */
}

void backDeg() {
  color bc1 = rcol();
  color bc2 = rcol();
  for (int j = 0; j < height; j++) {
    color col = lerpColor(bc1, bc2, j*0.2/height); 
    for (int i = 0; i < width; i++) {
      set(i, j, col);
    }
  }
}

void backLines() {
  float ang = random(TWO_PI/2);
  float x = -width*0.5;
  float y = height/2;
  float d = (width+height);
  float da = random(PI*0.2);
  float am1 = 40;
  float am2 = 20;
  noStroke();
  fill(rcol(), 60);
  for (int i = 0; i < 5; i++) {
    beginShape();
    vertex(x-cos(ang+da*i)*d + cos(ang+da*i+HALF_PI) *am1, y-sin(ang+da*i)*d + sin(ang+da*i+HALF_PI) *am1);
    vertex(x-cos(ang+da*i)*d + cos(ang+da*i-HALF_PI) *am1, y-sin(ang+da*i)*d + sin(ang+da*i-HALF_PI) *am1);
    vertex(x+cos(ang+da*i)*d + cos(ang+da*i-HALF_PI) *am2, y+sin(ang+da*i)*d + sin(ang+da*i-HALF_PI) *am2);
    vertex(x+cos(ang+da*i)*d + cos(ang+da*i+HALF_PI) *am2, y+sin(ang+da*i)*d + sin(ang+da*i+HALF_PI) *am2);
    endShape(CLOSE);
  }
}

void polyDef(float x, float y, float r, int c, float ang, float n) {
  float da = TWO_PI/c;
  for (int i = 0; i < 5; i++) {
    strokeWeight(random(8));
    stroke(rcol());
    noFill();
    beginShape();
    for (int l = 0; l < c; l++) {
      float a = da*l+ang;
      float d = r * (1+random(n));
      vertex(x+cos(a)*d, y+sin(a)*d);
    }
    endShape(CLOSE);
  }
}

void saveImage() {
  int n = (new File(sketchPath)).listFiles().length-1;
  saveFrame(nf(n, 4)+".png");
}

int rcol() {
  return paleta[int(random(paleta.length))];
}
