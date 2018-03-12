int seed = int(random(999999));

void setup() {
  size(920, 920, P3D);
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

  float fov = PI/2.5;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/10.0, cameraZ*10000.0);

  translate(width/2, height/2, -400);
  lights();
  for (int i = 0; i < 20; i++) {
    float rd = random(3, 20);
    float x = width*random(-1, 1)*rd*random(0.4, 1.2);
    float y = height*random(-1, 1)*rd*random(0.4, 1.2); 
    float d = width*rd;
    float s = random(360, 500)*1.6;
    noStroke();
    pushMatrix();
    translate(x, y, -d);
    rotateX(random(TWO_PI));
    rotateY(random(TWO_PI));
    rotateZ(random(TWO_PI));
    fill(getColor(random(colors.length)));
    cilindro(s, s*8);
    popMatrix();
  }
}

void cilindro(float d, float h) {
  float r = d*0.5;
  int res1 = 128;
  int res2 = 32;
  float da = TWO_PI/res1;
  float wave = random(10);
  float freq = random(10);
  float mw = random(-0.1, 0.1)*random(0.2)*random(0.2, 1);
  float mf = random(-0.1, 0.1)*random(1.2)*random(0.4);

  for (int j = 0; j < res2; j++) {
    float d1 = map(j, 0, res2, -h*0.5, h*0.5);
    float d2 = map(j+1, 0, res2, -h*0.5, h*0.5);
    for (int i = 0; i < res1; i++) {
      float a1 = da*i;
      float a2 = da*(i+1);
      beginShape();
      float w1 = wave+mw*j;
      float f1 = freq+mf*j;
      float w2 = wave+mw*(j+1);
      float f2 = freq+mf*(j+1);
      fill(getColor(waveShape(w1, f1)*colors.length+4));
      vertex(cos(a1)*r, sin(a1)*r, d1);
      vertex(cos(a2)*r, sin(a2)*r, d1);
      fill(getColor(waveShape(w2, f2)*colors.length+4));
      vertex(cos(a2)*r, sin(a2)*r, d2);
      vertex(cos(a1)*r, sin(a1)*r, d2);
      endShape();
    }
  }
  beginShape();
  fill(getColor(waveShape(wave+mw, freq+mw)*colors.length+4));
  for (int i = 0; i < res1; i++) {
    float a1 = da*i;
    vertex(cos(a1)*r, sin(a1)*r, -h*0.5);
  }
  endShape(CLOSE);
  beginShape();
  fill(getColor(waveShape(wave+mw*res2, freq+mf*res2)*colors.length+4));
  for (int i = 0; i < res1; i++) {
    float a1 = da*i;
    vertex(cos(a1)*r, sin(a1)*r, h*0.5);
  }
  endShape(CLOSE);
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