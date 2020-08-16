import toxi.math.noise.SimplexNoise;

int seed = 40;//int(random(99999999));

boolean export = false;
float timeExport = 40;
float tt;

PImage text;
PShader blur;

void setup() {
  size(1920, 1080, P2D);
  frameRate(30);
  smooth(4);
  blur = loadShader("blur.glsl");
  text = loadImage("circleGrad.png");

  background(255);
}


void draw() {



  if (frameCount%20 == 0) blur = loadShader("blur.glsl");

  float time = millis()*0.001;
  //if (export) 
  time = frameCount*1./(30);

  time *= 0.02;
  if (frameCount%int(120+time*0.1) == 0) {
    //generate();
  }


  tt += 1./2;
  tt = constrain(tt, 0, 1);

  randomSeed(seed);
  noiseSeed(seed);
  //filter(blur); 
  //filter(blur);  

  noStroke();

  /*
  int feed = -2;
   copy(0, 0, width, height, feed, feed, width-feed*2, height-feed*2);
   */
  float ic = random(1000);
  //float x = width*map(cos(time*1.8), -1, 1, 0.3, 0.7);
  //float y = height*(0.5+sin(time)*0.05);

  float it = random(1000);
  float velCol = 10.1;
  fill(map(cos(time*velCol), -1, 1, 0, 255));


  float grid = 40;

  int sub = 220;
  for (int i = 0; i < sub; i++) {
    float val = map(i, 0, sub, 1, 0);
    float s = max(abs(cos(time*0.71+i)*sin(time)), 0.3)*width*random(0.005, 0.02);

    float dd = i*0.004;

    float det = random(0.5);  
    float xx = (float) (SimplexNoise.noise(1, det*i, time)+0.5)*width;
    float yy = (float) (SimplexNoise.noise(det*i, 23, time)+0.5)*height;

    float dx = (xx%grid)-grid*0.5;
    float dy = (yy%grid)-grid*0.5;

    float vx = abs(dx)/(grid*0.5);
    float vy = abs(dy)/(grid*0.5);

    //xx = lerp(xx, xx+dx, vx);
    //yy = lerp(yy, yy+dy, vy);

    float timeCol = 0.1;

    float pwr = 1.1-val*0.4;

    int col = getColor(time*random(100)+random(200));

    boolean sprite = true;
    float ss = s*(1-val)*(0.2+cos(time+i)*0.2)*20;

    if (sprite) {
      imageMode(CENTER);
      tint(col, 250*tt);

      float osc = random(3)*time;

      image(text, xx, yy, ss*2, ss*2);
      tint(255, 90);
      //image(text, xx, yy, ss*(0.8+cos(osc)*0.4), ss*(0.8+cos(osc)*0.4));
    } else {
      fill(col, 180*tt);
      ellipse(xx, yy, ss, ss);
      fill(255, 220);
      ellipse(xx, yy, ss*0.8, ss*0.8);
    }
    noTint();
  }



  float osc1 = cos(time*random(12))*2;
  float osc2 = cos(time*random(12))*2;
  float blurAmp = map(cos(time*10), -1, 1, 0.001, 0.005)*0.04;

  blur.set("time", time+random(1000));
  for (int i = 0; i < 5; i++) {
    blur.set("direction", blurAmp*osc1, 0);
    filter(blur); 
    blur.set("direction", 0, blurAmp*osc2);
    filter(blur);
  }

  if (export) {
    if (frameCount > 900) exit();
    else saveFrame("export/####.png");
  }
}

void keyPressed() {
  generate();
}

void generate() {
  seed = int(random(9999999));
  tt = 0;
}

//int colors[] = {#CAB18A, #C99A4E, #2D2A10};
//int colors[] = {#CAB18A, #C99A4E, #2D2A10};
//int colors[] = {#F7743B, #9DAAAB, #6789AA, #4F4873, #3A3A3A};
int colors[] = {#F7513B, #6789AA, #4B4372, #262626};
//int colors[] = {#50A85F, #DD2800, #F2AF3C, #5475A8};
//int colors[] = {#FFCC33, #F393FF, #6666FF, #01CCCC, #EDFFFC};
//int colors[] = {#E8E6DD, #DFBB66, #D68D46, #857F5D, #809799, #5D6D83, #0F1C15};
//int colors[] = {#38684E, #D11D02, #BC9509, #5496A8};
//int colors[] = {#152425, #1D3740, #06263E, #074B7D, #094D88, #1D6C9E, #ff2000, #1D6C9E, #ff2010};
//int colors[] = {#EA0707, #58C908, #163572, #000000};
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
  return lerpColor(c1, c2, pow(v%1, 3.8));
}
