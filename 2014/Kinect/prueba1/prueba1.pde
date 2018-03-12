/* --------------------------------------------------------------------------
 * SimpleOpenNI AlternativeViewpoint3d Test
 * --------------------------------------------------------------------------
 * Processing Wrapper for the OpenNI/Kinect 2 library
 * http://code.google.com/p/simple-openni
 * --------------------------------------------------------------------------
 * prog:  Max Rheiner / Interaction Design / Zhdk / http://iad.zhdk.ch/
 * date:  12/12/2012 (m/d/y)
 * ----------------------------------------------------------------------------
 */

import SimpleOpenNI.*;

SimpleOpenNI context;
float        zoomF =0.3f;
float        rotX = radians(180);  // by default rotate the hole scene 180deg around the x-axis, 
// the data from openni comes upside down
float        rotY = radians(0);
PShape       pointCloud;
int          steps = 2;

void setup() {
  size(1024, 768, P3D);
  frame.setResizable(true);

  //context = new SimpleOpenNI(this,SimpleOpenNI.RUN_MODE_MULTI_THREADED);
  context = new SimpleOpenNI(this);
  if (context.isInit() == false)
  {
    println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
    exit();
    return;
  }

  // disable mirror
  context.setMirror(false);

  // enable depthMap generation 
  context.enableDepth();

  context.enableRGB();

  // align depth data to image data
  context.alternativeViewPointDepthToImage();
  context.setDepthColorSyncEnabled(true);

  stroke(255, 255, 255);
  smooth();
  perspective(radians(45), 
  float(width)/float(height), 
  10, 150000);
}

void draw() {
  frame.setTitle("FPS:"+frameRate);
  // update the cam
  context.update();

  background(0, 0, 0);

  //rotX = PI+cos((((frameCount%126)-63)/63.)*PI)/5;
  //rotY = cos((((frameCount%80)-40)/40.)*TWO_PI);

  translate(width/2, height/2, 0);
  rotateX(rotX);
  rotateY(rotY);
  scale(zoomF);

  PImage  rgbImage = context.rgbImage();
  int[]   depthMap = context.depthMap();
  int     steps   = 4;  // to speed up the drawing, draw every third point
  int     index;
  PVector realWorldPoint;
  color   pixelColor;

  strokeWeight((float)steps/2);

  translate(0, 0, -1000);  // set the rotation center of the scene 1000 infront of the camera

  PVector[] realWorldMap = context.depthMapRealWorld();
  beginShape(POINTS);
  for (int y=0;y < context.depthHeight();y+=steps)
  {
    for (int x=0;x < context.depthWidth();x+=steps)
    {
      index = x + y * context.depthWidth();
      if (depthMap[index] > 0)
      { 
        // get the color of the point
        pixelColor = rgbImage.pixels[index];
        stroke(pixelColor);

        // draw the projected point
        realWorldPoint = realWorldMap[index];
        vertex(realWorldPoint.x, realWorldPoint.y, realWorldPoint.z);  // make realworld z negative, in the 3d drawing coordsystem +z points in the direction of the eye
      }
    }
  } 
  endShape();
  //saveFrame("prueba####");
  // draw the kinect cam
  //strokeWeight(1);
  //context.drawCamFrustum();
}

void mouseWheel(MouseEvent event) {
  float e = event.getAmount();
  zoomF -= e/100;
}

void mouseDragged() {
  rotX -= (mouseY-pmouseY)/100.;
  rotY -= (mouseX-pmouseX)/100.;
}


void keyPressed()
{
  switch(key)
  {
  case ' ':
    context.setMirror(!context.mirror());
    break;
  case 's':
    saveFrame("holisss#####");
    break;
  }

  switch(keyCode) 
  {
  case LEFT:
    rotY += 0.1f;
    break;
  case RIGHT:
    // zoom out
    rotY -= 0.1f;
    break;
  case UP:
    if (keyEvent.isShiftDown())
      zoomF += 0.02f;
    else
      rotX += 0.1f;
    break;
  case DOWN:
    if (keyEvent.isShiftDown())
    {
      zoomF -= 0.02f;
      if (zoomF < 0.01)
        zoomF = 0.01;
    }
    else
      rotX -= 0.1f;
    break;
  }
}
