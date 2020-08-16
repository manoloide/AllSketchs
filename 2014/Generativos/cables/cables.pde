int paleta[];

void setup() {
  size(600, 600);
  paleta = new int[6];
  paleta[0] = #FF4646;
  paleta[1] = #512C81;
  paleta[2] = #474848;
  paleta[3] = #DEE3E2;
  paleta[4] = #2C2E2E;
  paleta[5] = #F6FF0A;
  generar();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else generar();
}
void generar() {
  background(30);
  crucez();

  int amount = int(random(2,8));
  for (int i = 0; i < amount; ++i) {
    float x = width/2;//random(width*0.15, width*0.85);
    float y = height/2;//random(height+200*0.15, height+200*0.85);
    float px = x; 
    float py = y;
    float ang = random(PI+PI/2, TWO_PI-PI/2);
    stroke(90);
    strokeWeight(0.6); //<>//
    strokeCap(ROUND);
    noStroke();
    for (int j = 0; j < 500; ++j) {
      fill(rcol());
      pushMatrix();
      ang += random(-0.2, 0.2);
      x += cos(ang);
      y += sin(ang);
      translate(x,y);
      rotate(ang);
      arc(0,0,60,2,0,PI);
      //line(x, y, px, py);
      px = x;
      py = y;
      popMatrix();
    }
  }


  stroke(80);
  strokeWeight(14);
  noFill();
  rect(0, 0, width, height);
}

color rcol(){
   return paleta[int(random(paleta.length))]; 
}
void saveImage() {
  File f = new File(sketchPath);
  int n = f.listFiles().length-1;
  saveFrame(n+".png");
}

void crucez() {
  float des = 14;
  float tt = des*random(0.2, 0.48);
  float tt2 = tt*random(0.3, 0.95);
  strokeWeight(des/8);
  float desx = -random(des);
  float desy = -random(des);
  strokeCap(SQUARE);
  for (float j = 0; j < height/des+1; j++) {
    float yy = desy+des*j;
    stroke(map(j, 0, height, 40, 50));
    for (float i = 0; i < width/des+1; i++) {
      float xx = desx+des*i;
      float t = tt;
      if ((i+j)%2 == 0) t = tt2;
      line(xx-t, yy-t, xx+t, yy+t);
      line(xx-t, yy+t, xx+t, yy-t);
    }
  }
}
