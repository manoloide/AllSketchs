import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));
float time;

boolean exportVideo = false;
float totalTime = 16;

void setup() {
  size(720, 720, P3D);
  smooth(8);
  pixelDensity(2);

  frameRate(30);
  generate();
}

void draw() {

  if (exportVideo) {
    time = map(frameCount, 0, 30*totalTime, 0, 1);
  } else {
    time = (millis()*1./totalTime)*0.001;
  }

  time = time%1;

  randomSeed(seed);
  noiseSeed(seed);
  noiseDetail(4);

  render();

  if (exportVideo) {
    int frame = frameCount;//int(frameCount/2);
    String fileName = "export/f"+nf(frame, 4)+".png";
    saveFrame(fileName);

    float second = frame*(1./30);
    if (second > totalTime) {
      exit();
    }
  }
}

void render() {


  background(#EFF1F4);
  ambientLight(120, 120, 120);
  directionalLight(10, 20, 30, 0, -0.5, -1);
  lightFalloff(0, 1, 0);
  directionalLight(180, 160, 160, -0.8, +0.5, -1);
  //lightFalloff(1, 0, 0);
  //lightSpecular(0, 0, 0);

  ortho();
  translate(width*0.5, height*0.5);
  rotateX(PI*(0.25));
  rotateZ(PI*(0.25+time*0.5)-0.24);

  float tc = ((time+0.2)%1)*1.4;
  //tc = 0.9;
  if (tc > 1) tc = map(tc, 1, 1.4, 1, 0);

  //tc = 0.99;

  scale(map(pow(tc, 2), 0, 1, 0.8, 38));

  int cc = 2;
  float sep = random(23, 32)*10;

  int sub = 12;
  float sep2 = (1./sub);

  stroke(0, 40);
  strokeWeight(0.02);

  fill(255);
  for (int j = -cc; j < cc+1; j++) {
    for (int i = -cc; i < cc+1; i++) {
      pushMatrix(); 
      translate(i*sep, j*sep); 
      box(40); 
      for (int k = 0; k < sub; k++) {
        for (int l = 0; l < sub; l++) {
          pushMatrix(); 
          translate(l*sep2*sep, k*sep2*sep); 
          box(1.2); 
          popMatrix();
        }
      }
      popMatrix();
    }
  }

  fill(#6ABDFF);
  box(39.5);
  fill(#7AFF6A);
  box(39.5, 39.5, 0.02);

  for (int i = 0; i < 400; i++) {
    pushMatrix();
    fill(255*int(random(2-cos(time*random(200)))));
    translate(random(-19, 19), random(-19, 19), random(1, 2));
    box(0.2*random(0.2, 1));
    popMatrix();
  }

  pushMatrix();
  fill(255);
  translate(0, 0, 0.9);
  box(1.8);
  popMatrix();
}

void keyPressed() {
  generate();
}

void generate() {
  seed = int(random(99999));
}

int colors[] = {#81C7EF, #2DC3BA, #BCEBD2, #F9F77A, #F8BDD3, #272928}; 
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
