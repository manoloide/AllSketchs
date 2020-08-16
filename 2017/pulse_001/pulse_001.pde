int midi1; 

void setup() {
  size(720, 720);
}

void draw() {
  float ss = width/16; 
  int sel = midi1%16;

  background(0);
  noStroke();
  fill(255);
  rect(sel*ss, 0, ss, width);
}