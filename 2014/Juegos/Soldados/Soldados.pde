ArrayList<Municion> municiones; //<>//
ArrayList<Soldado> soldados;
ArrayList<Objeto> objetos;
Camara camara;
Input input;
PImage fondo;
Soldado actual;
Terreno t;


void setup() {
  size(800, 600);
  noSmooth();
  camara = new Camara();
  input = new Input();
  fondo = crearDegrade(width, height, #0232C8, #FF32C8);
  municiones = new ArrayList<Municion>();
  soldados = new ArrayList<Soldado>();
  objetos = new ArrayList<Objeto>();
  t = new Terreno(width*2, height*2);
  for (int i = 0; i < 8; i++) {
    soldados.add(new Soldado(random(width*2), 100));
  }
  for (int i = 0; i < 10; i++) {
    objetos.add(new Tnt(random(width*2), 100));
  }
  actual = soldados.get(0);
}

void draw() {
  if (frameCount%10 == 0) frame.setTitle("Soldados -- FPS:"+frameRate);
  image(fondo, 0, 0);
  translate(int(width/2+camara.x), int(height/2+camara.y));
  camara.act();
  if (input.CAMBIAR.click) {
    int n = 0;
    for (int i = 0; i < soldados.size(); i++) {
      if (soldados.get(i) == actual) {
        n = i+1;
      }
    }
    actual = soldados.get(n%soldados.size());
  }
  t.act();
  for (int i = 0; i < soldados.size(); i++) {
    Soldado aux = soldados.get(i);
    if (aux == actual) aux.sel = true;
    else aux.sel = false;
    aux.act();
    if (aux.eliminar) {
      soldados.remove(i--);
    }
  }
  for (int i = 0; i < objetos.size(); i++) {
    Objeto aux = objetos.get(i);
    aux.act();
    if (aux.eliminar) {
      objetos.remove(i--);
    }
  }
  for (int i = 0; i < municiones.size(); i++) {
    Municion aux = municiones.get(i);
    aux.act();
    if (aux.eliminar) {
      municiones.remove(i--);
    }
  }
  //dibujar
  t.dibujar();
  for (int i = 0; i < municiones.size(); i++) {
    municiones.get(i).dibujar();
  }
  for (int i = 0; i < objetos.size(); i++) {
    objetos.get(i).dibujar();
  }
  for (int i = 0; i < soldados.size(); i++) {
    soldados.get(i).dibujar();
  }
  input.act();
}

void keyPressed() {
  input.event(true);
}

void keyReleased() {
  input.event(false);
}

void mousePressed() {
  municiones.add(new Bala(actual, -camara.x+mouseX-width/2, -camara.y+mouseY-height/2));
  //objetos.add(new Tnt(-camara.x+mouseX-width/2, -camara.y+mouseY-height/2));
}

class Key { 
  boolean press, click;
  int clickCount;
  void act() {
    if (!focused) release();
    click = false;
    if (press) clickCount++;
  }
  void press() {
    if (!press) {
      click = true; 
      press = true;
      clickCount = 0;
    }
  }
  void release() {
    press = false;
  }
  void event(boolean estado) {
    if (estado) press();
    else release();
  }
}

class Input {
  Key SALTAR, IZQUIERDA, DERECHA, CAMBIAR; 
  Input() {
    SALTAR = new Key();
    IZQUIERDA = new Key();
    DERECHA = new Key();
    CAMBIAR = new Key();
  }
  void act() {
    SALTAR.act();
    IZQUIERDA.act();
    DERECHA.act();
    CAMBIAR.act();
  }
  void event(boolean estado) {
    if (key == 'w' || key == 'W' || keyCode == UP) SALTAR.event(estado);
    if (key == 'a' || key == 'A' || keyCode == LEFT) IZQUIERDA.event(estado);
    if (key == 'd' || key == 'D' || keyCode == RIGHT) DERECHA.event(estado);
    if (keyCode == TAB) CAMBIAR.event(estado);
  }
}

class Camara {
  float x, y, dx, dy;
  Camara() {
    x = 0; 
    y = 0;
  }
  void act() {
    dx = -actual.x;
    dy = -actual.y;
    if (dx > -width/2)dx = -width/2; 
    if (dy > -height/2)dy = -height/2; 
    if (dx < width/2-t.w) dx = width/2-t.w;
    if (dy < height/2-t.h) dy = height/2-t.h;
    float dist = dist(dx, dy, x, y);
    float ang = atan2(dy-y, dx-x);
    float vel = (dist < 5)? dist/2 : dist/5;   
    x += cos(ang)*vel;
    y += sin(ang)*vel;
  }
}

class Entidad {
  boolean eliminar, inmune;
  float x, y, vida;
  int w, h;
  void act() {
  }
  void dibujar() {
  }
  void dano(float d) {
    if (inmune) return;
    vida -= d ;
    if (vida <= 0) eliminar = true;
  }
}

class Soldado extends Entidad {
  boolean sel, salto;
  float velx, vely, tiempoInmunidad;
  Soldado(float x, float y) {
    this.x = x; 
    this.y = y;
    eliminar = false;
    salto = false;
    w = 6;
    h = 10;
    velx = 1;
    vely = 0;
    vida = 20;
    tiempoInmunidad = 80;
    inmune = true;
  }
  void act() {
    vida += 0.02;
    if (vida > 20) vida = 20;
    if (tiempoInmunidad > 0) tiempoInmunidad--;
    else inmune = false;
    float antx = x; 
    float anty = y;
    if (sel) {
      if (input.IZQUIERDA.press) {
        x -= velx;
      }
      if (input.DERECHA.press) {
        x += velx;
      }
      if (t.colisiona(this)) {
        y--; 
        if (t.colisiona(this)) {
          x = antx;
          y = anty;
        } 
        anty = y;
      }
      if (input.SALTAR.click && !salto) {
        salto = true;
        vely = -6;
      }
    }
    vely+= 0.5; 
    y += vely;
    if (t.colisiona(this)) {
      y = anty;
      if (vely > 10) {
        dano((vely-9)*3);
      }
      salto = false;
      vely = 0;
    }
  }
  void dibujar() {
    noStroke();
    int vw = int(map(vida, 0, 20, 0, w+6));
    int xx = int(x-w/2);
    int yy = int(y-h/2);
    fill(0, 255, 0);
    rect(xx-3, yy-6, vw, 2);
    fill(255, 0, 0);
    rect(xx+vw-3, yy-6, w+6-vw, 2);
    fill(0);
    rect(int(x-w/2), int(y-h/2), w, h);
  }
  boolean colision(Bala b) {
    if (b.x >= x-w/2 && b.x < x+w/2 && b.y >= y-h/2 && b.y < y+h/2) {
      dano(2);
      float antx = x; 
      float anty = y;
      x += cos(b.ang)*2;
      if (t.colisiona(this)) {
        x = antx;
      }
      y += cos(b.ang)*2;
      if (t.colisiona(this)) {
        y = anty;
      } 
      return true;
    }
    return false;
  }
}

class Terreno {
  int w, h;
  PImage img;
  Terreno(int w, int h) {
    this.w = w; 
    this.h = h;
    img = createImage(w, h, ARGB);
    for (int i = 0; i < img.pixels.length; i++) {
      img.pixels[i] = color(0, 0);
    }
    generar();
  }
  void act() {
    /*
    for (int i = 0; i < 100000; i++) {
     int x = int(random(w));
     int y = int(random(h));
     color col = img.get(x, y);
     float alp = alpha(col); 
     if (alp > 200) continue;
     else if (alp < 1 && y > 0 && alpha(img.get(x, y-1)) >= 1 && alpha(img.get(x, y-1)) < 200) {
     img.set(x, y, img.get(x, y-1));
     img.set(x, y-1, color(0, 0));
     }
     else {
     }
     }*/
  }

  void dibujar() {
    image(img, 0, 0);
  }
  void generar() {
    float alto = random(300, 600);  
    for (int i = 0 ; i < w; i++) {
      alto += random(-0.5, 0.5);
      for (int j = int(alto); j < h; j++) {
        color col = lerpColor(color(255, 217, 48), color(180, 70, 15), map(j, 500, h, 0, 1));
        img.set(i, j, col);
      }
    }
    /*
    for (int c = 0; c < 30; c++) {
     int x0 = int(random(w)); 
     int y0 = int(random(h));
     int dx = int(random(80, 180));
     int dy = int(random(20, 100));
     x0 -= dx/2;
     if (x0 < 0) x0 = 0;
     y0 -= dy/2;
     if (y0 < 0) y0 = 0;
     float x1 = x0 + dx;
     if (x1 > w) x1 = w;
     float y1 = y0 + dy;
     if (y1 > h) y1 = h;
     for (int j = y0; j < y1; j++) {
     color col = lerpColor(color(0, 200, 255, 120), color(35, 9, 95, 200), map(j, 0, height, 0, 1));
     for (int i = x0; i < x1; i++) {
     if (alpha(img.get(i, j))>0) {
     img.set(i, j, col);
     }
     }
     }
     }
     */
  }
  void circulo(float cx, float cy, float dis) {
    for (int i = int(round(cy - dis)); i <= cy + dis; i++) {
      for (int j = int(round(cx - dis)); j <= cx+ dis; j++) {
        if ((i>=0)&&(i<img.height)&&(j<img.width)&&(j>=0)) {
          if (dist(j, i, cx, cy) <= dis) {
            img.set(j, i, color(0, 0));
          }
        }
      }
    }
  }
  boolean colisiona(Entidad e) {
    return rectColision(int(e.x-e.w/2), int(e.y-e.h/2), e.w, e.h);
  }
  boolean colisiona(Municion m) {
    if (alpha(img.get(int(m.x), int(m.y))) > 0) {
      circulo(m.x, m.y, 2);
      return true;
    }
    return false;
  }
  boolean colisiona(Objeto o) {
    return rectColision(int(o.x-o.w/2), int(o.y-o.h/2), o.w, o.h);
  }
  boolean rectColision(int cx, int cy, int cw, int ch) {
    for (int j = 0; j < ch; j++) {
      for (int i = 0; i < cw; i++) {
        if (alpha(img.get(cx+i, cy+j)) > 200) {
          return true;
        }
      }
    }
    return false;
  }

  void cargarImagen(String src) {
    img = loadImage(src);
  }
}

class Municion {
  boolean eliminar; 
  Entidad e;
  float x, y, ang, vel;
  void act() {
  }
  void dibujar() {
  }
}

class Bala extends Municion {
  Bala(Entidad e, float dx, float dy) {
    this.e = e;
    this.x = e.x; 
    this.y = e.y;
    ang = atan2(dy-y, dx-x);
    vel = 5;  
    eliminar = false;
  }
  void act() {
    for (int i = 0; i < vel; i++) {
      x += cos(ang);
      y += sin(ang);
      if (t.colisiona(this)) {
        eliminar = true;
        break;
      }
    }
    if (x < -10 || x > t.w+10 || y < -10 || y > t.h+10) {
      eliminar = true; 
      return;
    }
    for (int i = 0; i < objetos.size(); i++) {
      Objeto aux = objetos.get(i); 
      if (aux.colision(this)) {
        eliminar = true;
        return;
      }
    }
    for (int i = 0; i < soldados.size(); i++) {
      Soldado aux = soldados.get(i); 
      if (aux != e && aux.colision(this)) {
        eliminar = true;
        return;
      }
    }
  }
  void dibujar() {
    stroke(247, 255, 185);
    ellipse(int(x), int(y), 1, 1);
  }
}

PImage crearDegrade(int w, int h, color c1, color c2) {
  PImage aux = new PImage(w, h, RGB);
  for (int j = 0; j < h; j++) {
    color col = lerpColor(c1, c2, map(j, 0, h, 0, 1)); 
    for (int i = 0; i < w; i++) {
      aux.set(i, j, col);
    }
  }
  return aux;
}

class Objeto {
  boolean eliminar, inmune;
  float x, y;
  int w, h;
  void act() {
  }
  void dibujar() {
  }
  boolean colision(Bala b) {
    return false;
  }
}

class Tnt extends Objeto {
  boolean encendido;
  float vely, anty; 
  int tiempo;
  Tnt(float x, float y) {
    this.x = x; 
    this.y = y;
    w = h = 6;
    eliminar = false; 
    encendido = false; 
    tiempo = 120;
  }
  void act() {
    if (encendido) {
      tiempo--;
      if (tiempo <= 0) {
        eliminar();
      }
    }
    float anty = y;
    vely+= 0.5; 
    y += vely;
    if (t.colisiona(this)) {
      y = anty;
      vely = 0;
    }
  }
  void dibujar() {
    noStroke();
    fill(232, 40, 40);
    if (tiempo < 15 || (tiempo/10)%2 == 1) {
      fill(255);
    } 
    rect(x-w/2, y-h/2, w, h);
  }
  void eliminar() {
    if (eliminar) return;
    eliminar = true;
    for (int i = 0; i < objetos.size(); i++) {
      Objeto aux = objetos.get(i);
      if (aux instanceof Tnt) {
        Tnt ta = (Tnt) aux;
        float dis = dist(x, y, ta.x, ta.y); 
        //if (dis < 6) ta.eliminar(); else 
        if(dis < 30) ta.encender();
      }
    }
    for(int i = 0;i < soldados.size(); i++){
       Soldado aux = soldados.get(i);
       float dis = dist(x, y, aux.x, aux.y); 
       if(dis < 30){
          aux.dano(map(dis,0,30,30,0)); 
       }
    }
    t.circulo(x, y, 26);
  }
  void encender() {
    if (encendido) eliminar(); 
    else encendido = true;
  }
  boolean colision(Bala b) {
    if (b.x >= x-w/2 && b.x < x+w/2 && b.y >= y-h/2 && b.y < y+h/2) {
      encender();
      float antx = x; 
      float anty = y;
      x += cos(b.ang)*2;
      if (t.colisiona(this)) {
        x = antx;
      }
      y += cos(b.ang)*2;
      if (t.colisiona(this)) {
        y = anty;
      } 
      return true;
    }
    return false;
  }
}
