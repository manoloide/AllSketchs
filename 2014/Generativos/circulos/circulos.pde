color paleta[];
PImage fondo;
void setup() {
  size(600, 800);
  /*
    paleta = new color[5];
   paleta[0] = color(#EA846B);
   paleta[1] = color(#BB3311);
   paleta[2] = color(#B7AEAC);
   paleta[3] = color(#F8CF30);
   paleta[4] = color(#44B6BE);
   */
  paleta = new color[4];
  paleta[0] = color(#F73F09);
  paleta[1] = color(#004D51);
  paleta[2] = color(#008280);
  paleta[3] = color(#00B9B5);
  generar();
}

void draw() {
}

void keyPressed(){
   if(key == 's'){
      saveFrame("#####");
   } 
   if(key == 'g'){
      generar(); 
   }
}

void generar() {
  fondo = crearTexturilla(width, height, paleta[2]);//#EBEAE1);
  image(fondo, 0, 0);
  for (int j = 0; j < 4; j++) {
    for (int i = 0; i < 3; i++) {
      PImage aux = crearCuadrito(160, 160);
      stroke(0, 12);
      noFill();
      rect(40.5+i*180, 40.5+j*180, 160, 160);
      image(aux, 40+i*180, 40+j*180);
    }
  }
  noFill();
}

PImage crearTexturilla(int w, int h, color col) {
  PImage aux = createImage(w, h, RGB);
  aux.loadPixels();
  for (int i = 0; i < aux.pixels.length; i++) {
    color c = lerpColor(col, color(random(80, 256)), 0.03);
    aux.set(i%w, i/w, c);
  }
  return aux;
}


PImage crearCuadrito(int w, int h) {
  PImage f = crearTexturilla(w, h, #F2F2EB);
  PGraphics aux = createGraphics(w, h);
  float ang, dist, tam;
  aux.beginDraw();
  aux.smooth();
  aux.image(f, 0, 0);
  aux.noStroke();
  for (int i = 0; i < 22; i++) {
    tam = random(0.5, 2);
    aux.fill(paleta[int(random(paleta.length))]);
    aux.ellipse(random(w), random(h), tam, tam);
  }
  aux.noFill();
  for (int i = 0; i < 8; i++) {
    ang = random(TWO_PI);
    dist = random(30, 120);
    tam = random(30, 160);
    aux.strokeWeight(random(3, 8));
    aux.stroke(paleta[int(random(paleta.length))]);
    aux.ellipse(80+cos(ang)*dist, 80+sin(ang)*dist, tam, tam);
  }
  aux.endDraw();
  return aux;
}
