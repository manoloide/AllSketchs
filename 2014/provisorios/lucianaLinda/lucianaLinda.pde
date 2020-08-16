import manoloide.Color.Paleta;
import manoloide.Gui.*;
import manoloide.Input.*;
import peasy.*;

Gui gui;
Input input;
PeasyCam camera;
PImage img;
Window window;
void setup() {
  size(800, 600, P3D);
  camera = new PeasyCam(this, 1000);
  frame.setResizable(true);
  img = loadImage("image.jpg");
  textFont(loadFont("HelveticaNeue-Bold-12.vlw"));
  input = new Input(this);
  gui = new Gui(this);
  gui.paleta = new Paleta(color(240, 120), color(2, 200));
  window = new Window("Opciones", width-230, 10, 220, 200);
  gui.add(window);
  window.add(new ButtonLabel("Abrir", 10, 10, 50, 20));
  window.add(new ButtonLabel("Guardar", 70, 10, 50, 20));
  window.add(new ToggleLabel("Ver Imagen", 130, 10, 80, 20, true));
  window.add(new Slider("Profundidad", 10, 50, 200, 10, 0, 200, 20));
  window.add(new Slider("Detalle", 10, 80, 200, 10, 1, 50, 20));
}

void draw() {
  gui.update();
  if (((ButtonLabel)(window.get("Abrir"))).click) {
    selectInput("Seleciona la imagen", "abrirImagen");
  }
  background(0);
  translate(-img.width/2, -img.height/2);
  if (((ToggleLabel)(window.get("Ver Imagen"))).val) {
    image(img, 0, 0);
  }
  int det = (((Slider)(window.get("Detalle"))).getInt());
  float pro = ((Slider)(window.get("Profundidad"))).getFloat();
  for (int j = (img.height%det)/2; j < img.height; j+=det) {
    for (int i = (img.width%det)/2; i < img.width; i+=det) {
      stroke(img.get(i, j));
      float p = (brightness(img.get(i, j))/256) * pro;
      point(i, j, p);
    }
  }
  
  if (((ButtonLabel)(window.get("Guardar"))).click) {
    selectOutput("Seleciona la carpeta", "guardarImagen", new File("img.png"));
  }
  camera.beginHUD();
  gui.draw();
  camera.endHUD();
  input.update();
}

void abrirImagen(File selection) {
  if (selection != null) {
    img = loadImage(selection.getAbsolutePath());
  }
}

void guardarImagen(File selection){
  if (selection != null) {
    save(selection.getAbsolutePath());
  }
}
