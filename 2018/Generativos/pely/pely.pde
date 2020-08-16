int seed = int(random(999999));

void setup() {
  size(700, 700, P2D);
  smooth(2);
  //pixelDensity(2);
  
  gra = createGraphics(12000, 12000, P2D);
 
  for(int i = 0; i < 8; i++){
     generate();
     saveImage();
  }
  
  exit();
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

PGraphics gra;

void generate() {
  
  float w = gra.width;
  float h = gra.height;

  gra.beginDraw();
  gra.rectMode(CENTER);
  gra.background(#BD3E36);

  float ss = w*random(0.041, 0.3333);
  int cc = int(w*1./ss)-1;
  float bb = (w-ss*cc)*0.5;

  int gc = (cc+2)*4;
  float gs = w*1./gc;
  gra.noStroke();
  for (int j = 0; j <= gc; j++) {
    for (int i = 0; i <= gc; i++) {
      float x = i*(0.0+gs);
      float y = j*(0.0+gs);
      gra.noStroke();
      gra.fill(255, 8);
      //rect(x, y, gs*0.90, gs*0.30);
      //rect(x, y, gs*0.30, gs*0.90);
      gra.pushMatrix();
      gra.translate(x, y);
      gra.rotate(PI*0.25);
      gra.rect(0, 0, gs*0.6, gs*0.6);
      gra.popMatrix();
      gra.fill(0, 6);
      gra.rect(x, y, gs*0.25, gs*0.25);
      gra.ellipse(x+gs*0.5, y+gs*0.5, gs*0.2, gs*0.2);
    }
  }

  gra.fill(#F19617);
  triLine(0, 0, w, 0, gc);
  triLine(w, 0, w, h, gc);
  triLine(w, h, 0, h, gc);
  triLine(0, h, 0, 0, gc);

  gra.noStroke();
  float ms = ss*0.5;
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      gra.pushMatrix();
      gra.translate(bb+(i+0.5)*ss, bb+(j+0.5)*ss);
      gra.rotate(HALF_PI*0.5);

      gra.fill(rcol());
      rectShadow(ss*1.25, 140, 0);

      gra.beginShape();
      gra.fill(rcol());
      gra.vertex(-ms, -ms);
      gra.vertex(+ms, -ms);
      gra.fill(rcol());
      gra.vertex(+ms, +ms);
      gra.vertex(-ms, +ms);
      gra.endShape(CLOSE);

      /*
      triLine(-ms, -ms, +ms, -ms, 10);
       triLine(+ms, -ms, +ms, +ms, 10);
       triLine(+ms, +ms, -ms, +ms, 10);
       triLine(-ms, +ms, -ms, -ms, 10);
       */

      gra.beginShape();
      gra.fill(0, 0);
      gra.vertex(0, -ms);
      gra.vertex(0, +ms);
      gra.fill(0, 80);
      gra.vertex(+ms, +ms);
      gra.vertex(+ms, -ms);
      gra.endShape(CLOSE);

      gra.fill(0);
      rectShadow(ss*0.25, 80, 0);

      gra.fill(rcol());
      gra.rect(0, 0, ss*0.2, ss*0.2);
      gra.popMatrix();
    }
  }

  for (int i = 0; i < 100; i++) {
    float x = random(w);
    float y = random(h);
    float s = random(6);
    float ang = random(TWO_PI);
    float amp = random(0.2, 0.3);
    gra.fill(255, 200);
    //starSha(x, y, s*2, ang, amp);
    gra.fill(rcol(), 120);
    star(x, y, s, ang, amp);
  }
  
  gra.endDraw();
}

void star(float x, float y, float s, float ang, float amp) {
  float da = TWO_PI/10;
  float r = s*0.5;
  gra.beginShape();
  for (int i = 0; i < 10; i++) {
    float a = da*i+ang;
    gra.vertex(x+cos(a)*r, y+sin(a)*r);
    gra.vertex(x+cos(a+da*0.5)*r*amp, y+sin(a+da*0.5)*r*amp);
  }
  gra.endShape(CLOSE);
}

void starSha(float x, float y, float s, float ang, float amp) {
  float da = TWO_PI/10;
  float r = s*0.5;
  int col = g.fillColor;
  for (int i = 0; i < 10; i++) {
    float a = da*i+ang;
    gra.beginShape();
    gra.fill(col, 200);
    gra.vertex(x, y);
    gra.fill(col, 0);
    gra.vertex(x+cos(a)*r, y+sin(a)*r);
    gra.vertex(x+cos(a+da*0.5)*r*amp, y+sin(a+da*0.5)*r*amp);
    gra.endShape(CLOSE);

    gra.beginShape();
    gra.fill(col, 60);
    gra.vertex(x, y);
    gra.fill(col, 0);
    gra.vertex(x+cos(a)*r, y+sin(a)*r);
    gra.vertex(x+cos(a-da*0.5)*r*amp, y+sin(a-da*0.5)*r*amp);
    gra.endShape(CLOSE);
  }
}

void rectShadow(float ss, float a1, float a2) {
  float r = ss*0.5*sqrt(2);
  int col = g.fillColor;
  for (int i = 0; i < 4; i++) {
    float ang = HALF_PI*(i+0.5);
    gra.beginShape();
    gra.fill(col, a1);
    gra.vertex(0, 0);
    gra.fill(col, a2);
    gra.vertex(cos(ang)*r, sin(ang)*r);
    gra.vertex(cos(ang+HALF_PI)*r, sin(ang+HALF_PI)*r);
    gra.endShape(CLOSE);
  }
}

void triLine(float x1, float y1, float x2, float y2, int cc) {
  float dist = dist(x1, y1, x2, y2);
  float ang1 = atan2(y2-y1, x2-x1);
  float ang2 = atan2(y2-y1, x2-x1)+HALF_PI;
  float dd = dist/cc;
  for (int i = 0; i < cc; i++) {
    float d1 = i*dd;
    float d2 = (i+1)*dd;
    float dm = (d1+d2)*0.5;
    gra.beginShape();
    gra.vertex(x1+cos(ang1)*d1, y1+sin(ang1)*d1);
    gra.vertex(x1+cos(ang1)*dm+cos(ang2)*dd*0.5, y1+sin(ang1)*dm+sin(ang2)*dd*0.5);
    gra.vertex(x1+cos(ang1)*d2, y1+sin(ang1)*d2);
    gra.endShape(CLOSE);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  gra.save(timestamp+".png");
}

//int colors[] = {#FACD00, #FB4F00, #F277C5, #7D57C6, #00B187, #3DC1CD};
int colors[] = {#F19617, #251207, #15727F, #CEAB81, #BD3E36};
//int colors[] = {#F5BFDF, #FBD872, #F36B7F, #9D87D2, #98B6F2, #1F5CB6};
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
