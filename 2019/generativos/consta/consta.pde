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

  //hint(DISABLE_DEPTH_MASK);
  lights();

  int cc = int(random(120, 160)*0.5);
  float ss = width*1./(cc+2);

  /*
  stroke(rcol());
   for (int j = 0; j <= cc; j++) {
   float v = ss*(j+1);
   line(v, ss, v, height-ss); 
   line(ss, v, width-ss, v);
   }
   */

  pushMatrix();
  translate(width*0.5, height*0.5);

  /*
  noStroke();
   for (int i = 0; i < 20; i++) {
   float a1 = random(TAU);
   float a2 = a1+random(PI);
   float s = width*random(0.9);
   fill(rcol(), 250);
   arc(0, 0, s, s, a1, a2);
   }
   */


  for (int i = 0; i < 30; i++) {
    pushMatrix();
    rotateX(random(TAU));
    rotateY(random(TAU));
    rotateZ(random(TAU));
    float s = width*random(0.3, 0.5);
    stroke(rcol());
    line(0, 0, 0, s, 0, 0);

    noStroke();
    fill(rcol());
    float sss = random(10, 20);

    int ccc = int(random(s/sss));

    for (int k = 0; k < 2; k++) {
      for (int j = 0; j < ccc; j++) {
        pushMatrix();
        translate(map(j, 0, ccc, s-sss*0.5, sss*0.5), (k-0.5)*sss*1.2, 0);
        box(sss*0.2, sss*0.5, sss*0.2);
        popMatrix();
      }
    }

    popMatrix();
  }

  popMatrix();
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

int colors[] = {#ED4248, #EF8228, #E5D242, #49BC88, #1E3059};
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
  return lerpColor(c1, c2, pow(v%1, 0.5));
}
