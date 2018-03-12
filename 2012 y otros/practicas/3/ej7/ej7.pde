float tam;

void setup() {
  size(600, 600);
  tam = 1;
}

void draw(){
   background(255);
  ellipse(mouseX,mouseY,tam,tam); 
}

void mousePressed(){
   tam = 1; 
}

void mouseMoved(){
   tam++; 
}
