int seed = int(random(999999));
PFont font;

PShader noi;

void setup() {
  size(2048, 2048, P2D);
  smooth(8);
  pixelDensity(2);

  noi = loadShader("noiseShadowFrag.glsl", "noiseShadowVert.glsl");

  font = createFont("Saira-Thin", 180, true);
  textFont(font);
  textAlign(CENTER, CENTER);

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
  background(#181818);

  noStroke();
  fill(#202020);
  shader(noi);
  rect(0, 0, width, height);

  fill(255, 2);
  for (int j = 0; j <= width; j+=40) {
    for (int i = 0; i <= width; i+=40) {
      rect(i-4, j-4, 8, 8);
    }
  }
  /*
  for (int i = 0; i < 10; i++) {
   float x = random(width);
   float y = random(height);
   float s = width*random(0.6);
   fill(rcol(), random(255));
   ellipse(x, y, s, s);
   }
   */
  resetShader();

  noFill();
  noiseDetail(1);
  strokeCap(SQUARE);
  float det = random(0.001, 0.006);
  for (int i = 0; i < 30; i++) {
    float x = random(width); 
    float y = random(height);
    float des = random(100);

    ArrayList<PVector> points = new ArrayList<PVector>();
    for (int j = 0; j < 122; j++) {
      float ang = noise(des+x*det, des+y*det)*TWO_PI*2;
      points.add(new PVector(x, y));
      x += cos(ang)*4;
      y += sin(ang)*4;
    }

    stroke(0, 8); //#FF5100
    strokeWeight(90);
    shader(noi);
    beginShape();
    for (int j = 0; j < points.size(); j++) {
      PVector p = points.get(j);
      vertex(p.x, p.y);
    }
    endShape();
    resetShader();

    stroke(#FF823A);
    strokeWeight(80);
    beginShape();
    for (int j = 0; j < points.size(); j++) {
      PVector p = points.get(j);
      vertex(p.x, p.y);
    }
    endShape();

    shader(noi);
    stroke(rcol()); 
    strokeWeight(80);
    beginShape();
    for (int j = 0; j < points.size(); j++) {
      PVector p = points.get(j);
      vertex(p.x, p.y);
    }
    endShape();
    resetShader();
  }

  noFill();
  noiseDetail(1);
  det = random(0.04, 0.12);
  for (int i = 0; i < 60; i++) {
    float ix = random(width);
    float iy = random(height);
    float des = random(1000);

    float x = ix; 
    float y = iy;
    stroke(0, 12);
    strokeWeight(2);
    shader(noi);
    beginShape();
    for (int j = 0; j < 16; j++) {
      float ang = noise(des+x*det, des+y*det)*TWO_PI*2;
      vertex(x+3, y+3);
      x += cos(ang);
      y += sin(ang);
    }
    endShape();
    resetShader();

    x = ix; 
    y = iy;
    stroke(#E6ECF0);
    strokeWeight(1);
    beginShape();
    for (int j = 0; j < 14; j++) {
      float ang = noise(des+x*det, des+y*det)*TWO_PI*2;
      vertex(x, y);
      x += cos(ang);
      y += sin(ang);
    }
    endShape();
  }

  float ss = random(180, 320);
  float bw = (width%ss)/2.;
  float bh = (height%ss)/2.;

  for (float j = bh; j <= height-ss; j+=ss) {
    for (float i = bw; i <= width-ss; i+=ss) {
      //if (random(1) < 0.08) continue;
      String text = "send nudes";
      char t = text.charAt(int(random(text.length())));
      float s = random(ss*0.2, ss*0.8);
      float x = i+ss*0.5;
      float y = j+(80-s)*0.5+ss*0.5;
      textSize(s);
      fill(0, 20);
      text(t, x+8, y+5);
      fill(255);
      text(t, x, y);
    }
  }
}

void drawLine(ArrayList<PVector> p, float s) {
  float r = s*0.5;
  beginShape();
  for (int j = 1; j < p.size()-1; j++) {
    PVector ant = p.get(j-1);
    PVector act = p.get(j+0);
    PVector sig = p.get(j+1);
    float a1 = atan2(act.y-ant.y, act.x-ant.x);
    float a2 = atan2(sig.y-act.y, sig.x-act.x);
    float ang = -HALF_PI+lerp(a1, a2, 0.5); 
    vertex(act.x+cos(ang)*r, act.y+sin(ang)*r);
  }

  for (int j = p.size()-2; j > 0; j--) {
    PVector ant = p.get(j-1);
    PVector act = p.get(j+0);
    PVector sig = p.get(j+1);
    float ang = -HALF_PI+lerp(atan2(act.y-ant.y, act.x-ant.x), atan2(sig.y-act.y, sig.x-act.x), 0.5)%TWO_PI; 
    vertex(act.x-cos(ang)*r, act.y-sin(ang)*r);
  }
  endShape();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#FACD00, #FB4F00, #F277C5, #7D57C6, #00B187, #3DC1CD};
//int colors[] = {#2B3F3E, #312A3B, #F25532, #43251B, #C81961, #373868, #FFF8DC};
//int colors[] = {#F19617, #251207, #15727F, #CEAB81, #BD3E36};
int colors[] = {#0017FF, #FF5100, #F8AD01, #FB4240};
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