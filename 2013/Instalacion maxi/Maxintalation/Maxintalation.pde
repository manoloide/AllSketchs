import java.awt.Frame; //<>//
import processing.serial.*;

final int width_principal = 1280;
final int height_principal = 1024;
final int width_secundario = 1024;
final int height_secundario = 768;
final int fps = 60;

PFrame f;
secondApplet s;
Serial Puerto;
boolean serial = false;

ArrayList<Imagen> imagenes;
boolean cargando;
float porcentaje_carga;
float px = 0;
float zoom = 0;
int numero = 0;
float tiempo_ingreso;
String text = "";

public void init() { 
  frame.setResizable(true);
  frame.setBounds(0, 0, width_principal, height_principal);
  frame.removeNotify(); 
  //frame.setUndecorated(true); 
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
  }
  if (frameCount % 120 == 0) {
    numero = (numero+1)%100;
  }
  if (serial && Puerto.available() > 0) {
    int aux = Puerto.read();
    text += aux;
    println(aux);
  }

  background(0);
  Imagen img = imagenes.get(numero%imagenes.size());
  img.act(this);
  textSize(60);
  fill(0);
  text(text, 200, 200);
  text(numero, 200, 260);
}

void keyPressed() {
  if (key >= '0' && key <= '9') {
    text += key;
    tiempo_ingreso = frameCount;
    if (text.length() >= 2) {
      numero = int(text);
      text = "";
    }
  }
}

void cargar() {
  String path = sketchPath+"\\data"+"\\"; 
  File[] files = listFiles(path);
  imagenes =new ArrayList<Imagen>();
  for (int i=0;i<files.length;i++) {
    porcentaje_carga = i*1.0/files.length;
    String nombre = files[i].getName();
    String formato = "";
    println(nombre + " " +files[i].getAbsolutePath());
    if (nombre.length() >= 3) {
      formato = nombre.substring(nombre.length()-3, nombre.length());
    }
    if (formato.equals("png")) {
      imagenes.add(new Imagen(loadImage(files[i].getName())));
    };
  }
  cargando = false;
  f = new PFrame();
}

File[] listFiles(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    File[] files = file.listFiles();
    return files;
  } 
  else {
    return null;
  }
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
    background(0);
    Imagen img = imagenes.get(((numero%10)*10+numero/10)%imagenes.size());
    img.act(this);
  }
}

class Imagen {
  ArrayList<PImage> frames;
  boolean animar, movimientoHorizontal, movimientoVertical, continuo;
  float x, y, w, h, escala, vel;
  int frame = 0;
  Imagen(PImage img) {
    frames = new ArrayList<PImage>();
    frames.add(img);
    x = 0;
    y = 0;
    w = img.width;
    h = img.height;
    animar = false;
    continuo = false;
    vel = 0.2;
    frame = 0;
    if (w/2 > h) {
      movimientoHorizontal = true;
    }
    else {
      movimientoHorizontal = false;
    }
    if (h > w*1.5) {
      movimientoHorizontal = false;
    }
    else {
      movimientoVertical = false;
    }   
    escala = 2;
  }
  void act(PApplet p) {
    frame++;
    frame = frame%frames.size();
    if (w/p.width > h/p.height) {
      escala = p.height/h;
    }
    else {
      escala = p.width/w;
    }
    dibujar(p);
  }

  void dibujar(PApplet p) {
    p.image(frames.get(frame), x, y, w*escala, h*escala);
  }
  PImage getFrame() {
    return frames.get(frame);
  }
}
