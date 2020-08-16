int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() { 


  randomSeed(seed);

  background(rcol());

  ArrayList<PVector> p = new ArrayList<PVector>();
  for (int i = 0; i < 1000; i++) {
    p.add(new PVector(random(-50, width+50), random(-50, height+50)));
  }
  float maxDis =50;
  stroke(255, 30);
  for (int i = 0; i< p.size(); i++) {
    PVector p1 = p.get(i);
    float s = random(2);
    fill(255);
    ellipse(p1.x, p1.y, s, s);
    for (int j = i+1; j < p.size(); j++) {
      PVector p2 = p.get(j);
      float dis = p1.dist(p2);
      if(dis < maxDis){
         line(p1.x, p1.y, p2.x, p2.y); 
      }
    }
  }

  //pelos();

  noStroke();
  beginShape();
  fill(rcol(), random(240));
  vertex(0, 0);
  vertex(width, 0);
  fill(rcol(), random(240));
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);


  olas();
  balls();

  noStroke();
  fill(0);
  float det = random(0.1);
  float des = random(1000);
  for (int i = 0; i < 40000; i++) {
    float xx = random(width);
    float yy = random(height);
    float ss = random(2)*noise(des+xx*det, des+yy*det);
    ellipse(xx, yy, ss, ss);
  }
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
int colors[] = {#3991BF, #416DA2, #9C6F92, #43A474, #ADCEBE};
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