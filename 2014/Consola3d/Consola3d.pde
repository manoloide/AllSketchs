/* //<>// //<>//
 agregar paletas 
 agregar load proyectos
 crear archivo de proyectos 
 agregar status a los proyectos
 agregar particulas y figuras que se muevan
 agregar magia 
 agregar bpms
 agregar comandos a la camara
 */

ArrayList<Objeto> objetos;
Bug bug; 
Camara camara;
color[] paleta;
Consola consola;
PFont helve, helvechica;
PImage fondo;

void setup() {
  size(800, 600, P3D);
  smooth(4);
  frameRate(60);
  textureMode(NORMAL);
  paleta = new color[5];
  paleta[0] = #FCA27F;
  paleta[1] = #E88776;
  paleta[2] = #BE7B84;
  paleta[3] = #845975;
  paleta[4] = #49486A;
/*
  paleta[0] = #4A493B;
  paleta[1] = #A2778A;
  paleta[2] = #F4BE76;
  paleta[3] = #DFDC7D;
  paleta[4] = #D4DF99;
  */
  fondo = crearDegrade(width, height, paleta[int(random(5))], paleta[int(random(5))]);
  helve = createFont("Helvetica Neue Bold", 90, true);
  helvechica = createFont("Helvetica Neue Bold", 45, true);
  textFont(helve);
  objetos = new ArrayList<Objeto>();
  for (int i = 0; i < 40; i++) {
    //agregarPlane();
    //agregarBox();
    //agregarIco();
  }
  //objetos.add(new Tree(0,0,0));
  bug = null;
  camara = new Camara();
  consola = new Consola();
}

void draw() {
  if (frameCount%20 == 0) frame.setTitle("FPS: "+frameRate);
  hint(DISABLE_DEPTH_TEST);
  image(fondo, 0, 0);
  hint(ENABLE_DEPTH_TEST);
  //background(paleta[2]);
  pushMatrix();
  camara.act();
  for (int i = 0; i < objetos.size(); i++) {
    Objeto aux = objetos.get(i);
    aux.act();
    if (aux.eliminar) {
      objetos.remove(i--);
    }
  }
  popMatrix();
  hint(DISABLE_DEPTH_TEST);
  if (bug != null) {
    bug.act();
    if (bug.eliminar) bug = null;
  }
  consola.act();
  hint(ENABLE_DEPTH_TEST);
  //saveFrame("#####");
}

void keyPressed() {
  consola.press();
}
void mousePressed() {
}

void agregarPlane() {
  objetos.add(new Plane(random(-width, width), random(-height, height), random(-800, 800), 100, 100));
}
void agregarBox() {
  objetos.add(new Box(random(-width, width), random(-height, height), random(-800, 800), 100));
}

void agregarIco() {
  objetos.add(new Ico(random(-width, width), random(-height, height), random(-800, 800), 100));
}

PImage crearDegrade(int w, int h, color c1, color c2) {
  PImage aux = createImage(w, h, RGB);
  for (int j = 0; j < h; j++) {
    color c = lerpColor(c1, c2, map(j, 0, h, 0, 1));
    for (int i = 0; i < w; i++) {
      color ac = c;
      if ((i+j)%2 == 0) {
        ac = lerpColor(c, color(0), 0.08);
      }
      aux.set(i, j, ac);
    }
  }
  return aux;
}

class Camara {
  float x, y, z, rotx, roty, vely;
  int time;
  Camara() {
    x = width/2;
    y = height/2;
    z = -100;
    rotx = -0.8046021;
    roty = 4.3054013;
  }
  void act() {
    rotx += cos(((frameCount%1000)/1000.) * TWO_PI)/-1000;
    roty += vely;
    time--;
    if (time <= 0) randomCam();
    translate(x, y, z);
    rotateX(rotx);
    rotateY(roty);
    scale(0.5);
    //scale(map(frameCount,0,25*90,0.23,0.65));
  }
  void randomCam() {
    roty = random(TWO_PI); 
    rotx = random(PI*1.7, TWO_PI);
    vely = random(-0.005, 0.005);
    time = int(random(18, 100));
    /*
    int r = int(random(objetos.size()));
     x = objetos.get(r).x;
     y = objetos.get(r).y;
     z = objetos.get(r).z;*/
    //camera(width/2.0-x, height/2.0-y, (height/2.0) / tan(PI*30.0 / 180.0)-z, width/2.0, height/2.0, 0, 0, 1, 0);
  }
}


