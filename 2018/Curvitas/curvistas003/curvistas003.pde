float det, des;
float time;
int seed = 4579;//int(random(999999));


boolean exportVideo = false;
String  folderName = "export";
float secondsVideo = 40;


void setup() {
  size(960, 540, P2D);
  smooth(4);
  pixelDensity(2);
  noiseDetail(3);

  generate();
}

void draw() {
  
  if (exportVideo) {
    time = frameCount/60.;
  } else {
    time = millis()*0.001;
  }

  generate();
  
    if (exportVideo) {
    if (frameCount < secondsVideo*60) {
      saveFrame(folderName+"/f####.png");
    } else {
      exit();
    }
  }
}

void keyPressed() {
  if (key == 's') {
    saveImage();
  } else {
    seed = int(random(10000));
    //generate();
    println(seed);
  }
}

void generate() {

  float t = time*pow(constrain(map(frameCount, 0, 60*20, 0, 1), 0, 1), 1.3)*0.1;

  noiseSeed(seed);
  randomSeed(seed);
  background(255);
  
  translate(width*0.5, height*0.5);

  float des = random(10000);
  float det = random(0.001, 0.01)*1.4;

  noiseDetail(int(random(4)));
  float res = int(random(120));
  float tt = t*random(1)*random(0.2, 1);
  float ang = random(TAU)+tt*random(-2, 2)*random(0.5);

  float x, y, a;
  float dt = random(1);
  float vel = 4;
  noFill();
  for (int i = 0; i < 8000; i++) {
    x = (pow(noise(i, tt), 0.8)-0.5)*width*1.2; 
    y = (pow(noise(tt, i), 0.8)-0.5)*height*1.2; 
    int col = rcol();

    stroke(col, 40);
    noFill();
    beginShape();
    vertex(x, y);
    float ttt = tt+i*0.00001*dt;
    for (int j = 0; j < 20; j++) {
      a = ang+noise(des+x*det, des+y*det, ttt)*TAU*res;
      x += cos(a)*vel;
      y += sin(a)*vel;
      vertex(x, y);
    }
    endShape();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+".png");
}

//int colors[] = {#FDFDFD, #BBC9D4, #6CD1B3, #FB7C69, #3A66E3, #0D2443};
int colors[] = {#000000, #33346B, #567BF6, #B4CAFB, #FFFFFF, #FFB72A, #FF4C3D};
//int colors[] = {#040001, #050F32, #FFFFFF, #050F32, #26A9C5, #FFFFFF, #E50074};
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