PShader hue;

int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  hue = loadShader("hue.glsl");

  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();
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

  seed = int(random(999999));
  randomSeed(seed);
  noiseSeed(seed);

  for (int c = 0; c < 10; c++) {
    pushMatrix();
    translate(width/2, height/2);
    rotate(random(TWO_PI));

    float size = width*1.4;
    int cc = int(random(5, random(30, 60)));//random(8, 40)));
    float ss = size/cc;

    translate(-size*0.5, -size*0.5);

    noStroke();
    fill(rcol());
    float amp = random(0.8);
    float det = random(0.008);
    float sss = ss*amp*0.5;
    for (int j = 0; j < cc; j++) {
      for (int i = 0; i < cc; i++) {
        float xx = i*ss;
        float yy = j*ss;
        /*
        beginShape();
         fill(rampColor(xx-sss, yy-sss, det));
         vertex(xx-sss, yy-sss);
         fill(rampColor(xx+sss, yy-sss, det));
         vertex(xx+sss, yy-sss);
         fill(rampColor(xx+sss, yy+sss, det));
         vertex(xx+sss, yy+sss);
         fill(rampColor(xx-sss, yy+sss, det));
         vertex(xx-sss, yy+sss);
         endShape(CLOSE);
         */
        beginShape();
        fill(rampColor(xx-sss, yy, det));
        vertex(xx-sss, yy);
        fill(rampColor(xx-sss, yy+sss, det));
        vertex(xx-sss, yy+sss);
        fill(rampColor(xx, yy+sss, det));
        vertex(xx, yy+sss);
        fill(rampColor(xx+sss, yy, det));
        vertex(xx+sss, yy);
        fill(rampColor(xx+sss, yy-sss, det));
        vertex(xx+sss, yy-sss);
        fill(rampColor(xx, yy-sss, det));
        vertex(xx, yy-sss);
        endShape(CLOSE);
        beginShape();
        fill(0, 80);
        vertex(xx, yy); 
        vertex(xx-sss, yy);
        fill(0, 40);
        vertex(xx, yy-sss);
        vertex(xx+sss, yy-sss);
        endShape(CLOSE);
        beginShape();
        fill(0, 80);
        vertex(xx, yy); 
        vertex(xx, yy+sss);
        fill(0, 200);
        vertex(xx+sss, yy);
        vertex(xx+sss, yy-sss);
        endShape(CLOSE);
        //rect(xx, yy, ss*amp, ss*amp);
      }
    }
    popMatrix();

    hue.set("hue", random(0.2));
    filter(hue);
  }
}

color rampColor(float x, float y, float det) {
  float xx = noise(x*det+2.4, y*det+3.1); 
  float yy = noise(x*det+20.4, y*det+323.1);
  return getColor(lerp(xx, yy, noise(x*det+21, y*det+45.3))*colors.length*2);
}

int colors[] = {#08D9D6, #252A34, #FF2E63, #EAEAEA};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}