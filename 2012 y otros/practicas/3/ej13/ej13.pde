void setup() {
  size(600, 600);
  background(255);
  smooth();
  noStroke();
}

void draw() {
  float anc = random(100);
  fill(random(256),random(256),random(256),random(256));
  ellipse(width-mouseX,height-mouseY,anc,anc);
}

void mousePressed() {
  loop();
}
void keyPressed() {
  noLoop();
}

