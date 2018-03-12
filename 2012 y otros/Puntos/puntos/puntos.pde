ArrayList puntos;
int cant;

void setup(){
  size(400,400);

  cant = 40;
  puntos = new ArrayList();
  
  //agregar puntos a la azar
  for(int i = 0; i < cant; i++){
    puntos.add(new Punto(random(width),random(height)));
  }
}

void draw(){
  Punto aux1,aux2;
  
  
  delay(10);
  background(50);
  stroke(230);
  smooth();
  //dibujar lineas
  for(int i = 0; i < cant-1; i++){
     aux1 = (Punto) puntos.get(i);
     for(int j = i; j < cant; j++){
       aux2 = (Punto) puntos.get(j);
       float dis = dist(aux1.x,aux1.y,aux2.x,aux2.y);
       if (dis > 5 && dis < 100){
         line(aux1.x,aux1.y,aux2.x,aux2.y); 
       }
     }
  }
  //dibujar puntos y moverlos
  noStroke();
  fill(245);
  for(int i = 0; i < cant; i++){
    aux1 = (Punto) puntos.get(i);
    aux1.draw();
    aux1.mover();
  }
  //saveFrame("output-####.png");
}
