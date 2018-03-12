ArrayList escuchadores;

import ddf.minim.*;

Minim minim;
AudioInput in;

int col;
Escuchador e1,e2,e3;

void setup(){
  size(400, 400);
  frameRate(30);
  smooth();
  noStroke();
  colorMode(HSB);
  //iniciar minim
  minim = new Minim(this);
  minim.debugOn();
  //iniciar la clase que lee el microfono en buffer
  in = minim.getLineIn(Minim.STEREO, 512);
  
  escuchadores = new ArrayList();
  for(int i = 0; i < 20; i++){
     escuchadores.add(new Escuchador(random(width), random(height))); 
  }
  
  background(0);
}

void draw(){
  //dibujar fondo
  fill(0,100);
  rect(0,0,width,height);
  //escuchadores
  for (int i = 0; i < escuchadores.size(); i++){
    Escuchador aux = (Escuchador) escuchadores.get(i);
    aux.mover();
    aux.variarRad();
    aux.draw();
  }
}

void stop() {
  //cierra el minim 
  in.close();
  minim.stop();
  super.stop();
}

