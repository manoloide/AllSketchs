/*
int paleta[] = {
 #594F4F, 
 #547980, 
 #45ADA8, 
 #9DE0AD, 
 #E5FCC2
 };
 */

int paleta[] = {
  #ECD078, 
  #D95B43, 
  #C02942, 
  #542437, 
  #53777A
};
PFont roboto[];
PShape logo;

void setup() {
  size(1000, 680);
  roboto = new PFont[12];
  roboto[0] = createFont("Roboto Black", 200, true);
  roboto[1] = createFont("Roboto Black Italic", 200, true);
  roboto[2] = createFont("Roboto Bold", 200, true);
  roboto[3] = createFont("Roboto Bold Italic", 200, true);
  roboto[4] = createFont("Roboto Italic", 200, true);
  roboto[5] = createFont("Roboto Light", 200, true);
  roboto[6] = createFont("Roboto Light Italic", 200, true);
  roboto[7] = createFont("Roboto Medium", 200, true);
  roboto[8] = createFont("Roboto Medium Italic", 200, true);
  roboto[9] = createFont("Roboto Regular", 200, true);
  roboto[10] = createFont("Roboto Thin", 200, true);
  roboto[11] = createFont("Roboto Thin Italic", 200, true);
  
  logo = loadShape("logoODDCG.svg");
  //logo.scale(1.4);
  textFont(roboto[0]);
  generar();
}

void draw() {
  //generar();
}

void keyPressed() {
  if (key == 's') saveImage();
  else generar();
}

void generar() {
  //randomSeed(0);
  background(rcol());
  strokeWeight(2);
  stroke(5, 20);
  for (int i = int (random (-10)); i < width+height; i+=4) {
    line(i, -2, -2, i);
  }
  strokeWeight(1);
  stroke(255, 18);
  line(0, 0, width, height);
  line(0, height, width, 0);
  strokeCap(SQUARE);
  for (int i = 0; i < 800; i++) { 
    float x = random(width); 
    float y = random(height); 
    float d = random(2, 8); 
    stroke(rcol());
    strokeWeight(d*random(0.3, 0.5));
    cruz(x, y, d);
  }
  ArrayList<PVector> circulos = new ArrayList<PVector>();
  for (int i = 0; i < 400; i++) {
    float x = random(width); 
    float y = random(height); 
    float d = random(2, 180)*random(1);
    PVector aux = new PVector(x, y, d); 
    boolean agrego = false;
    for (int j = 1; j < circulos.size (); j++) {
      if (aux.z >= circulos.get(j).z) {
        agrego = true;
        circulos.add(j, aux);
        break;
      }
    }
    if (!agrego) circulos.add(aux);
  }
  for (int i = 0; i < circulos.size (); i++) {
    PVector cir = circulos.get(i);
    float x = cir.x; 
    float y = cir.y; 
    float d = cir.z;
    float a = random(TWO_PI);
    float dis = dist(x, y, width/2, height/2);
    d *= 1-(constrain(dis, 0, width)/width)*0.5;
    int col1 = rcol();
    int col2 = rcol();
    while (col1 == col2) col2 = rcol();
    stroke(255, 30);
    strokeWeight(1);
    cruz(x, y, d*random(0.6, 1.08));
    stroke(0, 8); 
    noFill(); 
    for (int j = 5; j >= 1; j--) {
      strokeWeight(j); 
      ellipse(x, y, d, d);
    }
    noStroke(); 
    fill(col1); 
    arc(x, y, d, d, -0.02+a, PI+0.02+a); 
    fill(col2); 
    arc(x, y, d, d, PI+a, TWO_PI+a);
  }

  fill(255, 50);
  rect(0, 0, width, height);


  tint(60, 240);
  image(rectLine(width, 148, 6), 48, 72);
  noTint();
  fill(250);
  textAlign(LEFT, TOP);
  textFont(roboto[2]);
  textSize(80);
  text("P5 Buenos Aires", 58, 60);
  textFont(roboto[6]);
  textSize(58);
  text("segundo encuentro", 58, 138);

  textFont(roboto[4]);
  textSize(28);
  textAlign(RIGHT, TOP);

  charla(width-40, 300, "Colaborando con el proyecto Processing", "por Federico Bond");
  charla(width-40, 394, "Processing aplicado al diseño", "por Manolo Gamboa Naon");

  //tint(60, 80);
  noTint();
  image(rectLine(width, 110, 6), 0, height-110);
  shape(logo, 24, height-logo.height-13);
  textAlign(LEFT, TOP);
  fill(70);
  textFont(roboto[0]);
  textSize(40);
  /*
  textSize(50);
   text("14", 180, height-120);
   text("18hs", 180, height-78);
   textSize(24);
   text("DE", 250, height-112);
   text("NOVIEMBRE", 250, height-92);
   */
   textFont(roboto[7]);
  textSize(32);
  text("14 de noviembre a las 18:30hs en OddCG (Castro 919)", 158, height-100);
  textFont(roboto[6]);
  textSize(22);
  text("Actividad gratuita con incripción en http://www.meetup.com/processingBuenosAires/", 158, height-100+40);

  noFill();
  stroke(250);
  strokeWeight(8);
  rect(0, 0, width, height);
}

void charla(float x, float y, String titulo, String nombre) {
  tint(60, 220);
  textFont(roboto[7]);
  textSize(36);
  int ww = int(textWidth(titulo))+12;
  image(rectLine(ww, 74, 6), x+8-ww, y+4);
  text(titulo, x, y);
  textFont(roboto[9]);
  textSize(24);
  text(nombre, x, y+42);
}

void saveImage() {
  int n = (new File(sketchPath)).listFiles().length-1; 
  saveFrame(nf(n, 4)+".png");
}

void cruz(float x, float y, float dim) {
  float r = dim/2; 
  line(x-r, y-r, x+r, y+r); 
  line(x-r, y+r, x+r, y-r);
}

void poly(float x, float y, float d, int cant, float ang) {
  float r = d/2; 
  float da = TWO_PI/cant; 
  beginShape(); 
  for (int i = 0; i < cant; i++) {
    vertex(x+cos(ang+da*i)*r, y+sin(ang+da*i)*r);
  }
  endShape();
}

int rcol() {
  return paleta[int(random(paleta.length))];
}

PImage rectLine(int w, int h, int es) {
  PGraphics aux = createGraphics(w, h);
  aux.beginDraw();
  aux.background(240);
  aux.stroke(255);
  aux.strokeWeight(es*0.6);
  for (int i = -int (random (es)); i < w+h; i+=es*2) {
    aux.line(i, -2, -2, i);
  }
  aux.endDraw();
  return aux.get();
}
