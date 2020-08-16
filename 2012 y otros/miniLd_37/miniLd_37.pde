/*
**********************
 *Manoloide
 *manoloide.com.ar
 *manoloide@gmail.com
 *septiembre 2012
 **********************/

/*IDEAS Y COSAS RESOLVER:
 - bordes se van a la mierda
 */
import ddf.minim.*;
import java.util.Collections;

Minim minim;
AudioSample sonidos[];

ArrayList<Entidad> entidades;

PImage terrenos[];
PImage ioveja[];
PImage ifabrica;
Boton boton;
Mapa m;
Jugador j;
Font fuente;
int fps, fabricas, matadas; 
boolean click = false;
void setup() {
  size(640, 480);
  frameRate(60);

  terrenos = recortarImagen("/img/terrenos.png", 32, 16, 4);
  ioveja = recortarImagen("/img/oveja.png", 13, 8, 4);
  ifabrica = ampliar(loadImage("/img/edificios.png"), 4);
  boton = new Boton("new fabrica", 490, 380, 140, 50);
  m = new Mapa(32, 32);
  j = new Jugador(0, 0);
  fuente = new Font("/img/font.png");

  entidades = new ArrayList<Entidad>();

  noStroke();

  m.selx = 15;
  m.sely = 15;
  Cuadra sel = m.getSel();
  Fabrica nueva = new Fabrica(m.selx, m.sely);
  entidades.add(nueva);
  sel.f = nueva;
  j.x = 188;
  j.y = -746;
  fabricas = 1;
  matadas = 0;
  //sonido 
  minim = new Minim(this);
  sonidos = new AudioSample[2];
  sonidos[0] = minim.loadSample("sonidos/o1.mp3", 2048);
  sonidos[1] = minim.loadSample("sonidos/o2.mp3", 2048);
}

void draw() {
  background(0);
  j.act();
  m.act(j.x, j.y);

  Collections.sort(entidades);
  for (int i = 0; i < entidades.size (); i++) {
    Entidad e = entidades.get(i);
    e.act();
    if (e.borrar) {
      entidades.remove(i--);
    }
    if (click && (e instanceof Oveja)) {
      Oveja o = (Oveja) entidades.get(i);
      fill(255, 0, 0);
      int x = o.getX()+o.w/2;
      int y = o.getY()+o.h/2;
      if (dist(mouseX, mouseY, x, y)<18) {
        o.ataque();
        click = false;
        if (o.borrar) {
          for (int j = 0; j < 500; j++) {
            entidades.add(new PSangre(o.x+o.mx+o.w/2, o.y+o.my+o.h/2));
          }
          entidades.remove(i--);
        } else {
          for (int j = 0; j < 50; j++) {
            entidades.add(new PSangre(o.x+o.mx+o.w/2, o.y+o.my+o.h/2));
          }
        }
      }
    }
  }
  gui();
  click = false;
}

void mousePressed() {

  if (mouseX < 480) {
    m.selx = m.sx;
    m.sely = m.sy;

    click = true;
  } else {
    Cuadra sel = m.getSel();
    if (boton.sobre && sel != null && sel.f == null && j.dinero >= 500) {
      j.dinero -= 500;
      Fabrica nueva = new Fabrica(m.selx, m.sely);
      entidades.add(nueva);
      sel.f = nueva;
      fabricas++;
    }
  }
}

void gui() {
  String msn;
  if (frameCount%10 == 0) {
    fps = int(frameRate);
  }
  fill(80);
  rect(480, 0, 160, height);
  boton.act();
  printMsn("500", 540, 410);
  printMsn("Fps:" +fps, 490, 8);
  printMsn("Matadas:" +matadas, 490, 40);
  printMsn("Fabricas:"+fabricas, 490, 60);
  printMsn("dinero:" + j.dinero, 490, 456);

  Cuadra sel = m.getSel();
  if (sel != null) {
  }
}
class Jugador {
  int x, y;
  int dinero;
  Jugador(int x, int y) {
    this.x = x;
    this.y = y;
    dinero = 0;
  } 

