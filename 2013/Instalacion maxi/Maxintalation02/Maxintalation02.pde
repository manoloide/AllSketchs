import java.awt.Frame;
import processing.serial.*;

final int width_principal = 1280;
final int height_principal = 1024;
final int width_secundario = 1024;
final int height_secundario = 768;
final int fps = 60;

PFrame f;
secondApplet s;
Serial Puerto;
boolean serial = true;

ArrayList<Imagen> imagenes;
boolean cargando;
float porcentaje_carga;
float px = 0;
float zoom = 0;
Imagen img1, img2;
int numero = 0;
float tiempo_ingreso;
String text = "";
String todo[] = new String[1];

public void init() { 
  frame.setResizable(true);
  frame.setBounds(0, 0, width_principal, height_principal);
  frame.removeNotify(); 
  frame.setUndecorated(true); 
  frame.addNotify(); 
  super.init();
}

void setup() {
  size(width_principal, height_principal);
  frameRate(fps);
  noCursor();
  noSmooth();
  cargando = true;
  thread("cargar");
  //blendMode(SCREEN);
  if (serial) {
    String portName = Serial.list()[1];
    Puerto = new Serial(this, portName, 9600);
  }
}

void draw() {
  if (frameCount%10 == 0)
    frame.setTitle("FPS: " + frameRate);
  if (cargando) {
    frame.setBounds(0, 0, width_principal, height_principal);
    background(0);
    noStroke();
    fill(220);
    rect(width/2-60, height/2-10, 120*porcentaje_carga, 20); 
    strokeWeight(2);
    stroke(200);
    noFill();
    rect(width/2-60, height/2-10, 120, 20);
    return;
  }
  if (text.length() == 1 && frameCount-tiempo_ingreso >= 60*30) {
    text = "";
  }/*
  if (frameCount%30 == 0) {
   numero = (numero+1)%100;
   cambiarNumero();
   }*/
  if (frameCount-tiempo_ingreso >= 60*240) {
    numero = int(random(100));
    todo = append(todo, "r"+numero); 
    cambiarNumero();
  }
  if (frameCount-tiempo_ingreso >= 60*243) {
    tiempo_ingreso = frameCount;
  }
  if (serial && Puerto.available() > 0) {
    int aux = Puerto.read();
    text += aux;
    tiempo_ingreso = frameCount;
    if (text.length() >= 2) {
      numero = int(text);
      todo = append(todo, text);
      text = "";
      cambiarNumero();
    }
  }
  img1.act(this);
  textSize(60);
  fill(0);
  //text(text, 200, 200);
  //text(numero, 200, 260);
}

void keyPressed() {
  if (key >= '0' && key <= '9') {
    text += key;
    tiempo_ingreso = frameCount;
    if (text.length() >= 2) {
      numero = int(text);
      todo = append(todo, text);
      text = "";
      cambiarNumero();
    }
  }
  if (keyCode == LEFT) {
    numero = (numero+99)%100;
    cambiarNumero();
  }
  if (keyCode == RIGHT) {
    numero = (numero+1)%100;
    cambiarNumero();
  }
}

void dispose() {
  todo = append(todo, year()+"_"+month()+"_"+day()+"  "+hour()+"_"+minute());
  saveStrings(todo[0]+".txt", todo);
} 

void cambiarNumero() {
  img1 = imagenes.get(numero%imagenes.size());
  img1.dir = 1 - (int(random(2)) * 2);
  img2 = imagenes.get(((numero%10)*10+numero/10)%imagenes.size());
  img2.dir = 1 - (int(random(2)) * 2);
}

void cargar() {
  String info[] = loadStrings("info.txt");
  todo[0] = year()+"_"+month()+"_"+day()+"  "+hour()+"_"+minute();
  imagenes =new ArrayList<Imagen>();
  for (int i=0;i<info.length;i++) {
    porcentaje_carga = i*1.0/info.length;
    String par[] = split(info[i], ' ');
    Imagen aux = new Imagen(loadImage(par[0]));
    for (int j = 1; j < par.length-1; j++) {
      aux.agregarFrame(loadImage(par[j]));
    }
    if (par[par.length-1].equals("true")) {
      aux.continuo = true;
    }
    else {
      aux.continuo = false;
    }
    imagenes.add(aux);
  }
  numero = int(random(100));
  cambiarNumero();
  text = "";
  todo = append(todo, "r"+numero);
  cargando = false;
  f = new PFrame();
}

class PFrame extends Frame {
  PFrame() {
    setBounds(-width_secundario, 0, width_secundario, height_secundario);
    s = new secondApplet();
    add(s);
    setUndecorated(true);
    s.init();
    show();
  }
}

class secondApplet extends PApplet {
  void setup() {
    size(width_secundario, height_secundario);
    noCursor();
    noSmooth();
  }
  public void draw() {
    img2.act(this);
  }
}

class Imagen {
  ArrayList<PImage> frames;
  boolean movimientoHorizontal, movimientoVertical, continuo;
  float x, y, w, h, escala, vel;
  int frame = 0, dir;
  Imagen(PImage img) {
    frames = new ArrayList<PImage>();
    frames.add(img);
    x = 0;
    y = 0;
    w = img.width;
    h = img.height;
    continuo = true;
    vel = 0.5;
    dir = 1;
    frame = 0;  
    escala = 2;
  }
  void act(PApplet p) {
    if (frameCount%2 == 0) {
      frame++;
      frame = frame%frames.size();
    }
    if (w/p.width > h/p.height) {
      escala = p.height/h;
      movimientoHorizontal = true;
      movimientoVertical = false;
    }
    else {
      escala = p.width/w;
      movimientoHorizontal = false;
      movimientoVertical = true;
    }
    if (movimientoHorizontal) {
      x += vel*dir;
    }
    if (movimientoVertical) {
      y += vel*dir;
    }
    if (continuo) {
      x = (x+w*escala)%(w*escala);
      y = (y+h*escala)%(h*escala);
    }
    else {
      if (movimientoHorizontal) {
        if (x >= 0) {
          dir = -1;
        }
        if (x+w*escala < p.width) {
          dir = 1;
        }
      }
      if (movimientoVertical) {
        if (y >= 0) {
          dir = -1;
        }
        if (y+h*escala < p.height) {
          dir = 1;
        }
      }
    }
    dibujar(p);
  }

  void dibujar(PApplet p) {
    if (continuo) { 
      if (movimientoHorizontal) {
        p.image(getFrame(), x-w*escala, y, w*escala, h*escala);
        p.image(getFrame(), x+w*escala, y, w*escala, h*escala);
      }
      if (movimientoVertical) {
        p.image(getFrame(), x, y-h*escala, w*escala, h*escala);
        p.image(getFrame(), x, y+h*escala, w*escala, h*escala);
      }
    }
    p.image(getFrame(), x, y, w*escala, h*escala);
  }
  void agregarFrame(PImage frame) {
    frames.add(frame);
  }
  PImage getFrame() {
    frame = frame%frames.size();
    return frames.get(frame);
  }
}

