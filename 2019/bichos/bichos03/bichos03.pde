import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

ArrayList<Bicho> bichos;
void setup() {
  size(displayWidth, displayHeight, P3D); 
  pixelDensity(2);
  smooth(8);
  generate();
}

long timePrev;
float delta;
void draw() {

  hint(DISABLE_DEPTH_TEST);

  long time = System.currentTimeMillis()%100000;
  if (frameCount == 1) {
    timePrev = 0;
  }
  delta = (time - timePrev) / 1000.0f;
  timePrev = time;

  //println(timePrev, delta);

  //for (int j = 0; j < 8; j++) {
  for (int i = 0; i < bichos.size(); i++) {
    Bicho b = bichos.get(i);
    b.update(delta*0.8);
    b.show();
  }
  //}
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

  background(random(40, 80));
  bichos = new ArrayList<Bicho>();
  for (int i = 0; i < 100; i++) {
    bichos.add(new Bicho());
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#8395FF, #FD674E, #FCC8FF, #1CB377, #FCD500};
//int colors[] = {#BF28ED, #1C0A26, #0029C1, #5BFFBB, #EAE4E1};
//int colors[] = {#EF9F00, #E56300, #D15A3D, #D08C8B, #68376D, #013152, #3F8090, #8EB4A8, #E5DFD1};
//int colors[] = {#2E0006, #5B0D1C, #DA265A, #A60124, #F03E90};
int colors[] = {#01D8EA, #005DDA, #1B2967, #5E0D4A, #701574, #C65B35, #FEB51B, #CDB803, #66BB06};
//int colors[] = {#01D8EA, #005DDA, #1B2967, #5E0D4A, #701574, #C65B35, #FEB51B, #66BB06};
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
  return lerpColor(c1, c2, pow(v%1, 1.2));
}
