int x, y;
int vel = 10;

void setup() {
  size(400, 400);
  x = 200;
  y = 200;
  fill(255,0,0);
}

void draw() {
  background(255);
  rect(x,y,20,20);
}

void keyPressed(){
   if (key == 'w'){
      y-=vel;
   }else if(key == 's'){
     y+=vel;
   }else if(key == 'a'){
     x-=vel;
   }else if(key == 'd'){
     x+=vel;
   }
}

void mousePressed() {
  x = 200;
  y = 200;
}

