void setup(){
   size(600,600); 
}

void draw(){
   line(pmouseX,pmouseY,mouseX,mouseY); 
}
void keyPressed(){
   stroke(0,0,255); 
}

void mousePressed(){
   strokeWeight(5); 
}
