ArrayList dibujadores;
PFont font;
Boton b1;
scrollH s1, s2, s3, s4, s5, s6, s7, s8;
Pulsador p1, p2;

void setup() {
  size(600, 800);
  frameRate(60);
  smooth();

  font = loadFont("font.vlw");
  textFont(font);

  s1 = new scrollH(410, 30, 180, 10, 1, 50, 6, "stroke max");
  s2 = new scrollH(410, 50, 180, 10, 0, 30, 5, "variacion color");
  s3 = new scrollH(410, 70, 180, 10, -50, 50, 5, "caida");
  s4 = new scrollH(410, 90, 180, 10, 0, 255, 100, "alpha min");
  s5 = new scrollH(410, 110, 180, 10, 0, 255, 200, "alpha max");
  s6 = new scrollH(410, 130, 180, 10, 0, 20, 2, "movimiento x");
  s7 = new scrollH(410, 150, 180, 10, 0, 255, 0, "s4");
  s8 = new scrollH(410, 170, 180, 10, 0, 255, 0, "s4");

  p1 = new Pulsador(410, 270, 10, 10, "reiniciar");
  p2 = new Pulsador(510, 270, 10, 10, "random");

  b1 = new Boton(410, 290, 10, 10, true, "RGB/HSB");

  iniciar();
}

void draw() {
  Dibujador aux;
  for (int i = 0; i < dibujadores.size(); i++) {
    aux = (Dibujador) dibujadores.get(i);
    aux.act();
  }
  menu();
}

void iniciar() {
  fill(255);
  noStroke();
  rect(0, 0, 400, 800);
  dibujadores = new ArrayList();
  for (int i = 0; i < 100; i++) {
    dibujadores.add(new Dibujador(random(width-200), 0));
  }
}

void menu() {
  noStroke();
  fill(60);
  rect(400, 0, 200, height);
  fill(255);
  text("SUPER PARAMETROS", 410, 15);
  s1.act();
  s2.act();
  s3.act();
  s4.act();
  s5.act();
  s6.act();
  s7.act();
  s8.act();
  p1.act();
  p2.act();
  b1.act();
  if (p1.val) {
    iniciar();
  }
  if (p2.val) {
    s1.val = random(s1.min, s1.max);
    s2.val = random(s2.min, s2.max);
    s3.val = random(s3.min, s3.max);
    s4.val = random(s4.min, s4.max);
    s5.val = random(s5.min, s5.max);
    s6.val = random(s6.min, s6.max);
  }
  if (b1.val) {
    colorMode(RGB,256,256,256);
  }
  else {
    colorMode(HSB,256,256,256);
  }
}

class Boton {
  float x, y, width, height;
  boolean val,aux;
  String name;

  Boton(float nx, float ny, float nw, float nh, boolean nv, String n) {
    x = nx;
    y = ny;
    width = nw;
    height = nh;
    val = nv;
    name = n;
    aux = false;
  }

  void act() {
    if (mousePressed && !aux) {
      aux = true;
      if ( mouseX >= x  && mouseX <= x + width ) {
        if ( mouseY >= y  && mouseY <= y + height ) {
          if (val) {
            val = false;
          }
          else {
            val = true;
          }
        }
      }
    }
    if (aux && !mousePressed){
       aux = false; 
    }
    draw();
  }

  void draw() {
    noStroke();
    if (val) {
      fill(150);
    }
    else {
      fill(120);
    }
    rect(x, y, width, height);
    fill(255);
    text(name, x+width+2, y+height-2);
  }
}
class Dibujador {
  float x, y, vx, vy, r, g, b;

  Dibujador(float nx, float ny) {
    x = nx;
    y = ny;
    r = random(255);
    g = random(255);
    b = random(255);
  } 

  void act() {
    float c = s2.val;
    vx = x;
    vy = y;
    y += random(s3.val);
    x += random(-s6.val, s6.val);

    r += random(-random(c), random(c));
    g += random(-random(c), random(c));
    b += random(-random(c), random(c));
    strokeWeight(random(1, s1.val));
    stroke(r, g, b, random(s4.val, s5.val));
    line(vx, vy, x, y);
    if (y > height) {
      y = 0;
    }
    else if (y < 0) {
      y = height;
    }
    if (x > width-200) {
      x -= 1;
    }
    if (x < 0) {
      x += 1;
    }
  }
}

class Pulsador {
  float x, y, width, height;
  boolean val;
  String name;

  Pulsador(float nx, float ny, float nw, float nh, String n) {
    x = nx;
    y = ny;
    width = nw;
    height = nh;
    val = false;
    name = n;
  }

  void act() {
    if (mousePressed) {
      if ( mouseX >= x  && mouseX <= x + width ) {
        if ( mouseY >= y  && mouseY <= y + height ) {
          val = true;
        }
      }
    }else{
      val = false;
    }
    draw();
  }

  void draw() {
    noStroke();
    if (val) {
      fill(150);
    }
    else {
      fill(120);
    }
    rect(x, y, width, height);
    fill(255);
    text(name, x+width+2, y+height-2);
  }
}

class scrollH {
  float x, y, width, height, max, min, val;
  String name;
  scrollH(float nx, float ny, float nw, float nh, float nmin, float nmax, float nvar, String n) {
    x = nx;
    y = ny;
    width = nw;
    height = nh;
    max = nmax;
    min = nmin;
    val = nvar;
    name = n;
  }

  void act() {
    if (mousePressed) {
      if ( mouseX >= x + height/2 && mouseX - 8 <= x + width - height/2+ 8) {
        if ( mouseY >= y  && mouseY <= y + height )
          val = min + (max-min) * ((mouseX- height/2 - x )/(width - height));
        if (val < min) {
          val = min;
        }
        else if (val > max) {
          val = max;
        }
      }
    } 
    draw();
  }

  void draw() {
    fill(120);
    rect(x, y, width, height);

    fill(150);
    float pos = x + ((width-height) * (val-min)/(max-min));
    rect(pos, y, height, height);
    fill(255);
    text(name+" "+val, x+2, y+8);
  }
}

