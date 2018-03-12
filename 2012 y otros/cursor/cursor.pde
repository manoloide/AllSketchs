float ang = 0;

void setup() {
  size(600,600);
  smooth();
}

void draw() {
  background(180);
  ang += 0.02;
  cur();
}

void cur() {
  float dis = 8;
  
  noStroke();
  pushMatrix();
  translate(mouseX,mouseY);
  fill(255,0,0);
  ellipse(cos(ang)*dis,sin(ang)*dis,5,5);
  fill(0,255,0);
  ellipse(cos(ang+(2*PI)/3)*dis,sin(ang+(2*PI)/3)*dis,5,5);
  fill(0,0,255);
  ellipse(cos(ang+(2*PI)*2/3)*dis,sin(ang+(2*PI)*2/3)*dis,5,5);
  popMatrix();
}

