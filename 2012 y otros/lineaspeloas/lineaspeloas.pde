ArrayList puntos;

void setup(){
  size(600,600);
  background(255);
  smooth();
  puntos = new ArrayList();
}

void draw(){
  
}

Punto aux1,aux2;
int largo;

void mouseDragged(){
  aux1 = new Punto(mouseX,mouseY);
  puntos.add(aux1);

  stroke(0,50);
  for(int i = 0; i < puntos.size()-1;i++){
    aux2 = (Punto) puntos.get(i);
    if (dist(aux1.x, aux1.y, aux2.x, aux2.y)<50){
      line(aux1.x, aux1.y, aux2.x, aux2.y);
    }
  }
}
