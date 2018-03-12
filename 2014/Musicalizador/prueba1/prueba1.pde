int nota;
PFont helve;
PImage fondo;
String notas[] = {"C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"};

void setup() {
  size(400, 300);
  helve = createFont("Helvetica Neue Bold", 190, true);
  fondo = crearDe(width, height);
  image(fondo, 0, 0);
  textFont(helve);
  nota = int(random(notas.length));
}

void draw() {
  if(frameCount%10 == 0) frame.setTitle("FPS: "+frameRate);
  if(random(100) < 1)  nota = int(random(notas.length));
  image(pro(fondo, color(90+abs(frameCount%70-35), 255, 255-abs(frameCount%900-450)/5), color(255-abs(frameCount%900-450)/5, 90+abs(frameCount%90-45), 255)), 0, 0);
  stroke(255, 80);
  strokeWeight(2);
  for(int i = 0; i < 100; i++){
    line(-1, i*10, i*10, -1);
  }
  fill(255, 220);
  textAlign(LEFT, TOP);
  textSize(90);
  text(notas[nota], 20, 20);
  textSize(90/4);
  text(notas[nota], 20, 100);
}

PImage crearDe(int w, int h) {
  PImage aux = createImage(w, h, RGB);
  aux.loadPixels();
  for (int j = 0; j < h; j++) {
    for (int i = 0; i < w; i++) {
      int val = int(map(i, 0, w, 0, 128)+map(j, 0, h, 0, 128));
      // if((i+j)%2 == 0) val += 5;
      //else val -= 5;
      if (val < 0) val = 0;
      if (val > 255) val = 255;
      color col = color(val);
      aux.set(i, j, col);
    }
  }
  aux.updatePixels();
  return aux;
}

PImage pro(PImage ori, color c, color c2) {
  color col[] = new color[256];
  for (int i = 0; i < 256; i++) {
    col[i] = lerpColor(c, c2, map(i, 0, 255, 0, 1));
  }
  PImage aux = createImage(ori.width, ori.height, RGB);
  aux.loadPixels();
  for(int i = 0; i < ori.pixels.length; i++){
     aux.pixels[i] = col[int(brightness(ori.pixels[i]))]; 
  }
  aux.updatePixels();
  return aux;
}

