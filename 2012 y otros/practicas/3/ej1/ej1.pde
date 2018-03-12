void setup() {
  size(600, 600);
  fill(0);
}

void draw() {
  ellipse(mouseX, height-mouseY, 50, 50);
}

void mousePressed(){
   fill(0,0,255); 
}

void keyPressed(){
   fill(0); 
}

