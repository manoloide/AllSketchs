import processing.video.*;

int contador;
Frase a, b, c, d, e, f;
String pantalla; //menu,f1,f2,f3,v1,v2,v3;
PImage fmenu, f1, f2, f3;
Movie v1, v2, v3;


void setup() {
  size(800, 600);
  background(0);
  textAlign(CENTER, CENTER);
  //aca cambiar las cosas de las frases; frase, x, y, w, h, , tamano , color fondo y color texto
  a = new Frase("Frase a!", width/2, height/2-120, 300, 100, 100, color(100), color(255,255,23,20), true);
  b = new Frase("Frase b!", width/2, height/2, 300, 100, 100, color(100), color(255), true);
  c = new Frase("Frase c!", width/2, height/2+120, 300, 100, 100, color(100), color(255), true);
  d = new Frase("Frase d!", width/2, height/2, 300, 100, 100, color(100), color(255), false);
  e = new Frase("Frase e!", width/2, height/2, 300, 100, 100, color(100), color(255), false);
  f = new Frase("Frase f!", width/2, height/2, 300, 100, 100, color(100), color(255), false);
  //aca se cargan los fondos ahyqe u fijarse que onda el tamaño
  fmenu = loadImage("img.jpg");
  f1 = loadImage("img.jpg");
  f2 = loadImage("img.jpg");
  f3 = loadImage("img.jpg");
  //aca se cargan los video; 
  v1 = new Movie(this, "video.mov");
  v2 = new Movie(this, "video.mov");
  v3 = new Movie(this, "video.mov");

  pantalla = "menu";
}

void draw() {
  background(0);
  if (pantalla.equals("menu")) {
    image(fmenu, 0, 0,width,height);
    a.act();
    b.act();
    c.act();
    if (a.click) {
      contador = 120;//tiempo hasta que pasa al video v1
      pantalla = "f1";
    }
    if (b.click) {
      contador = 120;//tiempo hasta que pasa al video v2
      pantalla = "f2";
    }
    if (c.click) {
      contador = 120;//tiempo hasta que pasa al video v3
      pantalla = "f3";
    }
  }
  else if (pantalla.equals("f1")) {
    image(f1, 0, 0,width,height);
    d.act();
    contador--;
    if (contador == 0) {
      pantalla = "v1";
      v1.play();
    }
  }
  else if (pantalla.equals("f2")) {
    image(f2, 0, 0,width,height);
    e.act();
    contador--;
    if (contador == 0) {
      pantalla = "v2";
      v2.play();
    }
  }
  else if (pantalla.equals("f3")) {
    image(f3, 0, 0,width,height);
    f.act();
    contador--;
    if (contador == 0) {
      pantalla = "v3";
      v3.play();
    }
  }
  else if (pantalla.equals("v1")) {
    if (v1.available()) {
      v1.read();
    }
    image(v1, 0, 0, width, height);
    if (v1.time() >= v1.duration()) {
      v1.stop();
      pantalla = "menu";
    }
  }
  else if (pantalla.equals("v2")) {
    if (v2.available()) {
      v2.read();
    }
    image(v2, 0, 0, width, height);
    if (v2.time() >= v2.duration()) {
      v2.stop();
      pantalla = "menu";
    }
  }
  else if (pantalla.equals("v3")) {
    if (v3.available()) {
      v3.read();
    }
    image(v3, 0, 0, width, height);
    if (v3.time() >= v3.duration()) {
      v3.stop();
      pantalla = "menu";
    }
  }
}

class Frase {
  boolean sobre, click, boton;
  color col, ctex;
  String texto;
  float x, y, tam, w, h;
  Frase(String texto, float x, float y, float w, float h, float tam, color col, color ctex, boolean boton) {
    this.texto = texto;
    this.x = x; 
    this.y = y;
    this.w = w;
    this.h = h;
    this.tam = tam;
    this.col = col;
    this.ctex = ctex;
    this.boton = boton;
    textSize(tam);
    w = textWidth(texto);
  }
  void act() {
    sobre = false;
    click = false;
    if (mouseX > x-w/2 && mouseX < x+w/2 && mouseY > y-tam/2 && mouseY < y+tam/2) {
      sobre = true;
      if (mousePressed) {
        click = true;
      }
    }
    dibujar();
  }
  void dibujar() {
    fill(col);
    noStroke();
    if (sobre && boton) {
      textSize(tam+10);
      rect(x-w/2-10, y-h/2-10, w+20, h+20);
    }
    else {
      textSize(tam);
      rect(x-w/2, y-h/2, w, h);
    }
    fill(ctex);
    text(texto, x, y);
  }
}

