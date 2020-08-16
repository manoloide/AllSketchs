import processing.video.*;

Capture video;
LutFilter lut;
File[] luts;

int numberLut = 0; 
float intesity = 0.5;

void setup() {
  size(640, 480);
  frameRate(30);
  video = new Capture(this, width, height);
  video.start();  


  File folderLut = new File(sketchPath("LUTs"));
  luts = folderLut.listFiles();

  lut = new LutFilter(luts[numberLut].toString());

  background(0);
}


void draw() { 
  if (video.available()) {
    video.read();
    image(lut.apply(video, intesity), 0, 0);
  }
}

void keyPressed() {
  if (keyCode == RIGHT) {
    numberLut++;
    numberLut = numberLut%luts.length;
    lut.load(luts[numberLut].toString());
  }else if(keyCode == LEFT){
    numberLut--;
    if(numberLut < 0)numberLut = luts.length-1;
    lut.load(luts[numberLut].toString());
  }
  else if(keyCode == UP){
     intesity+=0.1;
    if(intesity > 1) intesity = 1; 
  }
  else if(keyCode == DOWN){
     intesity -= 0.1;
    if(intesity < 0) intesity = 0; 
  }
}

