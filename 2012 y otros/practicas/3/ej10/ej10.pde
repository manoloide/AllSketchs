void setup() {
  size(400, 400);
  background(255);
}

void draw(){
  line(pmouseX,pmouseY,mouseX,mouseY);
}

void keyPressed(){
  stroke(0);
  strokeWeight(0);
}

void mousePressed(){
  stroke(255);
  strokeWeight(3);
}
