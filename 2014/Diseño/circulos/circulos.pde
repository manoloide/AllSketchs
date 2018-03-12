import java.awt.Desktop; //<>//
import java.io.File;
import processing.pdf.*;

boolean pdf = false;

void setup() {
  if (pdf) size(600, 800, PDF, "circulos.pdf");
  else size(600, 800);
  PFont helve = createFont("Helvetica Neue Bold", 80, true);
  PFont helvec = createFont("Mikiyu Font Mokomor-kuro", 24, true);
  PFont isoc = createFont("Isocpeur", 14, true);
  textFont(helve);
  smooth();
  background(#F5F5FC); 
  //blendMode(DIFFERENCE );
  float x = width/2;
  float y = height/2;
  float esp = 18;
  noFill();
  strokeCap(SQUARE);
  for (float i = esp/2; i < height; i+=esp) {
    strokeWeight(0.8);
    stroke(#E80730, 240);
    ellipse(x, y, i, i);
    int c = int(random(10, 10+(i/esp)*6));
    strokeWeight(random(0.2, 2));
    stroke(#004AFF, 240);
    float dis = 0.6;
    for (int j = 0; j < c; j++) {
      float ang = random(TWO_PI)*random(1)+i/1000;
      line(x+cos(ang)*i/2, y+sin(ang)*i/2, x+cos(ang)*(i/2+esp/2*dis), y+sin(ang)*(i/2+esp/2*dis));
    }
  }

  textAlign(LEFT, TOP);
  fill(#E80730);
  text("PP-"+int(random(100)), 40, 40);
  textFont(helvec);
  text("デオキシリボ核酸", 45, 108);
  noStroke();
  fill(#004AFF,200);
  rect(358, 38, 222, 300);
  fill(250);
  textFont(isoc);
  text("Genetics. deoxyribonucleic acid: an extremely long macromolecule that is the main component of chromosomes and is the material that transfers genetic characteristics in all life forms, constructed of two nucleotide strands coiled around each other in a ladderlike arrangement with the sidepieces composed of alternating phosphate and deoxyribose units and the rungs composed of the purine and pyrimidine bases adenine, guanine, cytosine, and thymine: the genetic information of DNA is encoded in the sequence of the bases and is transcribed as the strands unwind and replicate. Compare base pair, gene, genetic code, RNA.", 360, 40, 220, 380);
  if (pdf) {
    try {
      File file = new File(sketchPath("circulos.pdf"));
      Desktop.getDesktop().open(file);
    } 
    catch(Exception e) {
      e.printStackTrace();
    }
    exit();
  }
}
