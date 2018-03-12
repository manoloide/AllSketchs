import processing.pdf.*; //<>//

void setup() {
  size(600, 800, PDF, "prueba1.pdf");
}

void draw() {
  background(20);
  stroke(60);
  strokeWeight(0.5);
  int t = 20; 
  pushMatrix();
  translate(t/2, t/2);
  for (int j = 0; j < height; j+=t) {
    float t2 = map(j, 0, height, 1, 8);
    for (int i = 0; i < width; i+=t) {
      float arc1 = random(TWO_PI);
      float arc2 = random(TWO_PI);
      noStroke();
      if (arc1 > arc2) {
        fill(10);
        arc(i, j, t, t, arc1, arc2+TWO_PI); //<>//
        fill(30);
        arc(i, j, t, t, arc2, arc1);
      }else{
        fill(10);
        arc(i, j, t, t, arc1, arc2);
        fill(30);
        arc(i, j, t, t, arc2, arc1+TWO_PI);
      }
      stroke(0);
      line(i-t2, j, i+t2, j);
      line(i, j-t2, i, j+t2);
    }
  }
  popMatrix();
  textAlign(LEFT, TOP);
  textSize(60);
  for (int i = 10; i >= 0; i-=2) {
    fill(255-i*20);
    text("Hola esto es una prueba!", 40+i/2, 40+i/2, width-80, height-80);
  }
  exit();
}
