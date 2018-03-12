ArrayList cosas, seleccion;
float x1, y1;
boolean selec;

void setup() {
  size(400, 400);
  background(120);
  frameRate(40); 
  smooth();

  cosas = new ArrayList();
  seleccion = new ArrayList();
  selec = false;

  for (int i=0; i < 100;i++) {
    cosas.add(new Cosa(random(width), random(height)));
  }
}

void draw() {
  background(120);
  actualizar();
  if (selec) {
    dibujarCosas();
    seleccionar();
    cuadroSeleccion();
  }
  else {
    dibujarCosas();
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    selec = true;
    x1 = mouseX;
    y1 = mouseY;
  } 
  else if (mouseButton == RIGHT) {
    fill(255);
  } 
  else {
    //nada;
  }
}

void mouseReleased() {
  if (mouseButton == LEFT) {
    selec = false;
  }
  else if (mouseButton == RIGHT) {
    for (int i=0; i < seleccion.size();i++) {
      Cosa aux = (Cosa) seleccion.get(i);
      aux.mover = true;
      aux.nx = mouseX;
      aux.ny = mouseY;
    }
  }
}

