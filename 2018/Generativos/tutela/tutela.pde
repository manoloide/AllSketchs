int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  generate();
}

void draw() {
  generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() { 

  float time = millis()*0.001;
  
  
  if(frameCount%(60*2) == 0) seed = int(random(999999));


  randomSeed(seed);

  background(#DEE1DA);

  int cc = int(random(4, 10));
  float dd = width*1./cc;
  rectMode(CENTER);
  float bb = 2;
  noiseDetail(2);
  stroke(0, 20);
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      fill(rcol());
      float x1 = (i+0.5)*dd;
      float y1 = (j+0.5)*dd;
      float s1 = dd-bb;
      float rou = random(0.5)*random(0.2, 1);
      rect(x1, y1, s1, s1);//, dd*rou);

      float tt = time*random(2);
      float s2 = s1*random(0.5);
      float x2 = x1+(s1-s2)*(noise(x1, y1, tt)-0.5);
      float y2 = y1+(s1-s2)*(noise(y1, x1, tt)-0.5);
      fill(rcol());
      rect(x2, y2, s2, s2);//, ss*rou);

      beginShape();
      fill(0, 40);
      vertex(x1-s1*0.5, y1-s1*0.5);
      vertex(x1+s1*0.5, y1-s1*0.5);
      fill(0, 0);
      vertex(x2+s2*0.5, y2-s2*0.5);
      vertex(x2-s2*0.5, y2-s2*0.5);
      endShape(CLOSE);

      beginShape();
      fill(0, 20);
      vertex(x1-s1*0.5, y1+s1*0.5);
      vertex(x1+s1*0.5, y1+s1*0.5);
      fill(0, 80);
      vertex(x2+s2*0.5, y2+s2*0.5);
      vertex(x2-s2*0.5, y2+s2*0.5);
      endShape(CLOSE);
    }
  }
  //pelos();

  /*
  noStroke();
   beginShape();
   fill(rcol(), random(40));
   vertex(0, 0);
   vertex(width, 0);
   fill(rcol(), random(40));
   vertex(width, height);
   vertex(0, height);
   endShape(CLOSE);
   */

  /*
  noStroke();
   float det = random(0.1);
   float des = random(1000);
   for (int i = 0; i < 20000; i++) {
   float xx = random(width);
   float yy = random(height);
   float ss = random(2)*noise(des+xx*det, des+yy*det);
   fill(0, (1-random(1)*random(0.5, 1))*240);
   ellipse(xx, yy, ss, ss);
   }
   */
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(2, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    fill(col, alp1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(col, alp2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);
  }
}

//int colors[] = {#FDFDFD, #BBC9D4, #6CD1B3, #FB7C69, #3A66E3, #0D2443};
//int colors[] = {#000000, #33346B, #567BF6, #B4CAFB, #FFFFFF, #FFB72A, #FF4C3D};
//int colors[] = {#040001, #050F32, #FFFFFF, #050F32, #26A9C5, #FFFFFF, #E50074};
int colors[] = {#EC629E, #E85237, #ED7F26, #C28A17, #114635, #000000};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}