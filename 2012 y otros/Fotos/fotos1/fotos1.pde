PImage ori;

void setup() {
  size(600, 600);
  ori = loadImage("../f1.jpg", "png");
  //image(ori, 0, 0);
  
}

void draw(){
  cambio(ori);
}

void cambio(PImage img) {
  color pro;
  PImage rojo = createImage(600, 600, ARGB); 
  PImage verde = createImage(600, 600, ARGB); 
  PImage azul = createImage(600, 600, ARGB); 
  img.loadPixels();
  rojo.loadPixels();
  verde.loadPixels();
  azul.loadPixels();
  for (int i = 0; i < img.width*img.height; i++) {
    pro = img.pixels[i];
    rojo.pixels[i] = color(255, 0, 0, red(pro)/2);
    verde.pixels[i] = color(0, 255, 0, green(pro)/2);
    azul.pixels[i] = color(0, 0, 255, blue(pro)/2);
  }
  img.updatePixels();
  rojo.updatePixels();
  verde.updatePixels();
  azul.updatePixels();
  
  int c = 20;
  image(img, 0, 0);
  image(rojo, (c * mouseX/width) -c/2, (c * mouseY/height) -c/2);
  image(verde, (c * (-1*mouseX + width) /width) -c/2, (c * mouseY/height) -c/2);
  image(azul, (c * mouseX/width) -c/2, (c * (-1*mouseY + height)/height) -c/2);
  
  print((c * (-1*mouseX + width) /width) -c/2);
}

