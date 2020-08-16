import toxi.math.noise.SimplexNoise;

//920141 48273 79839 883078 488833 773004
int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

boolean export = false;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P3D);
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

void generate() {

  background(0);

  noiseSeed(seed);
  randomSeed(seed);

  hint(DISABLE_DEPTH_TEST);


  for (int k = 0; k < 80; k++) {
    float cx = width*random(1);//*0.5;
    float cy = height*random(1);//*0.5;

    cx -= cx%40;
    cy -= cy%40;

    float s = random(200, 500)*random(0.8, 1);

    float d1 = random(0.08)*random(1)*5;
    float d2 = random(0.08)*random(1)*5;
    float dd1 = random(1000);
    float dd2 = random(1000);
    float d = random(1000);
    float ampRad = random(1)*random(1)*random(1)*2;
    float ic = int(random(colors.length));

    float rot = random(TAU);

    int rings = int(random(2, 40)*random(0.2, 1));

    pushMatrix();
    translate(cx, cy);

    rotateX(random(PI)*random(-1, 1)*random(1)*0.01);
    rotateY(random(PI)*random(-1, 1)*random(1)*0.01);
    rotateZ(random(PI)*random(-1, 1)*random(1)*0.01);
    for (int j = 0; j < rings; j++) {

      translate(0, 0, 0.1);

      float amp = map(j, 0, rings, 1, 0.1);
      //ellipse(cx, cy, s*amp, s*amp);
      noStroke();
      //noFill();
      //fill(255, 10);
      //strokeWeight(2);
      int col = getColor(ic+j*0.5);
      int col2 = lerpColor(col, color(0), 0.2);
      int sub = int(max((amp*s*PI*0.3), 3));

      float xs[] = new float[sub];
      float ys[] = new float[sub];

      beginShape();
      for (int i = 0; i < sub; i++) {
        float a = map(i, 0, sub, 0, TAU);
        float ang = (float) SimplexNoise.noise(cos(a)*d1+d+dd1, sin(a)*d1+dd1)*ampRad;
        float rad = pow((float) SimplexNoise.noise(cos(ang)*d2+dd2, sin(a)*d2+d+dd2)*0.9+0.1, 0.4)*s;
        xs[i] = cos(a+rot)*rad*amp;
        ys[i] = sin(a+rot)*rad*amp;
      }
      endShape(CLOSE);


      beginShape(TRIANGLES);
      for (int i = 0; i < sub; i++) {
        fill(col2);
        vertex(0, 0);
        fill(col);
        vertex(xs[i%sub], ys[i%sub]);
        vertex(xs[(i+1)%sub], ys[(i+1)%sub]);
      }
      endShape();
    }

    popMatrix();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(99999));
    generate();
  }
}

int colors[] = {#ED61DA, #200C2B, #0029BF, #FFE760, #DBD1CB};
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
  return lerpColor(c1, c2, pow(v%1, 0.8));
}
