void setup() {
  size(400, 400);
  background(0);
  noStroke();
  colorMode(HSB,100);
  noCursor();
}

void draw() {
  fill(0, 2);
  rect(0, 0, width, height);
  fill(random(100),80,80);
  rect(int(mouseX/10)*10,int(mouseY/10)*10,10,10);
}

