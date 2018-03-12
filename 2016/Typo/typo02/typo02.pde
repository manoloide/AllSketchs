String texto = "ODD Typo";
String nombreFont = "Mohave";
int tamTexto = 120;

float sombraAngulo = 90;
int distancia = 80;
float reducirSombra = 0.8; 

color colorTexto = color(255);
color colorSombra1 = color(255, 128, 0);
color colorSombra2 = color(255, 0, 128);

color colorFondo = color(80);
color colorBorde = color(0, 60);



PFont font;
void setup() {
  size(640, 640);
  font = createFont(nombreFont, tamTexto, true);
  generar();
}

void draw() {
}

void keyPressed() {
  generar();
}

void generar() {
  background(colorFondo);
  PGraphics imagenTexto = createText();
  tint(colorTexto);
}

PGraphics createText() {
  textFont(font);
  textSize(tamTexto);
  int textoAncho = int(textWidth(texto));
  PGraphics aux = createGraphics(textoAncho+4, tamTexto+4);
  aux.beginDraw();
  aux.clear();
  aux.textAlign(TOP, LEFT);
  aux.textFont(font);
  aux.textSize(tamTexto);
  aux.fill(255);
  aux.text(texto, 2, 2);
  aux.endDraw();
  return aux;
}

