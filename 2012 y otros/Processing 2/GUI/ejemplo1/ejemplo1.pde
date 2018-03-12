//gui

GUI gui;

void setup(){
   size(500,500); 
   gui = new GUI();
   gui.agregar(new Boton(100,100,50,50,true,"btn1"));
   gui.agregar(new Ventana(200,100,50,50,"config"));
   gui.agregar(new Pulsador(220, 210, 100, 100, "p4"));
   gui.agregar(new scrollH(15, 240, 170, 10, 0, 255, 0, "s3"));
   gui.agregar(new Selector(10, 10, 120, 20, 6, 2, "b1"));
}

void draw(){
  gui.act();
}

