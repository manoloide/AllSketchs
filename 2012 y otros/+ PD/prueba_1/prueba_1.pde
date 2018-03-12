ArrayList puntos;

import oscP5.*;
import netP5.*;
  
OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {
  size(400,400);
  frameRate(25); 
  smooth();
  
  //crea puerto de conexion pd
  oscP5 = new OscP5(this,12000);
  
  
  puntos = new ArrayList();
  myRemoteLocation = new NetAddress("127.0.0.1",12001);
}

void draw() {
  background(0);
  for(int i=0; i < puntos.size(); i++){
    Punto aux = (Punto) puntos.get(i);
    if (dist(aux.x,aux.y,width/2,height/2)>1){
      aux.draw();
      aux.mover();
    }else{
      puntos.remove(i);
      i--;
      OscMessage m1 = new OscMessage("entrada");
      m1.add(int(random(12)));
      oscP5.send(m1, myRemoteLocation);
    }
    
  } 
}

void mousePressed(){
  puntos.add(new Punto(mouseX,mouseY)); 
}

