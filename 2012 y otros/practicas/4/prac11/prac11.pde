float dim, rad, y, vel, x, dir;
void setup() {
  size(600, 600);
  smooth();
  background(0);
  dim = 200;
  rad = dim/2;
  y = height/2;
  x = width/2;
  dir = -1;
  vel = 1;
}

void draw() {
  background(0);
  y += vel * dir;
  ellipse(x, y, dim, dim);
  if (y > width-rad){
     dir = -1; 
  }else if (y < rad){
     dir = 1; 
  }
  //dibujar botones
  noStroke();
  fill(200);
  rect(540,570,20,20);
  rect(570,570,20,20);
  fill(255);
}

void mousePressed(){
  if (mouseX > 540 && mouseX < 560 && mouseY > 570 && mouseY < 590){
     vel = 1; 
  }
  if (mouseX > 570 && mouseX < 590 && mouseY > 570 && mouseY < 590){
     vel = 0; 
  }
}

