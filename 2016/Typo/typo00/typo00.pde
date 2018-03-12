String texto = "ODD Typo";
String nombreFont = "Helvetica Neue Bold";
int tamTexto = 120;

int cantidad = 100000;
float tamMaximo = 14;
float tamMinimo = 1;

color colorFondo = color(255, 128, 0);
color colorBorde = color(0, 60);



PFont font;
ColorRamp colores = new ColorRamp();
void setup() {
  size(640, 640);
  font = createFont(nombreFont, tamTexto, true);
  colores.addColor(color(0, 128, 255), 0.2);
  colores.addColor(color(0, 255, 128), 1);
  generar();
}

void draw() {
}

void keyPressed() {
  generar();
}

void generar() {
  background(colorFondo);
  PGraphics mask = createMask();
  for (int i = 0; i < cantidad; i++) {
    float x = random(width);
    float y = random(height);
    if (brightness(mask.get(int(x), int(y))) > 200) {
      float tam = random(tamMinimo, tamMaximo);
      stroke(colorBorde);
      fill(colores.getColor());
      ellipse(x, y, tam, tam);
    }
  }
}

PGraphics createMask() {
  PGraphics aux = createGraphics(width, height);
  aux.beginDraw();
  aux.background(0);
  aux.textAlign(CENTER, CENTER);
  aux.textFont(font);
  aux.textSize(tamTexto);
  aux.fill(255);
  aux.text(texto, width/2, height/2);
  aux.endDraw();
  return aux;
}

