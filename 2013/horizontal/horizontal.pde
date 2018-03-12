PImage img, ret;

void setup() {
  img = loadImage("anu.jpg");
  size(img.width, img.height);
  ret = retocar(img);
  background(0);
}

void draw() {
  ret = retocar(img);
  image(ret, 0, 0);
  if (frameCount < 10) {
    saveFrame("anu/anu_00"+frameCount+".png");
  }
  else if (frameCount < 100) {
    saveFrame("anu/anu_0"+frameCount+".png");
  }
  else {
    saveFrame("anu/anu_"+frameCount+".png");
  }
  if (frameCount > 30*30) {
    exit();
  }
}

void keyPressed() {
  if (key == 's') {
    saveFrame("vilma_"+hour()+"_"+minute()+"_"+second()+".png");
  }
}
PImage retocar(PImage img) {
  PImage aux = createImage(width, height, ARGB);
  float yoff = 0;
  float mov = noise(frameCount/50.)*height;
  if (abs(mov-height/2)<2) {
    //print("cambio");
    //noiseSeed((long)random(10));
  }
  float max = map(mov, 0, height, -2000, 2000);
  aux.loadPixels();
  for (int i = 0; i < width; i++) {
    yoff += .01;
    float xoff = 0;
    int ydes = int(noise(yoff)*max-max/2);
    for (int j = 0; j < height; j++) {
      xoff += .01;
      int xdes = int(noise(xoff)*max-max/2);
      if (j+ydes >= 0 && j+ydes < height && i+xdes >= 0 && i+xdes < width) { 
        aux.set(i, j, img.get(i+xdes, j+ydes));
      }
    }
  }
  aux.updatePixels();
  return aux;
}

