// mover camara con el mouse
// añadir popups



float time;
int seed = int(random(999999));

float detNoi = 0.001;
float desNoi = 0;
float angResNoi = 4;
int noiseDet = 4;

float velTime = 0.1;
float velOscTime = random(10);
float ampOscTime = random(1);
float desTime = random(0.1);
float angle = 0;
float velAngle = 0;

float ampView = 1.6;

int countLines = 2000;
int largeLines = 20;
float velLines = 4;
float alphaLines = 40;


boolean exportVideo = false;
String  folderName = "export";
float secondsVideo = 40;

import controlP5.*;

ControlP5 cp5;
Accordion accordion;

void setup() {
  size(960, 540, P2D);
  smooth(4);
  pixelDensity(2);

  gui();

  randomParams();
  generate();
}

void gui() {

  cp5 = new ControlP5(this);


  Group g1 = cp5.addGroup("Noise")
    .setBackgroundColor(color(0, 64))
    .setBackgroundHeight(150);
  ;

  cp5.addSlider("detNoi")
    .setPosition(10, 10)
    .setRange(0, 0.02)
    .moveTo(g1);
  ;
  cp5.addSlider("desNoi")
    .setPosition(10, 30)
    .setRange(0, 60)
    .moveTo(g1);
  ;
  cp5.addSlider("angResNoi")
    .setPosition(10, 50)
    .setRange(0, 140)
    .moveTo(g1);
  ;
  cp5.addSlider("noiseDet")
    .setPosition(10, 70)
    .setRange(1, 8)
    .moveTo(g1);
  ;

  Group g2 = cp5.addGroup("Time")
    .setBackgroundColor(color(0, 64))
    .setBackgroundHeight(150);
  ;

  cp5.addSlider("velTime")
    .setPosition(10, 10)
    .setRange(0, 0.1)
    .moveTo(g2);
  ;
  cp5.addSlider("velOscTime")
    .setPosition(10, 30)
    .setRange(0, 8)
    .moveTo(g2);
  ;
  cp5.addSlider("ampOscTime")
    .setPosition(10, 50)
    .setRange(0, 0.2)
    .moveTo(g2);
  ;
  cp5.addSlider("desTime")
    .setPosition(10, 70)
    .setRange(0, 2)
    .moveTo(g2);
  ;
  cp5.addSlider("angle")
    .setPosition(10, 90)
    .setRange(0, TAU)
    .moveTo(g2);

  ;
  cp5.addSlider("velAngle")
    .setPosition(10, 110)
    .setRange(-2, 2)
    .moveTo(g2);
  ;


  Group g4 = cp5.addGroup("General")
    .setBackgroundColor(color(0, 64))
    .setBackgroundHeight(150);
  ;

  cp5.addSlider("ampView")
    .setPosition(10, 10)
    .setRange(0, 2)
    .moveTo(g4);
  ;

  Group g3 = cp5.addGroup("Lines")
    .setBackgroundColor(color(0, 64))
    .setBackgroundHeight(150);
  ;
  cp5.addSlider("countLines")
    .setPosition(10, 10)
    .setRange(0, 8000)
    .moveTo(g3);
  ;
  cp5.addSlider("largeLines")
    .setPosition(10, 30)
    .setRange(1, 500)
    .moveTo(g3);
  ;
  cp5.addSlider("velLines")
    .setPosition(10, 50)
    .setRange(0, 60)
    .moveTo(g3);
  ;
  cp5.addSlider("alphaLines")
    .setPosition(10, 70)
    .setRange(0, 255)
    .moveTo(g3);
  ;

  accordion = cp5.addAccordion("acc")
    .setPosition(10, 10)
    .setWidth(200)
    .addItem(g1)
    .addItem(g2)
    .addItem(g4)
    .addItem(g3)
    ;
}

void draw() {

  if (exportVideo) {
    time = frameCount/60.;
  } else {
    time = millis()*0.001;
  }

  pushMatrix();
  generate();
  popMatrix();

  for (int i = 0; i < colors.length; i++) {
    float xx = width-30*colors.length+i*30;
    float yy = 10;
    fill(colors[i]);
    noStroke();
    rect(xx, yy, 20, 20, 2);
  }

  if (exportVideo) {
    if (frameCount < secondsVideo*60) {
      saveFrame(folderName+"/f####.png");
    } else {
      exit();
    }
  }
}

void generate() {

  noiseSeed(seed);
  randomSeed(seed);
  background(255);


  translate(width*0.5, height*0.5);

  curvistas();
}

void randomParams() {
  seed = int(random(10000));
  //generate();
  println(seed);


  cp5.getController("desNoi").setValue(random(60));
  cp5.getController("detNoi").setValue(random(0.0001, 0.02));
  cp5.getController("angResNoi").setValue(int(random(120)));
  cp5.getController("noiseDet").setValue(int(random(9)));

  cp5.getController("velTime").setValue(random(0.1)*random(1)*random(1));
  cp5.getController("desTime").setValue(random(0.1)*random(1));
  cp5.getController("velOscTime").setValue(random(10));
  cp5.getController("ampOscTime").setValue(random(0.2));

  cp5.getController("ampView").setValue(random(2));

  cp5.getController("angle").setValue(random(TAU));
  cp5.getController("velAngle").setValue(random(-0.2, 0.2)*random(0.5));

  cp5.getController("countLines").setValue(int(random(6000)*random(0.2, 1)));
  cp5.getController("largeLines").setValue(int(random(120000/countLines)*random(0.02, 1)));
  cp5.getController("velLines").setValue(random(20)*random(0.1, 1));
  cp5.getController("alphaLines").setValue(random(255)*random(1));
}



void keyPressed() {
  if (key == 's') {
    saveImage();
  } else if (key == ' ') {
    randomParams();
  }
}

void curvistas() {
  float res = angResNoi;
  float vel = velLines;

  noiseDetail(noiseDet);
  float osc = (cos(time*velOscTime))*ampOscTime;
  float tt = time*(1+osc)*velTime;
  float ang = angle+time*velAngle;

  float movLines = tt*0;

  float x, y, a;
  noFill();
  for (int i = 0; i < countLines; i++) {
    x = (pow(noise(i, movLines), 0.8)-0.5)*width*ampView; 
    y = (pow(noise(movLines, i), 0.8)-0.5)*height*ampView; 
    int col = rcol();
    stroke(col, alphaLines);
    noFill();
    beginShape();
    vertex(x, y);
    float ttt = tt+i*0.00001*desTime;
    for (int j = 0; j < largeLines; j++) {
      a = ang+noise(desNoi+x*detNoi, desNoi+y*detNoi, ttt)*TAU*res;
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