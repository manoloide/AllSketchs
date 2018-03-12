float desx, desy; 
float escala = 1; 
float tam = 100;

void setup() {
  size(800, 800);
  desx = width/2;
  desy = height/2;
}

void draw() {
  translate(desx,desy);
  scale(escala);  
  background(255);
  figura1(0, 0, tam, 0.0);
  figura1(0, 0, tam, 0);
  figura2(0, 0, tam, 0);
}

void mouseDragged() {
  desx += mouseX-pmouseX;
  desy += mouseY-pmouseY;
}

void keyPressed(){
   if(keyCode == DOWN){
     escala -= 0.02;
   } 
   if(keyCode == UP){
     escala += 0.02; 
   }
}

void mouseWheel(MouseEvent event) {
  float e = event.getAmount();
  escala -= e/40;
}

void figura1(float x, float y, float tam, float ang) {
  float tam2 = ((1+sqrt(5))/2)*tam;
  float x2, y2, x3, y3, x4, y4;
  x2 = x+cos(ang+radians(36))*tam;
  y2 = y+sin(ang+radians(36))*tam;
  x3 = x2+cos(ang+radians(72))*tam;
  y3 = y2+sin(ang+radians(72))*tam;
  x4 = x+cos(ang+radians(108))*tam2;
  y4 = y+sin(ang+radians(108))*tam2;
  beginShape();
  vertex(x, y);
  vertex(x2, y2);
  vertex(x3, y3);
  vertex(x4, y4);
  endShape(CLOSE);
}

void figura2(float x, float y, float tam, float ang) {
  float tam2 = ((1+sqrt(5))/2)*tam;
  float x2, y2, x3, y3, x4, y4;
  x2 = x+cos(ang)*tam2;
  y2 = y+sin(ang)*tam2;
  x3 = x2+cos(ang+radians(108))*tam2;
  y3 = y2+sin(ang+radians(108))*tam2;
  x4 = x+cos(ang+radians(36))*tam;
  y4 = y+sin(ang+radians(36))*tam;
  beginShape();
  vertex(x, y);
  vertex(x2, y2);
  vertex(x3, y3);
  vertex(x4, y4);
  endShape(CLOSE);
}

