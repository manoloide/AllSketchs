float ax,ay,x,y,ang,vel;

void setup() {
  size(600, 600);
  smooth();
  frameRate(600);
  
  strokeWeight(2);
  x = width/2;
  y = height/2;
  ang =  radians(random(360));
  vel = 1;
}

void draw(){
   ax = x;
   ay = y;
   x += cos(ang)*vel;
   y += sin(ang)*vel;
   line(ax,ay,x,y);
   ang += random(-0.1,0.1);
   if((x < 0)||(x > width)||(y < 0)||(y > height)){
     ang += PI;
   }
}


