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
}

void mousePressed(){
   if (dist(mouseX,mouseY,x,y) < rad){
      if (vel == 1){
         vel = 0;
      } else{
         vel = 1; 
      }
   }
}

