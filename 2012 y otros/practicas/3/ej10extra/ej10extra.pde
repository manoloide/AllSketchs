void setup() {
  size(400, 400);
  background(255);
}

void draw() {
  if (mousePressed) {
    if (mouseButton == RIGHT) {
      stroke(255);
      strokeWeight(3);
    } 
    else if (mouseButton == LEFT) {
      stroke(0);
      strokeWeight(1);
    }
    line(pmouseX, pmouseY, mouseX, mouseY);
  }
}

void keyPressed() {
  stroke(0);
  strokeWeight(1);
}

void mousePressed() {
}

