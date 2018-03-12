float dim, rad, x, dir;
void setup() {
  size(600, 600);
  smooth();
  background(0);
  dim = 200;
  rad = dim/2;
  x = width/2;
  dir = -1;
}

void draw() {
  background(0);
  x += 1 * dir;
  ellipse(x, height/2, dim, dim);
  if (x > width-rad){
     dir = -1; 
  }else if (x < rad){
     dir = 1; 
  }
}

