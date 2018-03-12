float ang, tam = 300, tam2 = 2;
int creci = 1;

void setup() {
  size(600, 600);
  noStroke();
  fill(255,20);
  background(0);
  smooth();
}

void draw() {
  ang += 0.01;
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

