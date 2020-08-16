int seed = int(random(999999));
float det, des;
PShader post;

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  post = loadShader("post.glsl");

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
  background(10);

  des = random(1000);
  det = random(0.001);
  for (int i = 0; i < 20000; i++) {
    float x = random(-100, width+100);
    float y = random(-100, height+100);

    stroke(rcol(), 50);
    noiseDetail(2);
    for (int j = 0; j < 100; j++) {
      float a = noise(des+x*det, des+y*det)*TAU*20;
      float nx = x+cos(a);
      float ny = y+sin(a);

      line(x, y, nx, ny);
      x = nx; 
      y = ny;
    }
  }

  noStroke();
  for (int i = 0; i < 200; i++) {
    float s = width*1./pow(2, int(random(1, 6))); 

    float x = random(width+s);
    float y = random(height+s);
    x -= x%(s);
    y -= y%(s);
    int seg = int(random(12, random(20, 30)));//int(random(50, 220));
    float ang = random(TAU);
    float da = TAU*0.5/seg;//random(PI);
    float sep = s*random(0.4, random(0.4, 0.9));
    float pow = random(0.4, 0.8);
    for (int j = 0; j <= 50; j++) {
      float ss = pow(map(j, 0, 50, 1, 0), pow)*s;
      estrella(x, y, ss-sep*1, ss, ang+da, seg, rcol(), rcol());
    }
  }

  for (int i = 0; i < 200; i++) {
    float x = random(-100, width+100);
    float y = random(-100, height+100);
    des = random(1000);
    det = random(0.02);
    stroke(255, 60);
    noiseDetail(2);
    for (int j = 0; j < 200; j++) {
      float dd = des+j*det;
      float a = noise(dd+x*det, dd+y*det)*TAU*10;
      float nx = x+cos(a);
      float ny = y+sin(a);
      if (j%10 < 7) line(x, y, nx, ny);
      x = nx; 
      y = ny;
    }
    fill(255, 20);
    ellipse(x, y, 8, 8);
    fill(255, 220);
    ellipse(x, y, 5, 5);
  }
  
  noStroke();
  float det = random(0.01);
  float des = random(1000);
  for(int i = 0; i < 20000; i++){
     float xx = random(width);
     float yy = random(height);
     float sc = noise(des+det*xx, des+det*yy);
     pushMatrix();
     int col = rcol();
     float rot = PI*random(0.2, 0.4);
     translate(xx, yy);
     scale(sc);
     rotate(random(TAU));
     pushMatrix();
     translate(0, -2);
     rotate(rot);
     fill(col, 80);
     ellipse(xx, yy, 8, 2);
     fill(col, 180);
     ellipse(xx, yy, 2, 1);
     popMatrix();
     translate(0, 2);
     rotate(-rot);
     fill(col, 80);
     ellipse(xx, yy, 8, 2);
     fill(col, 180);
     ellipse(xx, yy, 2, 1);
     popMatrix();
  }
  
  

  post = loadShader("post.glsl");
  //filter(post);
}

void estrella(float x, float y, float s1, float s2, float a, int seg, int c1, int c2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float da = TAU/seg;
  for (int i = 0; i < seg; i++) {
    float a1 = a+da*i;
    float a2 = a+da*(i+0.5);
    stroke(255, 10);
    beginShape();
    fill(c1); 
    vertex(x+cos(a1)*r1, y+sin(a1)*r1);
    fill(c2);
    vertex(x+cos(a2)*r2, y+sin(a2)*r2);
    fill(c1);
    vertex(x+cos(a1+da)*r1, y+sin(a1+da)*r1);
    endShape(CLOSE);

    stroke(0, 5);
    beginShape();
    fill(0, 0);
    vertex(x+cos(a2)*r2, y+sin(a2)*r2);
    fill(0, 20);
    vertex(x+cos(a1+da)*r1, y+sin(a1+da)*r1);
    fill(0, 0);
    vertex(x+cos(a2+da)*r2, y+sin(a2+da)*r2);
    endShape(CLOSE);
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

//int colors[] = {#FE603C, #242D3B, #027ECB, #E5B270, #FD9EC8, #FDD3C7};
//int colors[] = {#232541, #4453D6, #38C1FF, #53E66B, #FFFFFF};
int colors[] = {#040001, #050F32, #FFFFFF, #050F32, #26A9C5, #FFFFFF, #E50074};
//int colors[] = {#E53B06, #ED2E06, #FD8100, #FDC702, #FFE6B3, #FFE989, #FDD8C6, #337FED, #350203};
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