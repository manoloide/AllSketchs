boolean col = false;

void setup() {
  size(600, 600);
  smooth();
  background(255);
  noStroke();
}

void draw() {
  if(col){
    fill(0,0,255);
  }else{
    fill(255,0,0);
  }
  float dim = random(20,200);
  ellipse(mouseX,mouseY,dim,dim);
}

void mousePressed() {
  col = !col;
}

