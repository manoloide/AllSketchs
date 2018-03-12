void setup() {
  size(600, 600);
  smooth();
  background(255);
  stroke(255,0,0);
  noLoop();
}

void draw() {
  line(pmouseX, pmouseY, mouseX, mouseY);
}

void keyPressed(){
   if (key == 'a'){
      stroke(0,0,255);
   }else if (key == 'v'){
      stroke(0,255,0);
   } else if (key == 'r'){
      stroke(255,0,0);
   }    
}

void mousePressed() {
  loop();
}

void mouseReleased() {
  noLoop();
}

