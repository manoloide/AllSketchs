void setup() {
  size(600, 600);
}

void draw() {
  background(20);
  float sep = 180;
  pushMatrix();
  translate(width/2, height/2);
  float w = sep;
  float h = sep/2;
  int cw = int(width/w)+1;
  int ch = int(height/h)+1;
  for (int j = -ch/2; j <= ch/2; j++) {
    for (int i = -cw/2; i <= cw/2; i++) {
      float x = (i+abs(j%2*0.5)) * w;
      float y = j * h/2;
      stroke(255, 120);
      fill(#5CBC50);
      tile(x, y, w, h);
      noStroke();
      fill(255, 255, 210);
      ellipse(x, y, 5, 5);
      
      fill(#FA232B);
      flechita(x-14, y, 12, 10, PI/2);
      fill(#23FA2F);
      flechita(x+14, y, 12, 10, -PI/2);
    }
  }
  popMatrix();
  
  pushStyle();
  stroke(140);
  strokeWeight(20);
  line(50, 70, width-50, 70);
  strokeWeight(14);
  stroke(255, 150);
  line(50, 70, 50+(width-100)*((frameCount/300.)%1.), 70);
  noStroke();
  fill(140);
  arc(width/2, 62, 80, 80, PI, TWO_PI);
  popStyle();
}

void flechita(float x, float y, float w, float h, float a){
  float a1 = 0.5;
  float a2 = 0.2;
  pushMatrix();
  translate(x, y);
  rotate(a);
  beginShape();
  vertex(-w*a1, -h*a2);
  vertex(-w*a1, +h*a2);
  vertex(+w*a2, +h*a2);
  vertex(+w*a2, +h*a1);
  vertex(+w*a1, 0);
  vertex(+w*a2, -h*a1);
  vertex(+w*a2, -h*a2);
  endShape(CLOSE);
  popMatrix();
}

void tile(float x, float y, float w, float h) {
  beginShape();
  vertex(x-w/2, y);
  vertex(x, y-h/2);
  vertex(x+w/2, y);
  vertex(x, y+h/2);
  endShape(CLOSE);
}

