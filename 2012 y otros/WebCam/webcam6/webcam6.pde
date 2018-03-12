import codeanticode.gsvideo.*;

GSCapture video;
PImage anterior;
boolean mirror;
ArrayList posBurbujas;
ArrayList bubblesStep;
int tamBur;
int maxBurbujas;
int maxBubbleStep;
float explosionThreshold;
PImage imagen;

void setup() { 
  size(640, 480);
  frameRate(10);
  //video
  video = new GSCapture(this, width, height);
  video.start();
  //fotogramas
  anterior = createImage(video.width, video.height, RGB);
  mirror = true;
  posBurbujas = new ArrayList();
  bubblesStep = new ArrayList();
  tamBur = 100;
  maxBurbujas = 30;
  maxBubbleStep = 8;
  explosionThreshold = 10;
  //image
  imagen = loadImage("bubble.png");
}

void stop() {
  video.stop();
  super.stop();
}

void draw() {
  PImage movimiento = procesarMoviemiento();  

  background(movimiento);
  background((mirror) ? mirrorImage(video) : video);

  if (movimiento != null) {
    crearBurbujas();
    chequearExplocion(movimiento);
  }
  dibujarBurbujas();
  moverBurbujas();
}

void moverBurbujas() {
  for (int i=0; i<posBurbujas.size(); i++) {
    // posicion actual cordenada
    PVector bPos = (PVector)posBurbujas.get(i);
    //
    PVector bStp = (PVector)bubblesStep.get(i);
    //sumar posicion y
    bPos.y += bStp.y;
  }
}

void dibujarBurbujas() {
  for (int i=0; i<posBurbujas.size(); i++) {
    //posision burbujas...
    PVector bPos = (PVector)posBurbujas.get(i);
    //dibuja la imagen
    image(imagen, bPos.x, bPos.y, tamBur, tamBur);
  }
}

void chequearExplocion(PImage movimiento) {
  for (int i=0; i<posBurbujas.size(); i++) {
    PVector bPos = (PVector)posBurbujas.get(i);
    int amount = comprobarExplocion(movimiento, bPos, tamBur);
    // Explode the current bubble according the explosion threshold
    // or if it has fallen out of the window
    if (amount >= tamBur * tamBur * explosionThreshold / 100 || bPos.y > movimiento.height) {
      // Explode a bubble consists in remove it's location
      posBurbujas.remove(i);
      // And remove it's step value
      bubblesStep.remove(i);
      // Update the index to consider the "next" bubble
      i --;
    }
  }
}

int comprobarExplocion(PImage movimiento, PVector location, int size) {
  // contador de pixeles con movimiento
  int contador = 0;
  // puntos de origen del area 
  int x = int(location.x);
  int y = int(location.y);
  // recorre los pixieles del area
  for (int px=x; px<x+size; px++) {
    for (int py=y; py<y+size; py++) {
      if (px < movimiento.width && px > 0 && py < movimiento.height && py > 0) {
        // si la hay movimiento incrementa
        if (brightness(movimiento.get(px, py)) > 127)
          contador++;
      }
    }
  }
  return contador;
}

void crearBurbujas() {
  // si pasa el maximo no hace nada
  if (posBurbujas.size() == maxBurbujas)
    return;

  PVector bPos = new PVector();
  //setear la pos
  bPos.x = random(0, video.width - tamBur);
  bPos.y = 0;
  // Create a new step storage for the new bubble
  PVector bStp = new PVector();
  // Set the random step size for the new bubble
  bStp.x = 0;
  bStp.y = random(1, maxBubbleStep);
  // Add the new bubble's location
  posBurbujas.add(bPos);
  // Add the new bubble's step size
  bubblesStep.add(bStp);
}

PImage procesarMoviemiento() {
  //iamgen para guardar el movimiento
  PImage movimiento = null;
  //se fija si la camara esta disponible
  if (video.available()) {
    //lee la camara
    video.read();
    //compara el fotograma anterior con el actual
    movimiento = conseguirMovimiento(video, anterior, mirror);
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
      float diff = dist(red  (current), green(current), blue (current),red  (previous),green(previous),blue (previous));
      //cambiar el color a blanco y negro
      movimiento.pixels[indexTarget] = (diff > 50) ? color(255) : color(0);
    }
  }
  //guarda anterior
  anterior.copy(actual, 0, 0, video.width, video.height, 0, 0, video.width, video.height);
  anterior.updatePixels();
  
  return movimiento;
}

PImage mirrorImage (PImage source) {
  // Create new storage for the result RGB image
  PImage response = createImage(source.width, source.height, RGB);
  // Load the pixels data from the source and destination images
  source.loadPixels();
  response.loadPixels();
  // Walk thru each pixel of the source image
  for (int x=0; x<source.width; x++) {
    for (int y=0; y<source.height; y++) {
      // Calculate the inverted X (loc) for the current X
      int loc = (source.width - x - 1) + y * source.width;
      // Get the color (brightness for B/W images) for
      // the inverted-X pixel
      color c = source.pixels[loc];
      // Store the inverted-X pixel color information
      // on the destination image
      response.pixels[x + y * source.width] = c;
    }
  }
  // Return the result image with the pixels inverted
  // over the x axis
  return response;
}

