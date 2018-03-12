PImage imgs[];
int cant = 3;
int act = int(random(cant));
int alto, ancho;
PImage aux;
boolean lluvia = false;

void setup() {
  size(720, 366);
  
  imgs = new PImage[cant];
  for (int i = 0; i < cant; i++) {
    imgs[i] = loadImage(i+".jpg");
  }
  alto = imgs[0].height;
  ancho = imgs[0].width;

  aux = createImage(ancho, alto, RGB);
}

void draw() {
  aux.copy(imgs[act], 0, 0, ancho, alto, 0, 0, ancho, alto);
  if (int(frameCount/100)%2 == 1) {
    aux.filter(INVERT);
    println(frameCount);
  }
  image(aux, 0, 0); 
  procesar();
  if ( random(100) > 90) {
    act = int(random(cant));
  }
}

void keyPressed() {
  if (key == 'r') {
    for (int i = 0; i < cant; i++) {
      imgs[i] = loadImage(i+".jpg");
    }
  }
  if(key == 'l'){
     lluvia = !lluvia; 
  }
}

void procesar() {
  if (lluvia) {
    for (int i = -20; i < dist(mouseX,mouseY,pmouseX,pmouseY);i++) {
      pixeles();
    }
  }
  if ( random(100) > 80) {
    rectangulo();
  }
}

void pixeles() {
  int x = int(random(ancho));
  int y = int(random(alto));
  color aux = calcular(imgs[act], x, y);
  int seg = int(random(cant));
  imgs[act].set(x, y, calcular(imgs[seg], x, y));
  imgs[seg].set(x, y, aux);
}

void rectangulo() {
  int an = int(random(20, 80));
  int al = int(random(20, 80));
  int x = int(random(ancho-an));
  int y = int(random(alto-al));
  PImage aux = createImage(an, al, RGB);
  int seg = int(random(cant));
  for (int j = y; j < y+al;j++) {
    for (int i = x; i < x+an;i++) {
      aux.set(i-x, j-y, calcular(imgs[act], i, j));
      imgs[act].set(i, j, calcular(imgs[seg], i, j));
    }
  }
  for (int j = y; j < y+al;j++) {
    for (int i = x; i < x+an;i++) {
      imgs[seg].set(i, j, calcular(aux, i-x, j-y));
    }
  }
}

color calcular(PImage img, int cx, int cy) {
  color col;
  int lu = cy * img.width + cx;
  col = img.pixels[lu];
  return col;
}