class Consola {
  ArrayList<String> ant;
  boolean visible;
  int tiempo;
  String act;
  Consola() {
    ant = new ArrayList<String>();
    act = "";
    visible = true;
  }
  void act() {
    if (visible && act.equals("")) {
      tiempo--;
      if (tiempo <= 0) visible = false;
    }
    dibujar();
  }
  void dibujar() {
    if (!visible) return;
    fill(220, 220);
    textFont(helvechica);
    for (int i = ant.size()-1; i >= 0; i--) {
      text(ant.get(i), 20, height-80-(ant.size()-i)*50);
    }
    fill(255, 220);
    textFont(helve);
    text(act, 20, height-40);
  }
  void press() {
    visible = true;
    tiempo = 60;
    if (keyCode == ENTER) {
      String comando[] = split(act, ' ');
      if (comando[0].equals("bug")) {
        if (comando.length <= 1) {
          if (random(1) < 0.5) bug = new Bug1();
          else bug = new Bug2();
        } 
        else {
          if (comando[1].equals("1")) bug = new Bug1();
          if (comando[1].equals("2")) bug = new Bug2();
        }
      }
      else if (comando[0].equals("clear")) {
        fondo = crearDegrade(width, height, paleta[int(random(5))], paleta[int(random(5))]);
        objetos = new ArrayList<Objeto>();
      }
      else if (comando.length > 1 && comando[0].equals("add")) {
        if (comando[1].equals("plane")) {
          agregarPlane();
          if (comando.length > 2) {
            for (int i = 0; i < int(comando[2])-1; i++) {
              agregarPlane();
            }
          }
        }
        else if (comando[1].equals("box")) {
          agregarBox();
          if (comando.length > 2) {
            for (int i = 0; i < int(comando[2])-1; i++) {
              agregarBox();
            }
          }
        }
        else if (comando[1].equals("ico")) {
          agregarIco();
          if (comando.length > 2) {
            for (int i = 0; i < int(comando[2])-1; i++) {
              agregarIco();
            }
          }
        }
      }
      else if (comando[0].equals("remove")) {
        if (objetos.size() > 0) {
          objetos.remove(objetos.size()-1);
        }
      }
      ant.add(act);
      act = "";
    }
    else if (keyCode == BACKSPACE) {
      if (act.length() > 0) {
        act = act.substring(0, act.length()-1);
      }
    }
    else {
      act += key;
    }
  }
}

class Pedazo {
  boolean eliminar;
  int w, h;
  float x, y, vx, vy;
  int tiempo;
  PImage img;
  Pedazo(int x, int y, int w, int h) {
    this.x = x; 
    this.y = y;
    this.w = w; 
    this.h = h;
    vx = random(-0.8, 0.8);
    vy = random(-0.8, 0.8);
    crearImagen();
    tiempo = int(random(10, 80));
  }
  void act() {
    tiempo--;
    if (tiempo <= 0) {
      eliminar = true;
    }
    vx += random(-0.01, 0.01);
    vy += random(-0.01, 0.01);
    x += vx;
    y += vy;
  }
  void crearImagen() {
    img = createImage(w, h, RGB);
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        color col = get(int(i+x), int(j+y));
        img.set(i, j, col);
      }
    }
  }
}

class Bug {
  boolean eliminar;
  void act() {
  }
  void dibujar() {
  }
}

class Bug1 extends Bug {
  ArrayList<Pedazo> pedazos;
  int tiempo;
  PGraphics img;
  Bug1() {
    pedazos = new ArrayList<Pedazo>();
    img = createGraphics(width, height);
    tiempo = int(random(25, 125));
    for (int i = 0; i < 20; i++) {
      agregarPedazo();
    }
  }
  void act() {
    tiempo--;
    if (random(100) < 20) {
      agregarPedazo();
    }
    if (tiempo <= 0) {
      eliminar = true;
    }
    for (int i = 0; i < pedazos.size(); i++) {
      Pedazo aux = pedazos.get(i); 
      aux.act();
      if (aux.eliminar) {
        pedazos.remove(i--);
      }
    }
    dibujar();
  }
  void dibujar() {
    img.beginDraw();
    img.noSmooth();
    for (int i = 0; i < pedazos.size(); i++) {
      Pedazo aux = pedazos.get(i);  
      img.image(aux.img, int(aux.x), int(aux.y));
    }
    img.endDraw();
    image(img, 0, 0);
  }
  void agregarPedazo() {
    int x = int(random(width-200));
    int y = int(random(height-200));
    int w = int(random(20, 200));
    int h = int(random(20, 200));
    pedazos.add(new Pedazo(x, y, w, h));
  }
}

class Bug2 extends Bug {
  int tiempo;
  Pedazo pedazo;
  PGraphics img;
  Bug2() {
    img = createGraphics(width, height);
    tiempo = int(random(15, 60));
    pedazo = new Pedazo(int(random(width/3, width)), 0, 1, height);
    pedazo.vy = 0;
    pedazo.tiempo = tiempo;
  }
  void act() {
    tiempo--;
    if (tiempo <= 0) {
      eliminar = true;
    }
    pedazo.act();
    pedazo.crearImagen();
    dibujar();
  }
  void dibujar() {
    img.beginDraw();
    img.noSmooth();
    for (int i = int(pedazo.x); i < width; i++) {
      img.image(pedazo.img, int(i), int(pedazo.y));
    }
    img.endDraw();
    image(img, 0, 0);
  }
}
