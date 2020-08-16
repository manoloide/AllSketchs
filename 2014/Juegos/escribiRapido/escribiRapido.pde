int letra = 0;
int vidas = 5;
int MENU = 0, JUEGO = 1, SCORE = 2;
int estado = MENU;
int timeError = 0;
int timeLetra = 60;
int timeInmune = 0;
int palabras;
String palabra = "adsadas";
PFont helve58, helve100;

void setup() {
  size(800, 600);
  iniciar();
  helve58 = createFont("Helvetica Neue", 58, true);
  helve100 = createFont("Helvetica Neue", 100, true);
}

void draw() {
  background(240);
  if (timeInmune > 0) timeInmune--;
  if (estado == MENU) {
    textAlign(CENTER, CENTER);
    textFont(helve58);
    fill(80);
    text("tecla tan rapido como puedas", width/2-300, height/2-250, 600, 500);
    if (keyPressed && timeInmune == 0) {
      iniciar();
      cambiarEstado(JUEGO);
    }
  } else if (estado == JUEGO) {
    noStroke();
    fill(230);
    arc(width/2, height/2, height*0.8, height*0.8, TWO_PI-PI/2, TWO_PI-PI/2+map(timeLetra, 60, 0, 0, TWO_PI));  
    textFont(helve100);
    textAlign(LEFT, DOWN);
    fill(80);
    text(palabra, width/2-textWidth(palabra)/2, height/2);
    fill(59, 200, 40);
    text(palabra.substring(0, letra), width/2-textWidth(palabra)/2, height/2);
    for (int i = 0; i < 5; i++) {
      strokeWeight(4);
      stroke(120);
      fill(120);
      if (i < vidas) fill(180);
      ellipse(width/2 + 60 * (i-2), 80, 32, 32);
    }
    timeLetra--;
    if (timeLetra + timeInmune <= 0) {
      timeLetra = 60;
      vidas--;
    }
    if (timeError != 0) {
      timeError--;
      noStroke();
      fill(255, 0, 0, map(timeError, 0, 10, 0, 255));
      rect(0, 0, width, height);
    }
    if (vidas <= 0) {
      cambiarEstado(SCORE);
    }
  } else if (estado == SCORE) {
    textAlign(CENTER, CENTER);
    textFont(helve58);
    fill(80);
    text("Sobreviviste "+palabras+" palabras", width/2-300, height/2-250, 600, 500);
    if (keyPressed && timeInmune == 0) {
      cambiarEstado(MENU);
    }
  }
}

void keyPressed() {
  if (estado == JUEGO && timeInmune == 0) {
    timeLetra = 60;
    if (key == palabra.charAt(letra)) {
      letra++;
      if (letra == palabra.length()) {
        palabraAleatoria();
        palabras++;
        letra = 0;
      }
    } else {
      timeError = 10;
      vidas--;
    }
  }
}

void iniciar() {
  palabraAleatoria();
  timeLetra = 60;
  palabras = 0;
  timeError = 0;
  vidas = 5;
  letra = 0;
}

void cambiarEstado(int ne){
  timeInmune = 60;
  estado = ne;
}

void palabraAleatoria() {
  palabra = "";
  int cant = int(random(4, 9));
  for (int i = 0; i < cant; i++) {
    palabra += char(int(random(97, 123)));
  }
}
