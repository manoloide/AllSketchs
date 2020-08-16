int seed = int(random(999999));
void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
  //saveImage();
  //exit();
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
  background(rcol());

  rectMode(CENTER);
  ArrayList<PVector> ps = new ArrayList<PVector>();
  float dist = random(3, 4.8);
  for (int i = 0; i < 10000; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(0.02, 0.1)*0.08;
    boolean add = true;
    for (int j = 0; j < ps.size(); j++) {
      if (dist(ps.get(j).x, ps.get(j).y, x, y) < (s+ps.get(j).z)*dist) {
        add = false;
        break;
      }
    }
    if (add) {
      ps.add(new PVector(x, y, s));
    }
  }

  noStroke();
  for (int i = 0; i < ps.size(); i++) {
    PVector p = ps.get(i);
    int col = rcol();
    fill(col);
    ellipse(p.x, p.y, p.z, p.z);
    noFill();
    stroke(col);
    strokeWeight(p.z*0.05);
    ellipse(p.x, p.y, p.z*1.6, p.z*1.6);
  }


  int cc = int(random(5, random(5, 15)))*2;
  float ss = width*1./cc;



  strokeWeight(1);
  for (int i = 0; i < cc; i++) {
    stroke(rcol()); 
    noFill();
    rect(width/2, height/2, i*ss, i*ss);
    stroke(rcol(), 20);
    fill(rcol(), 8);
    ellipse(width/2, height/2, (cc-i)*ss, (cc-i)*ss);
  }
  strokeWeight(1);

  float det = random(0.01);
  float des = random(1000000);
  float sdet = random(0.02);
  float sdes = random(100000);
  noiseDetail(1);
  float amp = random(0.1, 0.4);
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float x1 = (i+0)*ss;
      float x2 = (i+1)*ss;
      float y1 = (j+0)*ss;
      float y2 = (j+1)*ss;

      int rnd = int(random(2));
      noStroke();
      beginShape();
      if (rnd == 0) {
        fill(rcol(), random(120)*random(1));
        vertex(x1, y1);
      }
      fill(rcol(), random(120)*random(1));
      vertex(x2, y1);
      fill(rcol(), random(120)*random(1));
      vertex(x2, y2);
      fill(rcol(), random(120)*random(1));
      vertex(x1, y2);
      if (rnd == 1) {
        fill(rcol(), random(120)*random(1));
        vertex(x1, y1);
      }
      endShape(CLOSE);

      stroke(rcol());
      line(x1, y1, x1, y2);
      stroke(rcol());
      line(x1, y1, x2, y1);

      noStroke();
      fill(rcol());
      float sss = ss*amp;
      float nn = noise(sdes+x1*sdet, sdes+y1*sdet);
      ellipse(x1, y1, sss, sss);
      fill(rcol(), random(12));
      ellipse(x1, y1, ss*2, ss*2);
      fill(rcol(), random(12));
      ellipse(x1, y1, ss, ss);
      arc2(x1, y1, sss, sss*5, 0, TWO_PI, rcol(), 20, 0);
      arc2(x1, y1, sss, sss*2, 0, TWO_PI, rcol(), 40, 0);
      float ang = noise(des+x1*det, det+y1*det)*TAU*2;
      fill(rcol());
      arc(x1, y1, sss, sss, ang, ang+PI);
      fill(rcol());
      ellipse(x1, y1, sss*0.1*nn, sss*0.1*nn);
      float s = ss*nn*0.5;
      noStroke();
      fill(rcol());
      rect(x1+ss*0.5, y1+ss*0.5, s, s);
    }
  }
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float shd1, float shd2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(1, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    fill(col, shd1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(col, shd2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#EF0483, #009ADE, #F8E909, #FFFFFF, #000000};
//int colors[] = {#F24796, #197B46, #CC9A45, #289A5F, #000000};
int colors[] = {#FFAB6B, #EFB1F1, #FF0076, #951BFF, #5B01A8};
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