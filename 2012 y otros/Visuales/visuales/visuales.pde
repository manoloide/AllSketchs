//constantes
float DIAGONAL;
//variables
color fondo = color(0,0);
boolean lineas = false;
boolean diagonales = false;

void setup() {
  size(screen.width, screen.height);
  noCursor();
  frameRate(30);
  smooth();
  
  DIAGONAL = dist(0,0,width,height);
}

void draw() {
   pintarFondo();
   if(diagonales)
      diagonales(); 
   if(lineas)
      lineas(); 
}

void keyPressed(){
   if (key == 'f'){
       fondo = color (random(256),random(256),random(256),random(256));
   }
   if (key == 'l'){
       lineas = !lineas;
   }
   if (key == 'd'){
       diagonales = !diagonales;
   }
   if (key == 'r'){
       diagonales2();
   }
}


