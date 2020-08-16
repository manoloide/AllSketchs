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
  if (key == ' ') {
    seed = int(random(999999));
    generate();
  }
}

void generate() {
  
  randomSeed(seed);
  noiseSeed(seed);
  noiseDetail(2);
  
  int back = getColor(random(200));
  int col = getColor(random(200));
  background(back);

  noStroke();
  float det = 0.0018;
  float des = 0.1;
  int sep = 10;
  for (int j = 0; j < height; j+=sep) {
    for (int i = 0; i < width; i+= sep) {
      if(noise(des+i*det, des+j*det) < 0.5) fill(back);
      else fill(col);
      rect(i, j, sep, sep);
    }
  }


  for (int i = 0; i < 10990; i++) {
    float x = random(width);
    float y = random(height);
    x -= x%10;
    y -= y%10;
    fill(255, 40);
    rect(x+1, y+1, 8, 8);
  }
  
  
  for(int i = 0; i < 20; i++){
     float x = random(width);
     float y = random(height);
     x -= x%10;
     y -= y%10;
     float ax = x;
     float ay = y;
     col = rcol();
     for(int j = 0; j < 600; j++){
         x += int(random(-2, 2))*sep;
         y += int(random(-2, 2))*sep;
     stroke(col, 80);
         line(x+5, y+5, ax+5, ay+5);
         ax = x;
         ay = y;
         noStroke();
         fill(col);
         ellipse(x, y, 2, 2);
     }
  }
  

  float w = 10;
  float h = 30;
  for (int i = 0; i < 100; i++) {
    float x = random(width);
    float y = random(height);
    x -= x%w;
    y -= y%h;
    fill(rcol());
    rect(x, y, w, h);
  }

  for (int i = 0; i < 30; i++) {
    float x = random(width);
    float y = random(height);
    float s = random(0.2)*width;
    //s -= s%10;
    if (s < 0) continue;

    x -= x%s;
    y -= y%s;

    if (random(1) < 0.8) {
      fill(lerpColor(rcol(), color(255), random(0.2, 0.5)));
      ellipse(x, y, s, s);

      beginShape();
      if (random(1) < 0.2) vertex(x-s*0.5, y-s*0.5);
      vertex(x, y-s*0.5);
      if (random(1) < 0.2) vertex(x+s*0.5, y-s*0.5);
      vertex(x+s*0.5, y);
      if (random(1) < 0.2) vertex(x+s*0.5, y+s*0.5);
      vertex(x, y+s*0.5);
      if (random(1) < 0.2) vertex(x-s*0.5, y+s*0.5);
      vertex(x-s*0.5, y);
      endShape();
    }


    col = getColor(random(colors.length));
    fill(col);
    aro(x, y, s, s*0.1);
    noStroke();
    ellipse(x, y, s*0.04, s*0.04);
    arc2(x, y, s, s*1.4, 0, TAU, color(0), 12, 0);
    int cc = int(random(8, 40));
    float da = TAU/cc;

    if (random(1) < 0.1) {
      fill(col);
      for (int j = 0; j < cc; j++) {
        ellipse(x+cos(da*j)*s*0.6, y+sin(da*j)*s*0.6, s*0.02, s*0.02);
      }
    }
  }
}

void aro(float x, float y, float s, float b) {
  int seg = int(s*PI*0.5);
  float da = TWO_PI/seg;
  float r = s*0.5;
  beginShape();
  for (int i = 0; i <= seg; i++) {
    float a = da*i;
    vertex(x+cos(a)*r, y+sin(a)*r);
  }
  for (int i = seg; i >= 0; i--) {
    float a = da*i;
    vertex(x+cos(a)*(r-b), y+sin(a)*(r-b));
  }
  endShape();
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(1, int(max(r1, r2)*PI*ma));
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

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}
int colors[] = {#FFFCF7, #FDDA02, #EE78AC, #3155A3, #028B88};
//int colors[] = {#01AFD8, #009A91, #E46952, #784391, #1B2D53};
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
