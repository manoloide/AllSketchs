int seed = int(random(999999));

void setup() {
  size(920, 920);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate()
  /*
  randomSeed(seed);
   stroke(255, 3);
   drawWave(20, 20, width-40, height-40, random(1)*random(1), random(1));
   */
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  background(0);

  noStroke(); 
  for (int i = 0; i < 100; i++) {
    float x = random(width);
    float y = random(height);
    float s = random(width)*random(1); 

    int cc = int(random(s*0.3, s*0.5)*random(0.1, 1));
    float ic = random(colors.length);
    float dc = random(10)*random(1)*random(1);
    for (int j = 0; j < cc; j++) {
      float ss = map(j, 0, cc, s, 0);
      fill(getColor(ic+dc*j)); 
      ellipse(x, y, ss, ss);
    }
  }

  float size = width*0.9;
  float dx = (width-size)*0.5;
  float dy = (width-size)*0.5;
  int cc = 8; 
  float ss = size/cc; 

  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      fill(rcol());
      int rnd = int(random(3));
      float xx = dx+i*ss;
      float yy = dy+j*ss;

      if (rnd == 1) { 

        int ccc = int(random(ss*0.3, ss*0.5)*random(0.1, 1));
        float ic = random(colors.length);
        float dc = random(100)*random(1)*random(1);
        for (int k = 0; k < ccc; k++) {
          float sss = map(k, 0, ccc, ss, 0);
          fill(getColor(ic+dc*k)); 
          rect(xx+ss*0.5-sss*0.5, yy+ss*0.5-sss*0.5, sss, sss);
        }
      } else if (rnd == 2) {
        float s2 = ss*random(0.5);
        rect(dx+i*ss, dy+j*ss, ss, ss); 
        fill(rcol());
        if (random(1) < 0.5) {
          triangle(xx+s2, yy, xx, yy+s2, xx, yy);
          triangle(xx+ss-s2, yy, xx+ss, yy+s2, xx+ss, yy);
          triangle(xx+ss-s2, yy+ss, xx+ss, yy+ss-s2, xx+ss, yy+ss);
          triangle(xx+s2, yy+ss, xx, yy+ss-s2, xx, yy+ss);
        } else {

          arc(xx, yy, s2, s2, 0, HALF_PI);
          arc(xx+ss, yy, s2, s2, HALF_PI, PI);
          arc(xx+ss, yy+ss, s2, s2, PI, PI*1.5);
          arc(xx, yy+ss, s2, s2, PI*1.5, TWO_PI);
        }
      }
    }
  }
}

float waveShape(float wave, float freq) {
  if (freq < 0) freq = 1-abs(freq);
  wave = abs(wave);
  int form = int(wave%4);
  float mix = wave%1.0;
  float aux = 0;
  if (form == 0) {
    float sine = sin(freq*TWO_PI)*0.5+0.5;
    float quad = floor((freq+0.5)%1*2.0);
    aux = lerp(sine, quad, mix);
  }
  if (form == 1) {
    float quad = floor((freq+0.5)%1*2.0);
    float tri = abs(1-((freq+0.75)%1.0)*2.0);
    aux = lerp(quad, tri, mix);
  }
  if (form == 2) {
    float tri = abs(1-((freq+0.75)%1.0)*2.0);
    float saw = (freq+0.5)%1.0;
    aux = lerp(tri, saw, mix);
  }
  if (form == 3) {
    float saw = (freq+0.5)%1.0;
    float sine = sin(freq*TWO_PI)*0.5+0.5;
    aux = lerp(saw, sine, mix);
  }
  return aux;
}

//https://coolors.co/181a99-5d93cc-454593-e05328-e28976
int colors[] = {#EBB858, #EEA8C1, #D0CBC3, #87B6C4, #EA4140, #5A5787};

int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}