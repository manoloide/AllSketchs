ArrayList puntos;

void setup() {
  size(600, 600);
  background(0);
  noStroke();
  fill(255,255,0);

  puntos = new ArrayList();
  agregar(puntos,40,250,250);
  agregar(puntos,40,240,240);
  agregar(puntos,10,10,100);
  
  for (int i=0; i < puntos.size(); i++){
     Punto aux = (Punto) puntos.get(i);
    aux.draw(); 
  }
}

void agregar(ArrayList lis, int cant, int dis, int dis2) {
  float x, y, ang;
  for (int i=0; i < cant;i++) {
    dis = int(random(dis,dis2));
    ang = random(2*PI);
    x = cos(ang)*dis + width/2;
    y = sin(ang)*dis + height/2;
    lis.add(new Punto(x,y));
  }
}

