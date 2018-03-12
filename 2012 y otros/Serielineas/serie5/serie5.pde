float ang, tam = 300, tam2 = 2;
int creci = 1;
int col = 0;

void setup() {
  size(600, 600);
  noStroke();
  background(0);
  smooth();
  colorMode(HSB);
}

void draw() {
  ang += 0.01;
  col++;
  col %= 256;
  fill(col,255,255);
  beginShape();
  vertex(mouseX+cos(ang)*tam, mouseY+sin(ang)*tam);
  vertex(mouseX+cos(ang+PI/2)*tam2, mouseY+sin(ang+PI/2)*tam2);
  vertex(mouseX-cos(ang)*tam, mouseY-sin(ang)*tam);
  vertex(mouseX-cos(ang+PI/2)*tam2, mouseY-sin(ang+PI/2)*tam2);
  endShape(CLOSE);
  
  tam += creci;
  if (tam > 300){
     creci = -1; 
  }else if (tam < 10){
     creci = 1; 
  }
}
/*
void mousePressed(){
   saveFrame(); 
}*/

