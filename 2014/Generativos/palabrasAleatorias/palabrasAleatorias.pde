/*
  -hacer que el color de las letras el mas alejado al fondo
 -traducir palabras y buscar su definicion
 
 */

String[] palabras;
PFont fchica, fmedia, fgrande;

void setup() {
  size(600, 800);
  colorMode(HSB, 256);
  fchica = createFont("Helvetica Bold", 8, false);
  fmedia = createFont("Helvetica Bold", 32, false);
  fgrande = createFont("Helvetica Bold", 96, false);
  palabras = loadStrings("http://snowball.tartarus.org/algorithms/spanish/voc.txt");
  thread("generar");
}

void draw() {
}
void keyPressed() {
  if (key == 's') {
    saveFrame("#####");
  } 
  else {
    thread("generar");
  }
}

void generar() {
  /*
  String aux = loadStrings("http://testhangmangame.net76.net/?jsonp=processResult")[0];
   palabras = split(aux, '"');*/

  float h = random(256);
  background((h+128)%256, random(60, 120), random(180));
  int cant = int(random(10, 50));
  for (int i = 0; i < cant; i++) {
    float x1 = random(-100, width+100);
    float y1 = random(-100, height+100);
    float x2 = random(-100, width+100);
    float y2 = random(-100, height+100);
    int r = int(random(3));
    float tam1, tam2;
    noStroke();
    color c1 = color(h, random(120, 240), random(180, 256));
    color c2 = color(h, random(120, 240), random(180, 256));
    switch(r) {
    case 0:
      tam1 = random(2, 5);
      tam2 = random(5, 50);
      lineaGordita(x1, y1, x2, y2, tam1, tam2, c1, c2);
      break;
    case 1:
      tam1 = random(2, 50);
      tam2 = random(2, 50);
      if (random(1) < 0.5) tam2 = tam1;
      lineaGordita2(x1, y1, x2, y2, tam1, tam2, c1, c2);
      break;
    case 2:
      tam1 = random(2, 50);
      tam2 = random(2, 50);
      if (random(1) < 0.5) tam2 = tam1;
      lineaGordita3(x1, y1, x2, y2, tam1, tam2, c1, c2);
      break;
    }
  }
  fill((h+64)%256, random(40), random(210, 256));
  textAlign(LEFT, TOP);
  textFont(fgrande);
  String titulo = palabras[int(random(palabras.length))];
  int des = 0;
  String letras = "gjpqy";
  int min = -1;
  for (int i = 0; i < letras.length(); i++) {
    char letra = letras.charAt(i);
    int pos = titulo.indexOf(letra);
    if(pos > 0){
      if(pos < min || min == -1) min = pos;
    }
  }
  if(min != -1) des = 16;
  titulo = titulo.substring(0, 1).toUpperCase()+titulo.substring(1, titulo.length()).toLowerCase();
  text(titulo, 32, 50);
  textFont(fmedia);
  text(palabras[int(random(palabras.length))] + " + " + palabras[int(random(palabras.length))], 37, 130+des);
  textFont(fchica);
  //text("Manoloide 2014", width-textWidth("Manoloide 2014")-12, height-12);
}

String tranducir(String pal) {
  String aux =  pal;
  JSONObject j = loadJSONObject("https://www.googleapis.com/language/translate/v2?key=AIzaSyA8bI9HtR9dgHSYgS3rN2viXAWOSGSogZQ&source=en&target=es&q="+pal);
  println(j);
  return aux;
}

void lineaGordita(float x1, float y1, float x2, float y2, float anc1, float anc2, color col1, color col2) {
  float dis = dist(x1, y1, x2, y2);
  float ang = atan2(y2-y1, x2-x1);
  for (float i = 0; i < dis; i+= 2) {
    float tam = map(i, 0, dis, anc1, anc2);
    float x = x1+cos(ang)*i;
    float y = y1+sin(ang)*i;
    fill(lerpColor(col1, col2, map(i, 0, dis, 0, 1)));
    ellipse(x, y, tam, tam);
  }
}

void lineaGordita2(float x1, float y1, float x2, float y2, float anc1, float anc2, color col1, color col2) {
  float dis = dist(x1, y1, x2, y2);
  float ang = atan2(y2-y1, x2-x1);
  for (float i = 0; i < dis; i+= 1) {
    float d1 = map(i, 0, dis, -0.8, 1); 
    if (d1 < 0) d1 = 0;
    float d2 = map(i, 0, dis, 1, -0.8); 
    if (d2 < 0) d2 = 0;
    float tam = d1*anc1+d2*anc2;
    float x = x1+cos(ang)*i;
    float y = y1+sin(ang)*i;
    fill(lerpColor(col1, col2, map(i, 0, dis, 0, 1)));
    ellipse(x, y, tam, tam);
  }
}

void lineaGordita3(float x1, float y1, float x2, float y2, float anc1, float anc2, color col1, color col2) {
  float dis = dist(x1, y1, x2, y2);
  float ang = atan2(y2-y1, x2-x1);
  for (float i = 0; i < dis; i+= 1) {
    float d1 = map(i, 0, dis, 1, 0); 
    d1 = (exp(d1)-1)/(exp(1)-1);
    float d2 = map(i, 0, dis, 0, 1); 
    d2 = (exp(d2)-1)/(exp(1)-1);
    float tam = d1*anc1+d2*anc2;
    tam /= 0.5+ map(abs(dis/2-i), dis/2, 0, 0, 0.5);

    float x = x1+cos(ang)*i;
    float y = y1+sin(ang)*i;
    fill(lerpColor(col1, col2, map(i, 0, dis, 0, 1)));
    ellipse(x, y, tam, tam);
  }
}
