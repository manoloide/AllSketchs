int veces = 15;

void setup() {
  size(600, 600);
  background(180);
  smooth();
  noStroke(); 
  fill(210, 255, 190);
  ellipse(width/2, height/2, width-10, height-10);
  //alfa enetre 30 y 50
  stroke(30,15);
  strokeWeight(1);
  recursiva(width/2, 500,30,veces,-PI/2);
  //saveFrame("arbol.jpg");
}

void recursiva(float x, float y, float lar, int v, float ang){
  if (v > 0){
    // la cantidad de ramificaciones
     int cant = int(random(3))+1;
     for (int i = 0; i < cant; i++){
         ang += random(-PI/8,PI/8);
         float nx = x + cos(ang)*lar;
         float ny = y + sin(ang)*lar;
         for (int j = 0; j < v; j++){
           stroke(30,(5+ 10*v/veces));
           strokeWeight(3*(v/veces)*(1*j/v)+1);
           line(x,y,nx,ny);
         }
         recursiva(nx,ny,lar-random(2),v-1,ang);
     }
  }
}

