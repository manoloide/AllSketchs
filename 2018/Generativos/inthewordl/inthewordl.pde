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
  background(250);

  noiseSeed(seed);
  randomSeed(seed);

  float ss = width*random(0.38, 0.42)*2.;
  int sub = int(random(8, random(8, 700)));
  float ds = ss/sub;
  int div = int(random(4, 80))*4;
  float da = TWO_PI/div;
  stroke(0, 40);
  noFill();

  float cx = width/2;
  float cy = height/2;

  float pwr = random(0.8, random(1, 20));
  //if (random(1) < 0.5) pwr = 1/pwr;

  noStroke();
  float d1 = random(12)*random(1)*random(1);
  float d2 = random(20)*random(1)*random(1);

  float shw1 = random(8)*random(1);
  float shw2 = random(80)*random(1);

  for (int j = 1; j <= sub; j++) {
    for (int i = 0; i < div; i++) {
      float a1 = da*i;
      float a2 = da*(i+1);

      float p1 = 0.5+noise(cos(a1)*d2, sin(a1)*d2)*pwr;
      float p2 = 0.5+noise(cos(a2)*d2, sin(a2)*d2)*pwr;
      float s1 = pow(map(j, 0, sub, 0, 1), p1)*ss;
      float s2 = pow(map(j-1, 0, sub, 0, 1), p1)*ss;
      float s3 = pow(map(j-1, 0, sub, 0, 1), p2)*ss;
      float s4 = pow(map(j, 0, sub, 0, 1), p2)*ss;

      float col = pow(map(j, 1, sub, 0, 1), 0.5+noise(cos(a1)*d1, sin(a2)*d1, j*d1))*4.;
      //fill(getColor(random(colors.length)));
      int c = getColor(colors.length*col);

      beginShape();
      fill(c);
      vertex(cx+cos(a1)*s1, cy+sin(a1)*s1);
      vertex(cx+cos(a1)*s2, cy+sin(a1)*s2);
      vertex(cx+cos(a2)*s3, cy+sin(a2)*s3);
      vertex(cx+cos(a2)*s4, cy+sin(a2)*s4);
      endShape();

      float sh1 = shw1;
      float sh2 = 0;

      beginShape();
      fill(0, sh1);
      vertex(cx+cos(a1)*s1, cy+sin(a1)*s1);
      vertex(cx+cos(a1)*s2, cy+sin(a1)*s2);
      fill(0, sh2);
      vertex(cx+cos(a2)*s3, cy+sin(a2)*s3);
      vertex(cx+cos(a2)*s4, cy+sin(a2)*s4);
      endShape();


      sh1 = shw2;
      beginShape();
      fill(0, sh1);
      vertex(cx+cos(a1)*s2, cy+sin(a1)*s2);
      vertex(cx+cos(a2)*s3, cy+sin(a2)*s3);
      fill(0, sh2);
      vertex(cx+cos(a2)*s4, cy+sin(a2)*s4);
      vertex(cx+cos(a1)*s1, cy+sin(a1)*s1);
      endShape();
    }
  }

  /*
  for (int i = 0; i < div; i++) {
   float d1 = ds*0.5;
   float d2 = ss*0.5;
   float ang = da*i;
   line(cx+cos(ang)*d1, cy+sin(ang)*d1, cx+cos(ang)*d2, cy+sin(ang)*d2);
   }
   for (int j = 1; j <= sub; j++) {
   float s1 = pow(map(j, 0, sub, 0, 1), pwr)*ss;
   float s2 = pow(map(j-1, 0, sub, 0, 1), pwr)*ss;
   ellipse(cx, cy, s1, s1);
   }
   */
}


void drawSlide(float cx, float cy, float a1, float a2, float s1, float s2, float s3, float s4, color c1, color c2, color c3, color c4) {
  beginShape();
  fill(c1);
  vertex(cx+cos(a1)*s1, cy+sin(a1)*s1);
  fill(c2);
  vertex(cx+cos(a1)*s2, cy+sin(a1)*s2);
  fill(c3);
  vertex(cx+cos(a2)*s3, cy+sin(a2)*s3);
  fill(c4);
  vertex(cx+cos(a2)*s4, cy+sin(a2)*s4);
  endShape();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}
//https://coolors.co/f2f2e8-ffe41c-ef3434-ed0076-3f9afc
//int colors[] = {#B14027, #476086, #659173, #9293A2, #262A2C, #D38644};
int colors[] = {#2F2624, #207193, #EF4C31, #EE4E7C, #ffffff};
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
void shuffleArray(int[] array) {
  for (int i = array.length; i > 1; i--) {
    int j = int(random(i));
    int tmp = array[j];
    array[j] = array[i-1];
    array[i-1] = tmp;
  }
}