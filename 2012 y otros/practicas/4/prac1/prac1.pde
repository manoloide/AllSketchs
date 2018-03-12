void setup() {
  size(600, 600);
  smooth();
  background(255);
  noLoop();
}

void draw(){
   if (dist(mouseX,mouseY,width/2,height/2) < 100){
      line(pmouseX,pmouseY,mouseX,mouseY);
   } 
}

void mousePressed(){
   loop(); 
}

void mouseReleased(){
   noLoop(); 
}

