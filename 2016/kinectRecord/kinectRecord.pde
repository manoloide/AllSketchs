import SimpleOpenNI.*;

SimpleOpenNI  context;

boolean initRecord = false;
boolean record = false;
long initTime;
String fileName; 

void setup() {
  size(640*2, 480);

  context = new SimpleOpenNI(this);

  frameRate(30);

  //context.setMirror(true);
  context.enableDepth();
  context.enableRGB();
}

void draw() {
  context.update();

  if ((context.nodes() & SimpleOpenNI.NODE_DEPTH) != 0) {
    if ((context.nodes() & SimpleOpenNI.NODE_IMAGE) != 0) {
      image(context.depthImage(), 0, 0);   
      image(context.rgbImage(), context.depthWidth(), 0);
    } else {
      image(context.depthImage(), 0, 0);
    }
  }

  if (record) {
    if (initRecord) {
      initTime = millis(); 
      initRecord = false;
    }

    if (frameCount%30 < 15) {
      noStroke();
      fill(255, 0, 0, 200);
      ellipse(width/2, height/2, 200, 200);
    }

    fill(255);
    text("time: "+int(millis()-initTime)/1000., 20, 20);
  }
}


void keyPressed() {
  if (key == ' ') {
    record = !record;
    if (record) {
      initRecord = true;
      initTime = millis(); 
      fileName = getTimeStamp()+".oni";
      context.enableRecorder(fileName);
      context.addNodeToRecording(SimpleOpenNI.NODE_DEPTH, true);
      context.addNodeToRecording(SimpleOpenNI.NODE_IMAGE, true);
    } else {
      delay(2000);
      exit();
    }
  }
}

String getTimeStamp() {
  return  year() + "_" + nf(month(), 2) + "_" +  nf(day(), 2) + "-"  + nf(hour(), 2) + "_" +  nf(minute(), 2) + "_" +  nf(second(), 2);
}

