ArrayList puntos;
boolean press;

void setup(){
  size(600,600);
  frameRate(20);
  background(50);
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

  for(int i = 0; i < puntos.size()-1;i++){
    aux2 = (Punto) puntos.get(i);
    float dis = dist(aux1.x, aux1.y, aux2.x, aux2.y);
    if (dis <random(0,100)){
      //stroke(dis/50*255,50);
      stroke(random(255),50);
      line(aux1.x, aux1.y, aux2.x, aux2.y);
    }
  }
}
