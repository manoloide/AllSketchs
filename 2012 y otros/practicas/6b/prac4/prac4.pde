int cant = 40;

void setup() {
  size(400, 400);
  noStroke();
  fill(0);
  smooth();
}

void draw() {
  background(255);
  for (int i = 0; i < cant; i++){
     float alto = sin(map(i,0,cant,0,PI))*height; 
     ellipse((width/cant)*i,height/2,width/cant,alto);
  }
}

