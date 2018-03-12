int cant; //<>//

int paleta[] = {
  #422C24, 
  #CD366B, 
  #FC4B4B, 
  #F1AD3A, 
  #BCF02F
};
/*
int paleta[] = {
  #1F1551, 
  #1C101E, 
  #301F4B, 
  #5B4F7D, 
  #C67327
};*/
PImage edificios[];

void setup() {
  size(800, 800);
  File f = new File(sketchPath+"/../edificios");
  File lista[] = f.listFiles();
  int cant = lista.length;
  edificios = new PImage[cant];
  for (int i = 0; i < cant; i++) {
    edificios[i] = loadImage(lista[i].getAbsolutePath());
  }
  generar();
}  
void draw() {
}
void keyPressed() {
  if (key == 's') saveImage();
  else thread("generar");
}
void generar() {
  int col = rcol();
  for (int i = 0; i < 10; i++) {
    PImage img = edificios[int(random(cant))];
    float x = random(width); 
    float y = random(height);
    float es = random(0.01, 1);

    tint(col, random(20, 256));
    image(img, x-img.width/2, y-img.height/2, img.width*es, img.height*es);
    //noiseee(random(-5, 8));
  }
  strokeCap(SQUARE);
  stroke(col);
  float des = random(2, 30);
  int cc = int(random(width));
  strokeWeight(random(1,3));
  for(float i = -des; i < cc; i+=des){
    line(i, -2, -2, i);
  }
  for(int i = 0; i < 100; i++){
     float tt = random(2, 10);
     float x = random(width);
     float y = random(height);
     strokeWeight(tt*random(0.4,0.8));
     line(x-tt, y-tt, x+tt, y+tt);
     line(x-tt, y+tt, x+tt, y-tt);
  }
  for (int i = 0; i < 5; i++) {
    float x = random(width); 
    float y = random(height);
    float es = random(0.01, 1);
    PImage img = edificios[int(random(cant))];

    tint(col, random(20, 256));
    image(img, x-img.width/2, y-img.height/2, img.width*es, img.height*es);
    //noiseee(random(-5, 8));
  }
}
void noiseee(float cc) {
  for (int j = 0; j < height; j++) { 
    for (int i = 0; i < width; i++) {
      color col = get(i, j);
      float bri = random(cc);
      set(i, j, color(red(col)+bri, green(col)+bri, blue(col)+bri));
    }
  }
}
void saveImage() {
  int n = new File(sketchPath).listFiles().length-1;
  saveFrame(n+".png");
}
int rcol() {
  return paleta[int(random(paleta.length))];
}
