float tam, bor, cw, ch, dx, dy;
PImage img;
String src = "https://scontent-b-mia.xx.fbcdn.net/hphotos-xpf1/v/t1.0-9/10629670_10204046101146672_1366216247493594698_n.jpg?oh=e6c98d4af9b15fcd3657ee713b214721&oe=54872C65";
void setup() {
  img = loadImage(src);
  size(img.width, img.height);
  generar();
}

void draw() {
  dibujarObra();
}

void keyPressed() {
  if (key == 's') saveImage();
  else generar();
}

void generar() {
  background(80);
  tam = int(random(1, 40));
  bor = 0;//random(tam*0.1);
  cw = int(width/(tam+bor));
  ch = int(height/(tam+bor));
  dx = (width-tam*cw-bor*(cw-1))/2;
  dy = (height-tam*ch-bor*(ch-1))/2;
  dibujarObra();
}

void dibujarObra(){
  float det = frameCount*0.005;
   for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      float x1 = dx+i*(tam+bor);
      float y1 = dy+j*(tam+bor);
      float x2 = dx+i*(tam+bor)+tam;
      float y2 = dy+j*(tam+bor)+tam;
      float cx = x1 + noise(i+det,j+det)*tam;
      float cy = y1 + noise(i+det+10,j+det+10)*tam;;
      //ellipse(cx, cy, 4, 4);
      color col = img.get(int(cx), int(cy));
      noStroke();
      fill(bri(col,15));
      rect(dx+i*(tam+bor), dy+j*(tam+bor), tam, tam);
      triangle(x1, y1, x1, y2, cx, cy);
      fill(col);
      triangle(x1, y2, x2, y2, cx, cy);
      fill(bri(col,-15));
      triangle(x2, y2, x2, y1, cx, cy);
      fill(bri(col,30));
      triangle(x2, y1, x1, y1, cx, cy);
    }
  }
  noiseee(); 
}

color bri(color c, int osc) {
  pushStyle();
  colorMode(HSB, 256, 256, 256, 256);
  color a = color(hue(c), saturation(c), brightness(c)+osc);
  popStyle();
  return a;
}
void noiseee(){
   for(int j = 0; j < height; j++){
      for(int i = 0; i < width; i++){
         color col = get(i, j);
         float bri = random(8);
        set(i, j,color(red(col)+bri, green(col)+bri, blue(col)+bri)); 
      }
   } 
}
void saveImage() {
  int c = (new File(sketchPath)).listFiles().length-1;
  saveFrame(c+".png");
}
