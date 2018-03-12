PImage map; 

void setup() {
  size(400, 400);
  map = noiseImagen(width, height, 0, 4);
}

void draw() {
  image(map,0,0); 
}

void keyPressed(){ 
  map = noiseImagen(width, height, int(random(5)), 4);
}

PImage noiseImagen(int w, int h, long seed, float es) {
  float increment = es/10;
  PImage aux = createImage(w, h, RGB);
  aux.loadPixels();
  float xoff = 0.0;
  float detail = 0.5;
  noiseSeed(seed);
  noiseDetail(16, detail);
  for (int x = 0; x < w; x++) {
    xoff += increment;
    float yoff = 0.0;
    for (int y = 0; y < h; y++) {
      yoff += increment;
      float bright = noise(xoff, yoff) * 255;
      aux.pixels[x+y*w] = color(bright);
    }
  }
  aux.updatePixels();
  return aux;
}

/*
PImage (){
   noiseImagen 
}
*/
