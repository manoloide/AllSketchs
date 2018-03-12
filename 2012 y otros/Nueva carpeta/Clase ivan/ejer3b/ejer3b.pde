int contador;

void setup(){
  size(400,400);
  contador = 0;
}

void draw(){
  fill(0);
  ellipse(mouseX,mouseY,2,2);
  line(mouseX,mouseY,pmouseX,pmouseY);
}
