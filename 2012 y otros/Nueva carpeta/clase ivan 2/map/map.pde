void setup() {
  size(400, 400);
}

void draw() {
  float r = map(mouseX, 0, 400, 0 , 255);
  float v = map(mouseY, 0, 400, 0 , 255);
  fill(255,v,r);
  ellipse(mouseX,mouseY,200,200);
  fill(255,mouseY,mouseX);
  ellipse(mouseX,mouseY,100,100);
}

