void actualizar(){
  for (int i=0; i < cosas.size();i++) {
    Cosa aux = (Cosa) cosas.get(i);
    if (aux.mover){
      aux.mover();
    }
  }
}

void cuadroSeleccion() {
  stroke(0, 255, 0);
  strokeWeight(2);
  fill(0, 255, 0, 10);
  rect(x1, y1, mouseX-x1, mouseY-y1);
}

void dibujarCosas() {
  for (int i=0; i < cosas.size();i++) {
    Cosa aux = (Cosa) cosas.get(i);
    aux.draw();
  }
}

void seleccionar(){
  float xmenor,xmayor,ymenor,ymayor;
   seleccion = new ArrayList();
  if (x1 < mouseX){
    xmenor = x1;
    xmayor = mouseX;
  }else{
    xmenor = mouseX;
    xmayor = x1;
  }
  if (y1 < mouseY){
    ymenor = y1;
    ymayor = mouseY;
  }else{
    ymenor = mouseY;
    ymayor = y1;
  }
  
  xmenor -= 2;
  xmayor += 2;
  ymenor -= 2;
  ymayor += 2;
  
  for (int i=0; i < cosas.size();i++) {
    Cosa aux = (Cosa) cosas.get(i);
    aux.selec = false; 
    if ((aux.x >= xmenor)&&(aux.x <= xmayor)){
      if ((aux.y >= ymenor)&&(aux.y <= ymayor)){
        aux.selec = true;
        seleccion.add(aux); 
      }
    }
  }
}
