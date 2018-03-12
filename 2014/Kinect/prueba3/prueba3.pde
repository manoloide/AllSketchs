import SimpleOpenNI.*; //<>//

SimpleOpenNI context;
float        zoomF =0.3f;
float        rotX = radians(180);
float        rotY = radians(0);
int          steps = 1;
PFont helve;

void setup() {
  size(1024, 768, P3D);
  frame.setResizable(true);
  helve = createFont("Helvetica Neue Bold", 120, true);
  context = new SimpleOpenNI(this, SimpleOpenNI.RUN_MODE_MULTI_THREADED);
  textureMode(NORMAL);
  //context = new SimpleOpenNI(this);
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
  perspective(radians(45), 
  float(width)/float(height), 
  10, 150000);
}


void draw() {
  if (frameCount%10 == 0) frame.setTitle("FPS:"+frameRate);
  // update the cam
  context.update();
  //background(#251830);

  //rotX = PI+cos((((frameCount%126)-63)/63.)*PI)/5;
  //rotY = cos((((frameCount%80)-40)/40.)*TWO_PI);

  translate(width/2, height/2, 0);
  rotateX(rotX);
  rotateY(rotY);
  scale(zoomF);

  PImage  rgbImage = context.rgbImage();
  int[]   depthMap = context.depthMap();
  int     steps   = 2;  // to speed up the drawing, draw every third point
  int     index;
  PVector realWorldPoint;
  color   pixelColor;

  translate(-283, -86, -1712);  // set the rotation center of the scene 1000 infront of the camera

  PVector[] realWorldMap = context.depthMapRealWorld();
  for (int y=steps; y < context.depthHeight ()-steps; y+=steps) {
    for (int x=steps; x < context.depthWidth ()-steps; x+=steps) {
      index = x + y * context.depthWidth();
      if (depthMap[index] > 0 && depthMap[index] < 2000) { 
        // get the color of the point
        pixelColor = rgbImage.pixels[index];
        stroke(250);
        noStroke();
        fill(pixelColor);
        // draw the projected point
        realWorldPoint = realWorldMap[index];
        PVector ant1 = realWorldMap[(x-steps) + y * context.depthWidth()];
        PVector ant2 = realWorldMap[x + (y-steps) * context.depthWidth()];
        if (ant1.z > 10 && ant2.z > 10) {
          beginShape(TRIANGLE_FAN);
          vertex(ant1.x, ant1.y, ant1.z);
          vertex(realWorldPoint.x, realWorldPoint.y, realWorldPoint.z);
          vertex(ant2.x, ant2.y, ant2.z);
          endShape(CLOSE);
        }
        ant1 = realWorldMap[(x+steps) + y * context.depthWidth()];
        ant2 = realWorldMap[x + (y+steps) * context.depthWidth()];
        if (ant1.z > 10 && ant2.z > 10) {
          beginShape(TRIANGLE_FAN);
          vertex(ant1.x, ant1.y, ant1.z);
          vertex(realWorldPoint.x, realWorldPoint.y, realWorldPoint.z);
          vertex(ant2.x, ant2.y, ant2.z);
          endShape(CLOSE);
          //stroke(250);
          //line(ant1.x, ant1.y, ant1.z, ant2.x, ant2.y, ant2.z);
        }
      }
    }
  } 
  textFont(helve);
  fill(250);
  rotateX(PI);
  textAlign(CENTER, CENTER);
  text("Manoloide!", -48, -189+cos(abs(frameCount%60-30)/30.*TWO_PI)*10, -924);
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


void keyPressed() {
  switch(key) {
  case ' ':
    context.setMirror(!context.mirror());
    break;
  case 'a':
    
  case 's':
    saveFrame("holisss#####.png");
    break;
  }

  switch(keyCode) {
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
    if (keyEvent.isShiftDown()) {
      zoomF -= 0.02f;
      if (zoomF < 0.01)
        zoomF = 0.01;
    } else
      rotX -= 0.1f;
    break;
  }
}

PImage crearDegrade(int w, int h, color c1, color c2) {
  PImage aux = createImage(w, h, RGB);
  for (int j = 0; j < h; j++) {
    color c = lerpColor(c1, c2, map(j, 0, h, 0, 1));
    for (int i = 0; i < w; i++) {
      color ac = c;
      if ((i+j)%2 == 0) {
        ac = lerpColor(c, color(0), 0.08);
      }
      aux.set(i, j, ac);
    }
  }
  return aux;
}