  void act() {
    int cx = 240;
    int cy = height/2;
    float dis = dist(mouseX, mouseY, cx, cy);
    if (mouseX < 480 && dis > 100) {
      float disx = dist(cx, 0, mouseX, 0);
      float disy = dist(cy, 0, mouseY, 0);
      int vel = 35;
      int mx =int( (disx > 120)? disx/vel : 0);
      int my = int((disy > 100)? disy/vel : 0);

      x = (cx > mouseX)? x+mx : x-mx;
      y = (cy > mouseY)? y+my : y-my;
    }
  }
}

class Mapa {
  int w, h;
  Cuadra c[][];
  int selx, sely;
  int sx, sy;
  Mapa(int w, int h) {
    this.w = w;
    this.h = h;
    nuevoMapa();
    selx = -1;
    sely = -1;
  }

  void act(int x, int y) {
    sx = -100;
    sy = -100;
    int ancho = terrenos[0].width; 
    int alto = terrenos[0].height; 
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        int px = x + (i-j) * ancho/2;
        int py = y + (i+j) * alto/2;
        image(terrenos[c[i][j].t+1], px, py);
        if (abs(mouseX-px-ancho/2) < ancho/4 && abs(mouseY-py-alto/2) < alto/4) {
          sx = i;
          sy = j;
        }
      }
    }

    image(terrenos[0], x + (sx-sy) * ancho/2, y + (sx+sy) * alto/2);

    if (selx >= 0) {
      image(terrenos[0], x + (selx-sely) * ancho/2, y + (selx+sely) * alto/2);
    }
  }
  Cuadra getSel() {
    if (selx >= 0) {
      return c[selx][sely];
    }
    return null;
  }

  void nuevoMapa() {
    c = new Cuadra[w][h];
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        c[i][j] = new Cuadra(int(random(4)));
      }
    }
  }
}

class Cuadra {
  int t;
  Fabrica f = null;
  Cuadra(int t) {
    this.t = t;
  }
}

class Font {
  String letras;
  PImage letra[];
  int ancho, alto;
  Font(String name) {
    letras = " ABCDEFGHIJKLMNÑOPQRSTUVWXYZ0123456789:;.,!?";
    letra = recortarImagen(name, 6, 7, 2);
    ancho = letra[0].width;
    alto = letra[0].height;
  }

  void escribir(String msn, int x, int y, color col) {
    PImage l = createImage(ancho, alto, ARGB);
    msn = msn.toUpperCase();
    int cant = msn.length();
    for (int i = 0; i < cant; i++) {
      int val = 0;
      while (val < letras.length ()-1 && msn.charAt(i) != letras.charAt(val)) {
        val++;
      }
      l.loadPixels();
      for (int j = 0; j < alto; j++) {
        for (int k = 0; k < ancho; k++) {
          color aux = letra[val].get(k, j);
          if (alpha(aux) > 200) {
            l.set(k, j, col);
          } else {
            l.set(k, j, color(0, 0));
          }
        }
      }
      l.updatePixels();
      image(l, x+i*ancho, y);
    }
  }
}

class Boton {
  int x, y, w, h;
  boolean sobre;
  String name;
  Boton(String name, int x, int y, int w, int h) {
    this.name = name;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    sobre = false;
  }

  void act() {
    if (mouseX > x && mouseY > y && mouseX < x+w && mouseY < y+h) {
      sobre = true;
    } else {
      sobre = false;
    }
    if (sobre) {
      fill(140);
    } else {
      fill(120);
    }
    rect(x, y, w, h);
    printMsn(name, x+4, y+4);
  }
}

class PSangre extends Entidad {
  int time;
  float mx, my, xx, yy, vy, lim;
  PSangre(int x, int y) {
    super(x, y);
    w = h = int(random(2)+1);
    xx = 0;
    yy = 0;
    mx = random(-2, 2);
    my = random(-2.5, -1);
    vy = random(0.05, 0.2);
    lim = 1+random(10);
    time = int(40+random(100));
  }
  void act() {
    time--;
    if (time < 0) {
      borrar = true;
    }
    xx += mx;
    mx /=1.05;
    if (yy < lim) {
      my += vy;
      yy += my;
    }

    float px = j.x + x + xx;
    float py = j.y + y + yy;

    fill(240, 44, 5);
    rect(px, py, w, h);
  }
  int getY() {
    return 10000;
  }
}

