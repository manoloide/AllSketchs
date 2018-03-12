int tam = 20;
int cant = 10;

void setup() {
  size(400, 400);
}

void draw() {
  background(0);
  fill(255);
  for (int j = 0; j < cant; j++) {
    for (int i = 0; i < cant; i++) {
      rect(i*tam,j*tam,tam,tam);
    }
  }
  fill(200);
  rect(10,380,10,10);
}

void mousePressed(){
  if(mouseX > 10 && mouseX < 20 && mouseY > 380 && mouseY < 390){
     cant--; 
  }
}

