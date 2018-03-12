int contador;

void setup(){
  size(400,400);
  contador = 0;
}

void draw(){
  ellipse(0+contador,0+contador,50,50);
  ellipse(width-contador, contador,50,50);
  ellipse(width-contador, height-contador,50,50);
  //ellipse(contador, height-contador,50,50);
  contador = contador + 1;
  ellipse(mouseX,mouseY,50,50);
}
