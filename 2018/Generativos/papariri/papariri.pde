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
  background(250);

  builds();
  birds();
  circles();
}

void birds() {

  float des1 = random(1000);
  float det1 = random(0.01);

  for (int j = 0; j < 100; j++) {
    float x = random(width); 
    float y = random(width); 
    float vel = 4;
    float ang, nx, ny;
    stroke(rcol(), 200);
    for (int i = 0; i < 100; i++) {
      ang = noise(des1+x*det1, des1+y*det1)*TAU*5;
      nx = x+cos(ang)*vel;
      ny = y+sin(ang)*vel;
      if(i%2 == 0) line(nx, ny, x, y);
      x = nx; 
      y = ny;
    }
  }
}



void builds() {
  float des1 = random(1000);
  float det1 = random(0.001);
  float des2 = random(1000);
  float det2 = random(0.001);
  float des3 = random(1000);
  float det3 = random(0.01);

  for (int i = 0; i < 1000; i++) {
    float x = random(width);
    float y = random(height);
    float s = pow(noise(des3+x*det3, des3+y*det3), 1.1);
    float w = width*0.1*s;
    float h = w*random(0.8, 1.2);
    float a = noise(des1+x*det1, des1+y*det1)*TAU*4;



    //stroke(0, pow(noise(des2+x*det2, des2+y*det2), 0.2)*40);
    stroke(0, 20);
    pushMatrix();
    translate(x, y);
    rotate(a);
    boxShadow(w, h, min(w, h)*0.8, rcol(), random(80)*random(1));
    plane(w, h, rcol(), rcol(), 255*random(1), 255*random(1));
    plane(w*0.1, h*0.1, rcol(), rcol(), 255*random(0.5, 1), 255*random(0.5, 1));
    popMatrix();
  }
}


void circles() {  
  ArrayList<PVector> points = new ArrayList<PVector>();

  for (int i = 0; i < 10000; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(0.1, 0.4)*random(0.2, 1);

    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector p = points.get(j);
      if (dist(x, y, p.x, p.y) < (p.z+s)*0.55) {
        add = false; 
        break;
      }
    }
    if (add) points.add(new PVector(x, y, s));
  }

  noStroke();
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    int col = rcol();
    int str = rcol();

    noStroke();
    arc2(p.x, p.y, p.z, p.z*3, 0, TAU, rcol(), 80, 0);
    arc2(p.x, p.y, p.z, p.z*1.4, 0, TAU, rcol(), 250, 0);

    noStroke();
    stroke(str);
    fill(col, 20);
    ellipse(p.x, p.y, p.z, p.z);

    int seg = int(p.z*PI*0.1);
    float da = TAU/seg;
    fill(col, 2);
    stroke(str, 240);
    for (int j = 0; j < seg; j++) {
      arc(p.x, p.y, p.z*1.1, p.z*1.1, da*j, da*(j+0.2));
    }
    
    stroke(rcol(), 80);
    noFill();
    line(p.x-p.z*0.4, p.y-0.5, p.x+p.z*0.4, p.y-0.5); 
    line(p.x-0.5, p.y-p.z*0.4, p.x-0.5, p.y+p.z*0.4);
    ellipse(p.x, p.y, p.z*0.9, p.z*0.9);
    noStroke();
    arc2(p.x, p.y, p.z*0.9, p.z*0.8, 0, TAU, color(255), 60, 0);

    noStroke();
    arc2(p.x, p.y, p.z*0.12, p.z*0.12*2, 0, TAU, rcol(), 80, 0);
    fill(rcol());
    ellipse(p.x, p.y, p.z*0.12, p.z*0.12);
    fill(rcol());
    ellipse(p.x, p.y, p.z*0.08, p.z*0.08);
  }
}

void boxShadow(float w, float h, float b, int col, float alp) {
  float mw = w*0.5;
  float mh = h*0.5;

  beginShape();
  fill(col, alp);
  vertex(-mw, -mh);
  vertex(+mw, -mh);
  fill(col, 0);
  vertex(+mw+b, -mh-b);
  vertex(-mw-b, -mh-b);
  endShape(CLOSE);

  beginShape();
  fill(col, alp);
  vertex(+mw, -mh);
  vertex(+mw, +mh);
  fill(col, 0);
  vertex(+mw+b, +mh+b);
  vertex(+mw+b, -mh-b);
  endShape(CLOSE);

  beginShape();
  fill(col, alp);
  vertex(+mw, +mh);
  vertex(-mw, +mh);
  fill(col, 0);
  vertex(-mw-b, +mh+b);
  vertex(+mw+b, +mh+b);
  endShape(CLOSE);

  beginShape();
  fill(col, alp);
  vertex(-mw, +mh);
  vertex(-mw, -mh);
  fill(col, 0);
  vertex(-mw-b, -mh-b);
  vertex(-mw-b, +mh+b);
  endShape(CLOSE);
}

void plane(float w, float h, int c1, int c2, float alp1, float alp2) {
  float mw = w*0.5;
  float mh = h*0.5;

  beginShape();
  fill(c1, alp1);
  vertex(-mw, -mh);
  vertex(+mw, -mh);
  fill(c2, alp2);
  vertex(+mw, +mh);
  vertex(-mw, +mh);
  endShape(CLOSE);
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
int colors[] = {#000000, #33346B, #567BF6, #B4CAFB, #FFFFFF, #FFB72A, #FF4C3D};
//int colors[] = {#040001, #050F32, #FFFFFF, #050F32, #26A9C5, #FFFFFF, #E50074};
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