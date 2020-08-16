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

  float ang = radians(sombraAngulo);
  float cx = width/2;
  float cy = height/2;
  textAlign(CENTER, CENTER);
  textFont(font);
  textSize(tamTexto);
  for (float i = distancia; i >= 0; i-=0.5) {
    float x = cx+cos(ang)*i;
    float y = cy+sin(ang)*i;
    fill(lerpColor(colorSombra1, colorSombra2, i*1./distancia));
    textSize(tamTexto*map(i, 0, distancia, 1, reducirSombra));
    text(texto, x, y);
  }
  textSize(tamTexto);
  fill(colorTexto);
  text(texto, cx, cy);
}

