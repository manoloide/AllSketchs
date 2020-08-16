import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

void setup() {
  size(960, 960, P3D); 
  pixelDensity(2);
  smooth(8);
  generate();
}

long timePrev;
float delta, des;
void draw() {

  //hint(DISABLE_DEPTH_TEST);
  noiseSeed(seed);
  randomSeed(seed);

  long time = System.currentTimeMillis()%100000;
  if (frameCount == 1) {
    timePrev = 0;
  }
  delta = (time - timePrev) / 1000.0f;
  timePrev = time;

  des += delta*random(0.002);

  //background(#e5e7ea);
  ambientLight(120, 120, 120);
  directionalLight(10, 20, 30, 0, -0.5, -1);
  lightFalloff(0, 1, 0);
  directionalLight(180, 160, 160, -0.8, +0.5, -1);

  ortho();
  translate(width*0.5, height*0.5, -500);
  rotateX(PI*0.25);
  rotateZ(PI*0.25);

  float div = int(pow(2, int(random(5, 8))));
  float size = width*0.9;
  noStroke();
  for (int i = 0; i < 400; i++) {
    float x = lerp(-size, size, noise(i, des));
    float y = lerp(-size, size, noise(i+10, des));
    float z = lerp(-size, size, noise(i+100, des)); 

    /*
    x -= (x%div)*0.5;
     y -= (y%div)*0.5;
     z -= (z%div)*0.5;
     */

    float w = div*pow(random(1), 0.8)*random(15)*cos(time*random(0.0001));
    float h = div*pow(random(1), 0.8)*random(15)*cos(time*random(0.0001));
    float d = div*pow(random(1), 0.8)*random(15)*cos(time*random(0.0001));

    /*
    if (random(1) < 0.8) {
     x -= x%div;
     y -= y%div;
     z -= z%div;
     }
     */

    float sca = (time*random(0.0001)+random(1))%1*random(1)*random(1);

    pushMatrix();
    translate(x, y, z);
    fill(lerpColor(rcol(), color(255), pow(cos(time*0.0002*random(1)+random(10)), random(1, 2))), 10);
    box(w*sca, h*sca, d*sca);
    popMatrix();
  }
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {

  noiseSeed(seed);
  randomSeed(seed);

  //background(#e5e7ea);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#81C7EF, #2DC3BA, #BCEBD2, #F9F77A, #F8BDD3, #272928};
//int colors[] = {#DEE2E3, #E7BD07, #DEE2E3, #4FAEE6, #0A142B, #19645D, #D07EBA, #DE5621};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v)%1;
  int ind1 = int(v*colors.length);
  int ind2 = (int((v)*colors.length)+1)%colors.length;
  int c1 = colors[ind1]; 
  int c2 = colors[ind2]; 
  return lerpColor(c1, c2, (v*colors.length)%1);
}
