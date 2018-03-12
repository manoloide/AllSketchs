void setup() {
  size(600, 600);
  smooth();
  background(255);
  noLoop();
}

void draw(){
   if (mouseX > width/2){
      line(pmouseX,pmouseY,mouseX,mouseY);
   } 
}

void mousePressed(){
   loop(); 
}

void mouseReleased(){
   noLoop(); 
}