class Oveja extends Entidad {
  int dir, vel; 
  int mx, my;
  int vida = 3;
  Oveja(int x, int y) {
    super((x-y) * terrenos[0].width/2+terrenos[0].width/4, (x+y) * terrenos[0].height/2);
    w = ioveja[0].width;
    h = ioveja[0].height;
    dir = int(random(4));

    mx = 0; 
    my = 0;

    vel = 1;
  }

  void ataque() {
    vida--;
    vel = 2;
    if (random(5) > 3) {
      sonidos[1].trigger();
    }
    if (random(2) > 1) {
      dir = int(random(4));
    }
    if (vida <= 0) {
      j.dinero += 20;
      matadas++;
      borrar = true;
    }
  }
  void act() {
    if (random(100) < 1) {
      dir = int(random(4));
    }
    if (vel == 1 && random(100) > 98) {
      vel = 0;
    }
    if (vel == 0 && random(100) > 99) {
      vel = 1;
    }

    if (frameCount%2 == 0) {
      if (dir == 0) {
        mx+=vel*2;
        my+=vel;
      } else if (dir == 1) {
        mx-=vel*2;
        my+=vel;
      } else if (dir == 2) {
        mx-=vel*2;
        my-=vel;
      } else if (dir == 3) {
        mx+=vel*2;
        my-=vel;
      }
    }

    //dibujar 
    int px = j.x + x;
    int py = j.y + y;

    if (vel > 0 && (frameCount%10) > 4) {
      image(ioveja[dir+4], px+mx, py+my-4);
    } else {
      image(ioveja[dir], px+mx, py+my);
    }
  }
  int getX() {
    return j.x+x+mx;
  }
  int getY() {
    return j.y+y+my;
  }
}

class Entidad implements Comparable {
  boolean borrar = false;
  int x, y, w, h;
  Entidad(int x, int y) {
    this.x = x;
    this.y = y;
  }
  void act() {
  }

  int compareTo(Object o) { 
    int res = 0; 
    Entidad e =  (Entidad) o;

    if (getY() < e.getY()) { 
      res = -1;
    } else if (getY() > e.getY()) { 
      res = 1;
    }

    return res;
  }
  int getY() {
    print("entidad");
    return -1111;
  }
}

class Fabrica extends Entidad {
  int time;
  Fabrica(int x, int y) {
    super(x, y);
    w = ifabrica.width;
    h = ifabrica.height;
    time = 120;
  }
  void act() {
    time--;
    if (time < 0) {    
      if (random(100) < 5) {
        sonidos[0].trigger();
      }
      entidades.add(new Oveja(x, y));
      time = 200;
    }
    int ancho = terrenos[0].width; 
    int alto = terrenos[0].height; 
    int px = j.x + (x-y) * ancho/2;
    int py = j.y + (x+y) * alto/2 - ifabrica.height/3;
    image(ifabrica, px, py);
  }
  int getY() {
    return j.y + (x+y) * terrenos[0].height/2;
  }
}
void printMsn(String msn, int x, int y) {
  fuente.escribir(msn, x+2, y+2, color(20));
  fuente.escribir(msn, x, y, color(240));
}

//IMAGENES

PImage[] recortarImagen(String name, int ancho, int alto, int es) {
  PImage ori = loadImage(name);
  int cant = ori.width/ancho;
  PImage res[] = new PImage[cant];
  for (int i = 0; i < cant; i++) {
    PImage aux = createImage(ancho, alto, ARGB);
    aux.copy(ori, i*ancho, 0, ancho, ori.height, 0, 0, ancho, alto);
    res[i] = ampliar(aux, es);
  }
  return res;
}

PImage ampliar(PImage ori, int es) {
  int ancho =  ori.width; 
  int alto = ori.height;
  PImage res = createImage(ancho*es, alto*es, ARGB);
  for (int j = 0; j < alto; j++) {
    for (int i = 0; i < ancho; i++) {
      color col = ori.get(i, j);
      for (int k = 0; k < es; k++) {
        for (int l = 0; l < es; l++) {
          res.set(i*es+l, j*es+k, col);
        }
      }
    }
  }
  return res;
}

