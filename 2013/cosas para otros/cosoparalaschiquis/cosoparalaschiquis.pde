import processing.video.*;

int contador;
String pantalla; //menu,f1,f2,f3,v1,v2,v3;
PImage f1, f2, f3;
Movie v1, v2, v3;
Boton a, b, c;


void setup() {
  size(800, 600, P3D);
  background(0);
  //aca se cargan las imagenes del video
  f1 = loadImage("img.jpg");
  f2 = loadImage("img.jpg");
  f3 = loadImage("img.jpg");
  //aca se cargan los video; 
  v1 = new Movie(this, "video.mov");
  v2 = new Movie(this, "video.mov");
  v3 = new Movie(this, "video.mov");
  //aca los bontes
  a = new Boton(random(width), random(height), 100, 100, f1);
  b = new Boton(random(width), random(height), 100, 100, f2);
  c = new Boton(random(width), random(height), 100, 100, f3);

  pantalla = "menu";
}

void draw() {
  background(0);
  if (pantalla.equals("menu")) {
    a.act();
    b.act();
    c.act();
    if (a.click) {
      v1.play();
      pantalla = "v1";
    }
    if (b.click) {
      v2.play();
      pantalla = "v2";
    }
    if (c.click) {
      v3.play();
      pantalla = "v3";
    }
  } else if (pantalla.equals("v1")) {
    if (v1.available()) {
      v1.read();
    }
    image(v1, 0, 0, width, height);
    if (v1.time() >= v1.duration()) {
      v1.stop();
      pantalla = "menu";
    }
  } else if (pantalla.equals("v2")) {
    if (v2.available()) {
      v2.read();
    }
    image(v2, 0, 0, width, height);
    if (v2.time() >= v2.duration()) {
      v2.stop();
      pantalla = "menu";
    }
  } else if (pantalla.equals("v3")) {
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

class Boton {
  boolean sobre, click, boton;
  float x, y, w, h, c, ang;
  PImage img;
  Boton(float x, float y, float w, float h, PImage img) {
    this.x = x; 
    this.y = y;
    this.w = w;
    this.h = h;
    this.img = img;
    ang = random(TWO_PI);
    c = 0;
  }
  void act() {
    ang += random(-0.1, 0.1);
    x += cos(ang);
    y += sin(ang);
    if ( x < -w) {
      x = width+w;
    }
    if ( x > width+w) {
      x = -w;
    }
    if ( y < -h) {
      y = height+h;
    }
    if ( y > height+h) {
      y = -h;
    }
    sobre = false;
    click = false;
    if (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h) {
      sobre = true;
      if (mousePressed) {
        click = true;
      }
      c+=0.5;
      if (c > 5) {
        c = 5;
      }
    } else {
      c-=1;
      if (c < 0) {
        c = 0;
      }
    }
    dibujar();
  }
  void dibujar() {
    image(img, x-c/2, y-c/2, w+c, h+c);
  }
}

