float dim, rad, y, dir;
void setup() {
  size(600, 600);
  smooth();
  background(0);
  dim = 200;
  rad = dim/2;
  y = height/2;
  dir = -1;
}

void draw() {
  background(0);
  y += 1 * dir;
  ellipse(width/2, y, dim, dim);
  if (y > width-rad){
     dir = -1; 
  }else if (y < rad){
     dir = 1; 
  }
}

void mousePressed(){
   dir *= -1; 
}

