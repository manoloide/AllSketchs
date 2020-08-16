import controlP5.*;
import peasy.*;
import SimpleOpenNI.*;

ControlP5 cp5;
SimpleOpenNI  context;
PeasyCam cam;

int steps = 4;
float minDist = 1;
float maxDist = 2000;
float size = 1;
int type = 0;

void setup() {
  size(1280, 729, P3D);
  context = new SimpleOpenNI(this);
  if (context.isInit() == false) {
    println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
    exit();
    return;
  }

  // mirror is by default enabled
  context.setMirror(true);
  context.enableDepth();
  context.enableRGB();

  context.alternativeViewPointDepthToImage();
  context.setDepthColorSyncEnabled(true);

  cp5 = new ControlP5(this);
  cp5.addSlider("steps")
    .setRange(1, 10)
      .setValue(steps)
        .setPosition(20, 20)
          .setSize(100, 10);
  cp5.addSlider("minDist")
    .setRange(0, 2000)
      .setValue(minDist)
        .setPosition(20, 40)
          .setSize(100, 10);
  cp5.addSlider("maxDist")
    .setRange(0, 2000)
      .setValue(maxDist)
        .setPosition(20, 60)
          .setSize(100, 10);
  cp5.addSlider("size")
    .setRange(0, 10)
      .setValue(size)
        .setPosition(20, 80)
          .setSize(100, 10);

  cp5.addRadioButton("type")
    .setPosition(20, 120)
      .setItemWidth(20)
        .setItemHeight(20)
          .addItem("points", 0)
            .addItem("grid", 1)
              .addItem("box", 2)
                .addItem("lines", 3)
                  .addItem("grey", 4)
                    .setColorLabel(color(255));


  cp5.setAutoDraw(false);
  /*
  cp5.addSlider("detalle")
   .setRange(0, 0.02)
   .setValue(detalle)
   .setPosition(20, 40)
   .setSize(100, 10);
   */

  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(5000);
}

void draw() {
  context.update();
  background(0, 0, 0);

  PImage  rgbImage = context.rgbImage();
  int[]   depthMap = context.depthMap();
  int     index;
  PVector realWorldPoint;
  color   pixelColor;

  strokeWeight(size);
  pushMatrix();
  translate(0, 0, -1000);

  PVector[] realWorldMap = context.depthMapRealWorld();

  if (type == 0) {
    beginShape(POINTS);
    for (int y=0; y < context.depthHeight (); y+=steps) {
      for (int x=0; x < context.depthWidth (); x+=steps) {
        index = x + y * context.depthWidth();
        if (depthMap[index] > minDist && depthMap[index] < maxDist) { 
          pixelColor = rgbImage.pixels[index];
          stroke(pixelColor);
          realWorldPoint = realWorldMap[index];
          vertex(realWorldPoint.x, realWorldPoint.y, realWorldPoint.z);
        }
      }
    } 
    endShape();
  } else if (type == 1) {
    beginShape(TRIANGLE_STRIP);
    noFill();
    for (int y=0; y < context.depthHeight (); y+=steps) {
      for (int x=0; x < context.depthWidth (); x+=steps) {
        index = x + y * context.depthWidth();
        if (depthMap[index] > minDist && depthMap[index] < maxDist) { 
          pixelColor = rgbImage.pixels[index];
          stroke(pixelColor);
          realWorldPoint = realWorldMap[index];
          vertex(realWorldPoint.x, realWorldPoint.y, realWorldPoint.z);
        }
      }
    } 
    endShape();
  } else if (type == 2) {
    ambientLight(200, 200, 200);
    directionalLight(128, 128, 128, 0, 0, 1);
    lightFalloff(1, 0, 0);
    lightSpecular(0, 0, 0);
    noStroke();
    for (int y=0; y < context.depthHeight (); y+=steps) {
      for (int x=0; x < context.depthWidth (); x+=steps) {
        index = x + y * context.depthWidth();
        if (depthMap[index] > minDist && depthMap[index] < maxDist) { 
          pixelColor = rgbImage.pixels[index];
          fill(pixelColor);
          realWorldPoint = realWorldMap[index];
          pushMatrix();
          translate(realWorldPoint.x, realWorldPoint.y, realWorldPoint.z);
          box(size);
          popMatrix();
        }
      }
    }
  } else if (type == 3) {
    noFill();
    for (int y=0; y < context.depthHeight (); y+=steps) {
      beginShape();
      for (int x=0; x < context.depthWidth (); x+=steps) {
        index = x + y * context.depthWidth();
        if (depthMap[index] > minDist && depthMap[index] < maxDist) { 
          pixelColor = rgbImage.pixels[index];
          stroke(pixelColor);
          realWorldPoint = realWorldMap[index];
          vertex(realWorldPoint.x, realWorldPoint.y, realWorldPoint.z);
        }
      }
    } 
  } 

  popMatrix();


  hint(DISABLE_DEPTH_TEST);
  cam.beginHUD();
  cp5.draw();
  cam.endHUD();
  hint(ENABLE_DEPTH_TEST);
}

void type(int a) {
  type = a;
}

