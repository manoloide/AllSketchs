int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
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
  //lights();
  translate(width/2, height*0.6, -500);
  rotateX(random(PI*1.4, PI*1.7));

  //rotateY(random(TWO_PI));
  //rotateZ(random(-0.05, 0.05));
  for (int i = 0; i < 3; i++) {
    float xx = width*random(-0.5, 0.5);
    float yy = height*random(-0.5, 0.5);
    pushMatrix();
    translate(xx, 0, yy);
    tower();
    popMatrix();
  }
}

void tower() {
  float ss = width*random(0.38, 0.42)*random(1, 3)*2;
  float hh = ss*random(1, random(2, 6));
  int sub = int(random(8, random(8, 700)));
  int div = int(random(4, 80))*4;
  float da = TWO_PI/div;

  float cx = 0;
  float cy = 0;

  float pwr = random(0.8, random(1, 20));
  //if (random(1) < 0.5) pwr = 1/pwr;

  noStroke();
  float d1 = random(40)*random(1)*random(1);
  float d2 = random(20)*random(1)*random(1);

  float shw1 = 4;//random(8)*random(1);
  float shw2 = 120;//random(80)*random(1);

  for (int j = 1; j <= sub; j++) {
    float h1 = map(j-1, 0, sub, -hh, 0);
    float h2 = map(j, 0, sub, -hh, 0);
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
      vertex(cx+cos(a1)*s1, h2, cy+sin(a1)*s1);
      vertex(cx+cos(a1)*s2, h1, cy+sin(a1)*s2);
      vertex(cx+cos(a2)*s3, h1, cy+sin(a2)*s3);
      vertex(cx+cos(a2)*s4, h2, cy+sin(a2)*s4);
      endShape();

      /*
      float sh1 = shw1;
       float sh2 = 0;
       
       beginShape();
       fill(0, sh1);
       vertex(cx+cos(a1)*s1, h2, cy+sin(a1)*s1);
       vertex(cx+cos(a1)*s2, h1, cy+sin(a1)*s2);
       fill(0, sh2);
       vertex(cx+cos(a2)*s3, h1, cy+sin(a2)*s3);
       vertex(cx+cos(a2)*s4, h2, cy+sin(a2)*s4);
       endShape();
       
       sh1 = shw2;
       beginShape();
       fill(0, sh1);
       vertex(cx+cos(a1)*s2, h1, cy+sin(a1)*s2);
       vertex(cx+cos(a2)*s3, h1, cy+sin(a2)*s3);
       fill(0, sh2);
       vertex(cx+cos(a2)*s4, h2, cy+sin(a2)*s4);
       vertex(cx+cos(a1)*s1, h2, cy+sin(a1)*s1);
       endShape();
       */
    }
  }
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