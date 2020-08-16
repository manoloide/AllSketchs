import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));
float time;

boolean exportVideo = false;
float totalTime = 6;

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
  stroke(0, 40);
  strokeWeight(0.02);

  pushMatrix();
  fill(255);
  translate(0, 0, 0.9);
  box(180);
  popMatrix();
  
  
  
  rectMode(CENTER);
  for(int i = 0; i < 20; i++){
     pushMatrix();
     translate(random(-width, width), random(-width, width), random(-10, 10));
     scale(1+cos(time*random(100)*random(1))*0.4);
     float s = random(120);
     fill(rcol());
     rect(0, 0, s, s);
     
     for(int j = 1; j < 8; j++){
       pushMatrix();
       translate(0, 0, 8+8*j);
       fill(rcol());
       ellipse(0, 0, s*0.2, s*0.2);
       popMatrix();
     }
     popMatrix();
  }
  
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
