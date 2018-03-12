Tablero tablero;

void setup(){
   size(600,600); 
   tablero = new Tablero();
}

void draw(){
  background(23,54,32);
  tablero.act();
}
