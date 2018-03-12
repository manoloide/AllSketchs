import controlP5.*;
import peasy.*;
import SimpleOpenNI.*;

ControlP5 cp5;
SimpleOpenNI  context;

Timeline timeline;


int steps = 4;
float minDist = 1;
float maxDist = 4000;
float size = 3;
float desx = 14;
float desy = 30;
int type = 0;

float cameraX, cameraY, cameraZ;
float rotX, rotY, rotZ;

void setup() {
  size(1280, 720, P3D);

  textFont(createFont("Supply-Regular", 80, true));

  //initKinect();

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
    .setRange(0, 4000)
      .setValue(maxDist)
        .setPosition(20, 60)
          .setSize(100, 10);
  cp5.addSlider("size")
    .setRange(0, 10)
      .setValue(size)
        .setPosition(20, 80)
          .setSize(100, 10);

  cp5.addSlider("desx")
    .setRange(-30, 30)
      .setValue(desx)
        .setPosition(20, 100)
          .setSize(100, 10);


  cp5.addSlider("desy")
    .setRange(-30, 30)
      .setValue(desy)
        .setPosition(20, 120)
          .setSize(100, 10);

  cp5.addRadioButton("type")
    .setPosition(20, 140)
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

  timeline = new Timeline();
}

void draw() {
  timeline.update();

  background(0, 0, 0);

  if (context == null) {
    textSize(80); 
    textAlign(CENTER, CENTER);
    fill(46+cos(frameCount*0.1)*4);
    text("NO KINECT", width/2, height/2);
    textSize(18); 
    text("-press 'o' open file or 'k' init kinect-", width/2, height/2+50);
    return;
  }

  context.update();
  PImage  rgbImage = context.rgbImage();
  int[]   depthMap = context.depthMap();
  int     index, indexCol;
  PVector realWorldPoint;
  color   pixelColor;

  strokeWeight(size);
  pushMatrix();
  translate(cameraX, cameraY, cameraZ);

  PVector[] realWorldMap = context.depthMapRealWorld();
  int dx = int(desx);
  int dy = int(desy);
  if (type == 0) {
    for (int i = 0; i < 1; i++) {
      beginShape(POINTS);
      float det = 0.05;
      float tt = frameCount*0.03;
      for (int y=0; y < context.depthHeight (); y+=steps) {
        for (int x=0; x < context.depthWidth (); x+=steps) {
          index = x + y * context.depthWidth();
          indexCol = (x+dx) + (y+dy) * context.depthWidth();

          if ((x+dx) < 0 || (x+dx) >=  rgbImage.width ||  (y+dy) < 0 || (y+dy) >=  rgbImage.height) continue;
          if (depthMap[index] > minDist && depthMap[index] < maxDist) { 
            pixelColor = rgbImage.pixels[indexCol];
            stroke(pixelColor);
            realWorldPoint = realWorldMap[index];
            float des = 0;
            //float des = noise(x*det+tt, y*det+tt);
            //des = des * abs(frameCount%120-60)*50;
            vertex(realWorldPoint.x, realWorldPoint.y, realWorldPoint.z+des);
          }
        }
      } 
      endShape();
    }
  } else if (type == 1) {
    beginShape(TRIANGLE_STRIP);
    noFill();
    translate(0, 0, -400);
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

  /*
  view = timeline.getBoolean("view");
   x = timeline.getFloat("x");
   y = timeline.getFloat("y");
   s = timeline.getFloat("dim");
   noStroke();
   fill(220);
   if (view)
   ellipse(x, y, s, s);
   */


  hint(DISABLE_DEPTH_TEST);
  cp5.draw();
  timeline.show();
  hint(ENABLE_DEPTH_TEST);
}

void keyPressed() {
  if (key == 'k') {
    initKinect();
  }
  if (key == 'o') {
    selectInput("Open file oni:", "fileSelected");
  }
  timeline.keyPressed();
}

void keyReleased() {
  timeline.keyReleased();
}

void mousePressed() {
  timeline.mousePressed();
}

void mouseDragged() {
  timeline.mouseDragged();
}

void mouseReleased() {
  timeline.mouseReleased();
}

void mouseWheel(MouseEvent event) {
  timeline.mouseWheel(event);
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Error open file...");
  } else {
    println("Happy i load good file" + selection.getAbsolutePath());
    context = new SimpleOpenNI(this, selection.getAbsolutePath());
    if (context.isInit() == false) {
      println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
      context = null;
    }
  }
}

void initKinect() {
  context = new SimpleOpenNI(this);
  if (context.isInit() == false) {
    println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
    context = null;
  } else {
    // mirror is by default enabled
    context.setMirror(true);
    context.enableDepth();
    context.enableRGB();

    context.alternativeViewPointDepthToImage();
    context.setDepthColorSyncEnabled(true);
  }
}

