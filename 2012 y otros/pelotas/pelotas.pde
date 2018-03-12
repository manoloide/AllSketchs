ArrayList pelotas;
int cant = 200;
Pelota aux;

void setup() {
  size(400, 400);
  smooth();
  pelotas = new ArrayList();
  for(int i = 0; i < cant;i++){
    pelotas.add(new Pelota(random(width), random(height)));
  }
}

void draw(){
   background(100);
   for (int i = 0; i < pelotas.size();i++){
      aux = (Pelota) pelotas.get(i);
      aux.actualizar();
      aux.draw();
   } 
}

