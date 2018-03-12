PImage img;

void setup() {
  size(960, 960);
  surface.setResizable(true);
  img = loadImage("https://scontent.fgig1-2.fna.fbcdn.net/v/t34.0-12/14256312_10210221597639148_262756856_n.jpg?oh=45841f9887a26fb8009167354ed52bd3&oe=57D03888");
}


void draw() {
  background(0);
  int sep = 4;
  noStroke();
  for (int j = sep; j < img.height*2; j+=sep) {
    beginShape();
    vertex(0, j);
    for (int i = 0; i < img.width*2; i+=4) {
      color col = img.get(i/2, j/2);
      float des = (brightness(col)/255.)*sep*0.8;
      curveVertex(i, j-des);
    }
    vertex(img.width, j);
    endShape(CLOSE);
  }
}