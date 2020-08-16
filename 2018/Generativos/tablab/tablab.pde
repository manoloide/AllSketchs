int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {
  background(0);
  randomSeed(seed);

  background(rcol());

  int cc = int(random(6, 8)*10);
  float ss = width*1./cc;

  stroke(0, 10);
  for (int j = 0; j <= cc; j++) {
    for (int i = 0; i <= cc; i++) {
      fill(rcol());
      ellipse(i*ss, j*ss, ss*0.2, ss*0.2);
    }
  }

  float des = random(1000);
  float det = random(0.002, 0.004)*3;
  desc = random(1000);
  detc = random(0.01);

  for (int i = 0; i < cc*40; i++) {
    float x1 = random(width*1+ss); 
    x1 -= x1%ss;
    float y1 = random(height+ss);  
    y1 -= y1%ss;

    float dis = ss*int(1+pow(noise(des+x1*det, des+y1*det), 1.3)*24);

    float x2 = x1+random(-dis, dis);  
    x2 -= x2%ss;
    float y2 = y1+random(-dis, dis);  
    y2 -= y2%ss;
    float x3 = x1+random(-dis, dis);  
    x3 -= x3%ss;
    float y3 = y1+random(-dis, dis);  
    y3 -= y3%ss;
    /*
     stroke(0, 40);
     beginShape();
     fill(rcol(), random(160, 256));
     vertex(x1, y1);
     vertex(x2, y2);
     fill(rcol(), 0);
     vertex(x3, y3);
     endShape(CLOSE);
     */
    //triangle(x1, y1, x2, y2, x3, y3);
    tl(x1, y1, x2, y2, x3, y3);
    tl(x2, y2, x3, y3, x1, y1);
    tl(x3, y3, x1, y1, x2, y2);

    /*
     fill(rcol());
     ellipse(x1, y1, ss*0.02, ss*0.02);
     ellipse(x2, y2, ss*0.02, ss*0.02);
     ellipse(x3, y3, ss*0.02, ss*0.02);
     */
  }
}

float desc = random(1000);
float detc = random(0.01);

void tl(float x1, float y1, float x2, float y2, float x3, float y3) {
  int cc = int(min(dist(x1, y1, x2, y2), dist(x1, y1, x3, y3))*random(0.18, 0.3));
  for (int i = 0; i <= cc; i++) {
    float v = i*1./cc;
    float nx1 = lerp(x1, x2, v);
    float ny1 = lerp(y1, y2, v);
    float nx2 = lerp(x1, x3, v);
    float ny2 = lerp(y1, y3, v);
    stroke(getColor(noise(desc+nx1*detc, desc+ny1*detc)*2), 80);
    line(nx1, ny1, nx2, ny2);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#0F101E, #11142B, #28398B, #323E78, #4254A3, #FCEE6B};
//int colors[] = {#92C8FA, #0321A1, #07AE28, #F94D21, #FFFFFF};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v)%1;
  int ind1 = int(v*colors.length);
  int ind2 = (int((v)*colors.length)+1)%colors.length;
  int c1 = colors[ind1]; 
  int c2 = colors[ind2]; 
  return lerpColor(c1, c2, (v*colors.length)%1);
}
