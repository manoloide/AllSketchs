void setup() {
  size(600, 600);
  smooth();
  background(255);
  //cuadradito 
  noStroke();
  fill(200);
  rect(width-20, height-20, 20, 20);
  stroke(0);
}

void draw() {
  if (mousePressed) {
    line(pmouseX, pmouseY, mouseX, mouseY);
  }
}

void mousePressed() {
  if (mouseX > width-20 && mouseY > height-20) {
    background(255);
    noStroke();
    fill(200);
    rect(width-20, height-20, 20, 20);
    stroke(0);
  }
}

