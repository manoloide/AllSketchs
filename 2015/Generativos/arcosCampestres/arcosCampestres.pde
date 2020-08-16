import java.io.FilenameFilter;
import processing.pdf.*;

boolean pdf = true;
int numberFile;
void setup() {
  size(800, 400);
  calculateNumber();
  generar();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else generar();
}

void generar() {
  if (pdf)  beginRecord(PDF, numberFile+".pdf"); 
  background(240);

  float tt = height*random(0.8)*random(0.1, 1);
  float ss = height*random(0.1, 0.2);

  int cw = int(width/(tt+ss));
  int ch = int(height/(tt+ss));

  float sw = (width-(tt*cw+ss*(cw-1)))/2+tt/2; 
  float sh = (height-(tt*ch+ss*(ch-1)))/2+tt/2; 

  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      float x = sw + i*(tt+ss);
      float y = sh + j*(tt+ss);

      int mc = 8;
      float a = int(random(mc));
      int c = 0;
      noStroke();
      while (c < mc) {
        int nc = int(random(mc-c)+1);
        fill(random(255), random(100, 255), random(100));
        arc(x, y, tt, tt, (a+c)*PI/4, (a+c+nc)*PI/4);
        c += nc;
      }
      //ellipse(x, y, tt, tt);
    }
  }


  if (pdf) endRecord();
}

void saveImage() {
  calculateNumber();
  if (pdf) {
    numberFile++;
  } else {
    saveFrame(nf(numberFile, 3)+".png");
  }
}

void calculateNumber() {
  String ext = (pdf)? ".pdf" : ".png";
  numberFile = ((new File(sketchPath)).listFiles(new FilenameFilter() {
    public boolean accept(File dir, String name) {
      return name.toLowerCase().endsWith(".pdf");
    }
  }
  )).length+1;
}

