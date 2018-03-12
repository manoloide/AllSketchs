float dim, rad, y, vel, x, dir;
void setup() {
  size(400, 300);
  smooth();
  background(0);
  dim = 200;
  rad = dim/2;
  y = 130;
  x = width/2;
  dir = -1;
  vel = 1;
}

void draw() {
  background(0);
  x += vel * dir;
  ellipse(x, y, dim, dim);
  if (x > width-rad || x < rad){
     print("perdiste");
  }
  //dibujar botones
  noStroke();
  fill(200);
  rect(150,270,40,20);
  rect(210,270,40,20);
  fill(255);
  vel += 0.01;
}

void mousePressed(){
  if (mouseX > 150 && mouseX < 190 && mouseY > 270 && mouseY < 290){
     dir = -1; 
  }
  if (mouseX > 210 && mouseX < 250 && mouseY > 270 && mouseY < 290){
     dir = 1; 
  }
}

