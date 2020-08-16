int seed = int(random(999999));


float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale = 1;

boolean export = false;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P2D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  generate();

  if (export) {
    saveImage();
    exit();
  }
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else if (keyCode == LEFT) {
    seed--;
    generate();
  } else if (keyCode == RIGHT) {
    seed++;
    generate();
  } else {
    seed = int(random(999999));
    generate();
  }
}



void generate() { 

  println(seed);
  randomSeed(seed);
  background(230);
  scale(scale);


  background(0);
  float diag = dist(0, 0, width, height);

  float s = random(90, 280);
  int cc = int(random(2, 12));
  boolean vc = random(1) < 0.01;
  float str = random(1, s/((cc+3)*10));

  float vr = TWO_PI/4;//(int(random(1, 10)));
  float minAmp = random(1);
  for (int i = 0; i < 20; i++) {
    float x = random(width);
    float y = random(height);
    float a = random(TWO_PI);
    a -= a%vr;
    float amp = random(minAmp, 1);
    pushMatrix();
    translate(x, y);
    rotate(a);
    noStroke();
    fill(0);
    /*
    rect(0, 0, diag*2, s);
     */
    float ms = s*0.5;
    beginShape();
    vertex(-diag, ms*amp);
    vertex(+diag, ms);
    vertex(+diag, -ms);
    vertex(-diag, -ms*amp);
    endShape(CLOSE);
    if (vc) cc = int(random(30));
    float dd = s/cc;
    noStroke();
    fill(255);
    for (int j = 0; j < cc; j++) {
      float xx = diag;
      float y1 = (j-cc/2+0.5)*dd*amp;
      float y2 = (j-cc/2+0.5)*dd;
      float mstr = str;
      beginShape();
      vertex(-xx, y1-mstr*amp);
      vertex(+xx, y2-mstr);
      vertex(+xx, y2+mstr);
      vertex(-xx, y1+mstr*amp);
      endShape(CLOSE);
      /*
      float dx = ;
       float dy = (j-cc/2+0.5)*dd;
       line(-dx, dy, dx, dy);
       */
    }

    popMatrix();
  }
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#FEFEFE, #FEBDE5, #FE9446, #FBEC4D, #00ABA3};
//int colors[] = {#01EEBA, #E8E3B3, #E94E6B, #F08BB2, #41BFF9};
//int colors[] = {#000000, #eeeeee, #ffffff};
//int colors[] = {#DFAB56, #E5463E, #366A51, #2884BC};
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
