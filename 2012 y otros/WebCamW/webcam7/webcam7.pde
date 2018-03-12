import processing.video.*;

Capture video;
PImage anterior, est;
boolean invertir;
int estela[][];
int col = 0;

void setup() { 
  size(640, 480);
  frameRate(30);
  colorMode(HSB);
  //video
  String[] cameras = Capture.list();
  video = new Capture(this, cameras[1]);
  video.start();
  //fotogramas
  anterior = createImage(width, height, RGB);
  est = createImage(width, height, ARGB);
  estela = estela = new int[width][height];
  //lenar matriz de intensidad
  for (int j = 0; j < height; j++) {
    for (int i = 0; i < width; i++) {
      estela[i][j] = 0;
      est.set(i, j, color(0, 0));
    }
  }
  // espejar imagen.
  invertir = false;
}

void stop() {
  video.stop();
  super.stop();
}

void draw() {
  frame.setTitle("FPS "+frameRate);
  PImage movimiento = procesarMoviemiento();  
  //background(movimiento);
  if (movimiento != null) {
    background(video);
  }

  for (int j = 0; j < height; j++) {
    for (int i = 0; i < width; i++) {
      est.set(i, j, color(col, 255, 255, estela[i][j]));
    }
  }
  image(est, 0, 0);

  col++;
  col = col%256;
}


PImage procesarMoviemiento() {
  //iamgen para guardar el movimiento
  PImage movimiento = null;
  //se fija si la camara esta disponible
  if (video.available()) {
    //lee la camara
    video.read();
    //compara el fotograma anterior con el actual
    movimiento = conseguirMovimiento(video, anterior, invertir);
  }
  //devolver la imagen con el movimiento en byn
  return movimiento;
}

PImage conseguirMovimiento(PImage video, PImage anterior, boolean mirror) {
  //imagen acual 
  PImage actual = createImage(video.width, video.height, RGB);
  // Create a copy of the current image to create the movement image
  // and not alter the displayed image
  actual.copy(video, 0, 0, video.width, video.height, 0, 0, video.width, video.height);
  //crea una imagen para uardar el movimiento
  PImage movimiento = createImage(video.width, video.height, RGB);
  //carga los pixeles
  actual.loadPixels();
  anterior.loadPixels();
  //recorre la imagen
  for (int x = 0; x < actual.width; x++) {
    for (int y = 0; y< actual.height; y++) {
      int index = x + y * actual.width;
      int indexTarget = index;
      if (mirror)
        index = (actual.width - x - 1) + y * actual.width;
      //guarda los colores de los pixiles
      color current  = actual.pixels[index];
      color previous = anterior.pixels[index];
      //calcuala de distancia de colores 
      float diff = dist(red  (current), green(current), blue (current), red  (previous), green(previous), blue (previous));
      //cambiar el color a blanco y negro
      movimiento.pixels[indexTarget] = (diff > 50) ? color(255) : color(0);
      if (diff > 50) {
        if (estela[x][y]<256) {
          estela[x][y]+=32;
        }
      }
      else if (estela[x][y]>0) {
        estela[x][y]-=8;
      }
    }
  }
  //guarda anterior
  anterior.copy(actual, 0, 0, video.width, video.height, 0, 0, video.width, video.height);
  anterior.updatePixels();

  return movimiento;
}

PImage invertirImagen (PImage original) {
  PImage invertida = createImage(original.width, original.height, RGB);
  original.loadPixels();
  invertida.loadPixels();
  for (int x=0; x<original.width; x++) {
    for (int y=0; y<original.height; y++) {
      int loc = (original.width - x - 1) + y * original.width;
      color c = original.pixels[loc];
      invertida.pixels[x + y * original.width] = c;
    }
  }
  return invertida;
}
