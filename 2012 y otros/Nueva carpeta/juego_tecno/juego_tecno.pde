/***********************
 * Gamboa Naon, Manuel *
 * manoloide@gmail.com *
 ***********************/

/*
 -seleccionar y todo eso
 solucionar el tema de la posicion y eso
 
 cosas a hacer: 
 -buscar ideas
 -PARTICULAS.. masomenos esta.
 -construir
 -lluvia
 -mejorar generacion de mundos
 
 -gui y graficos:
 *terminar menus
 *minimapa?
 *animaciones...
 *resolver luces MEJORAR
 -pathfinding unidades:
 
 -sonido:
 *incorporar sonidos
 *componer musica
 
 bug:
 
 */
Boolean pausa, click;
Menu menu;
Nivel nivel;
PImage sprite;
PImage[][] sprites, bordes, iconos;
Fuente fchica, fnormal, fgrande;

void setup() {
  size(640, 480);
  frameRate(60);
  noStroke();
  menu = new Menu();
  pausa = true;
  sprite = loadImage("graficos.png");
  sprites = recortarImagen(recortar(sprite, 0, 0, 80, 180), 20, 20, 2);
  bordes = recortarImagen(recortar(sprite, 0, 201, 24, 12), 4, 4, 2);
  iconos = recortarImagen(recortar(sprite, 0, 213, 24, 8), 8, 8, 2);
  fchica = new Fuente(recortar(sprite, 0, 180, 160, 21), 2);
  fgrande = new Fuente(recortar(sprite, 0, 180, 160, 21), 4);
}


void draw() {
  background(0);
  if (pausa) {
    if (nivel == null) {
      //MENU PRINCIPAL
      menu.act();
    }
  }
  else {
    //JUEGO
    nivel.act();
  }
  click = false;
}

void mousePressed() {
  if (mouseButton == LEFT) {
    click = true;
    if (nivel != null) {
      nivel.selector.click();
    }
  }
  if (mouseButton == RIGHT) {
    nivel.j.calcularCamino(nivel.sx, nivel.sy);
  }
}

void mouseReleased() {
  if (nivel != null) {
    nivel.selector.press = false;
    nivel.selector.desclick();
  }
}

void keyPressed() {
  if (nivel != null) {
    nivel.consola.pressTecla(key);
  }
}

void nuevoNivel() {
  nivel = new Nivel(64, 64);
}

