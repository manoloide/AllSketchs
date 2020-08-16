import java.awt.Desktop;
import processing.pdf.*;

boolean pdf = true;

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

int seed = int(random(99999999));
String filePDF;

void settings() {
  scale = nwidth/swidth;

  filePDF = "book001_"+getTimestap()+"_"+seed+".pdf";

  if (pdf) size(int(swidth*scale), int(sheight*scale), PDF, filePDF);
  else size(int(swidth*scale), int(sheight*scale), P2D);
}

void setup() {

  generate();

  if (pdf) {
    exit();
  }
}

void keyPressed() {
  generate();
}

void generate() {

  seed = int(random(99999999));

  randomSeed(seed);
  noiseSeed(seed);

  cover();

  for (int i = 0; i < 40; i++) {
    nextPage();
    grid001();
  }


  if (pdf) {
    try {
      File file = new File(sketchPath(filePDF));
      Desktop.getDesktop().open(file);
    } 
    catch(Exception e) {
      e.printStackTrace();
    }
    exit();
  }
}

void cover() {

  background(200);

  int cc = int(random(2, random(20, random(40, 90)*random(0.1, 1)*random(1))*random(0.1, 1)));
  float des = width*1./(cc+1.5);
  float bb = (width-des*cc)*0.5;

  noStroke();
  fill(255, 30);
  rectMode(CENTER);
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float xx = bb+(i+0.5)*des;
      float yy = bb+(j+0.5)*des;
      float ss = des*0.1;
      if (random(1) < 0.9) rect(xx, yy, ss, ss);
    }
  }

  textAlign(LEFT, TOP);

  fill(255);
  text("asdadasdasdasdas", width*0.1, height*0.1);
}

void nextPage() {
  PGraphicsPDF gpdf = (PGraphicsPDF) g;  // Get the renderer
  gpdf.nextPage();
}

String getTimestap() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  return  timestamp;
}

void saveImage() {
  String timestamp = getTimestap();
  saveFrame(timestamp+"-"+seed+".png");
}
