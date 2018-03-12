color paleta[]; 

void setup() {
  size(600, 800);
  paleta  = new color[5];
  paleta[0] = color(#FF0000);
  paleta[1] = color(#000031);
  paleta[2] = color(#FFF600);
  paleta[3] = color(#FFFFFF);
  paleta[4] = color(#000000);
  background(255);
  noStroke();
  for (int i = 0; i < 100000; i++) {
    fill(paleta[int(random(5))], 60);
    triangle(random(width), random(height), random(5,20), random(TWO_PI));
  }
  stroke(255, 220);
  /*
  for (int i = 2; i < height*2; i+=15) {
    fill(paleta[int(random(5))], 60);
    beginShape();
    vertex(-15, i);
    vertex( i, -15);
    vertex( i-15, -15);
    vertex(-15, i-15);
    endShape(CLOSE);
  }*/
}

void draw() {
}

void triangle(float x, float y, float dim, float ang) {
  float da = TWO_PI/3;
  beginShape();
  for (int i = 0; i < 3; i++) {
    vertex(x+cos(da*i+ang)*dim/2, y+sin(da*i+ang)*dim/2);
  }
  endShape(CLOSE);
}
