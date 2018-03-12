import processing.video.*;

final int borrar = 32;
final int agregar = 64;
final int umbral = 50;

Capture video;
PImage anterior, est, ant;
boolean invertir;

void setup() { 
  size(640, 480);
  frameRate(10);
  //video
  video = new Capture(this, width, height);
  //fotogramas
  anterior = createImage(video.width, video.height, RGB);
  est = createImage(video.width, video.height, ARGB);
  ant = createImage(video.width, video.height, ARGB);
  //lenar matriz de intensidad
  for (int j = 0; j < height; j++) {
    for (int i = 0; i < width; i++) {
      est.set(i, j, color(0, 0));
    }
  }
  // espejar imagen.
  invertir = true;
}

void stop() {
  video.stop();
  super.stop();
}

void draw() {
  //PImage movimiento = procesarMoviemiento();
  PImage movimiento = procesarMoviemiento();  
  //background(movimiento);
  background(blancoNegro(invertirImagen(video)));
  image(est, 0, 0);
  println(frameRate);
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
  actual.copy(video, 0, 0, video.width, video.height, 0, 0, video.width, video.height);
  PImage movimiento = createImage(video.width, video.height, RGB);
  actual.loadPixels();
  anterior.loadPixels();
  ant.loadPixels();
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
      if (diff > umbral) {
        color actu = color(red(current),green(current),blue(current),agregar);
        color nuevo = blendColor(est.get(x, y), actu, OVERLAY);
        est.set(x, y, current);
      }
      else {
        color ante = est.get(x, y);
        if (alpha(ante) > 0) {
          ante = color(red(ante), green(ante), blue(ante), alpha(ante)-borrar);
          
          est.set(x, y, ante);
        }
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

PImage blancoNegro(PImage original) {
  original.loadPixels(); 
  for (int y = 0; y < original.height; y++) {
    for (int x = 0; x < original.width; x++) {
      color actual = original.pixels[x + y * original.width];
      original.pixels[x + y * original.width] = color((red(actual)+green(actual)+blue(actual))/3);
    }
  }
  return original;
}

