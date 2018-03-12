float tam;

void setup() {
  size(600, 600);
  tam = 1;
}

void draw(){
   //background(255);
   stroke(random(256),random(256),random(256));
   line(mouseX,0,mouseX,height);
}

void mousePressed(){
}

void mouseMoved(){
}
