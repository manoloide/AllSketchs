/*
color paleta[] = {
 #340500, #F5C6B6, #E1ECC2, #A87059, #E6C4A8
 };
 */
color paleta[] = {
  #EE84D5, #FFC54A, #65B4EC, #F8F161, #D33C63
};

color col;

void setup() {
  size(800, 200); 
  generar();
}

void draw() {
}

void keyPressed() {
  generar();
}

void generar() {
  col = color(random(256),random(256),random(256));//rcol();
  lineasFondo();
  nnois(10);
  cruces(int(random(90)), random(4, 18), random(0.2, 1));
  color c1 = hue(sat(bri(col, random(-30, -30)), random(-40,40)), random(-5, 5));
  color c2 = hue(sat(bri(col, random(-30, -30)), random(-40,40)), random(-5,5));
  degrade(c1, c2, random(0.1, 0.6));
  noStroke();
  int cc = int(random(-3, 8));
  for(int i = 0; i < cc; i++){
      cono(random(width), random(height), random(width*0.03, width*0.2), int(random(10, 100)), random(TWO_PI), random(1), col);
  }
  cono(width/2, height/2, random(width*0.2, width*0.6), int(random(10, 100)), random(TWO_PI), random(1), col);
  
  nnois(10);
}

void cruces(int cant, float tam, float def) {
  for (int i = 0; i < cant; i++) {
    float x = random(width);
    float y = random(height);
    float tt = tam*random(def, 1);
    float st = random(0.05, 0.2);
    float ang = random(TWO_PI);
    fill(bri(sat(col, random(10, 30)), random(50)), random(180, 256));
    cruz(x, y, tt, st, ang);
  }
}

void cruz(float x, float y, float dim, float hun, float ang) {
  float r = dim/2;
  float h = r*hun; 
  pushMatrix();
  translate(x, y);
  x = 0; 
  y = 0;
  rotate(ang);
  beginShape();
  float da = TWO_PI/4;
  vertex(x+h, y+h);
  vertex(x+r, y+h);
  vertex(x+r, y-h);
  vertex(x+h, y-h);
  vertex(x+h, y-r);
  vertex(x-h, y-r);
  vertex(x-h, y-h);
  vertex(x-r, y-h);
  vertex(x-r, y+h);
  vertex(x-h, y+h);
  vertex(x-h, y+r);
  vertex(x+h, y+r);

  endShape(CLOSE);
  popMatrix();
}

void cono(float x, float y, float dim, int cant, float ang, float des, color col) {
  float dc = dim/cant;
  float r = dim/2;
  for (int i = 0; i < cant; i++) {
    fill(sat(bri(col, random(-20, 20)), random(10)));
    float tt = dim - dc * i;
    float dd = map(i, 0, cant, 0, des);
    float dx = cos(ang)*dd*r;
    float dy = sin(ang)*dd*r;
    ellipse(x+dx, y+dy, tt, tt);
  }
}

void nnois(float noi) {
  for (int j = 0; j < height; j++) {
    for (int i = 0; i < width; i++) {
      set(i, j, sat(get(i, j), random(-noi, noi)));
    }
  }
}

void degrade(color c1, color c2, float alp) {
  for (int i = 0; i < height; i++) {
    stroke(lerpColor(c1, c2, i/height), 256*alp);
    line(0, i, width, i);
  }
}

void lineasFondo() {
  pushMatrix();
  translate(width/2, height/2);
  rotate(random(TWO_PI));
  float diag = dist(0, 0, width, height);
  float des = -diag/2;
  noStroke();
  while (des < diag/2) {
    fill(bri(col, random(-40, 40)));
    float tt = random(20, 200);
    rect(-diag/2, des, diag, tt+1);
    des += tt;
  }
  popMatrix();
}
color rcol() {
  return paleta[int(random(paleta.length))];
}

color hue(color c, float cant) {
  pushStyle(); 
  colorMode(HSB);
  color aux = color(hue(c)+cant, saturation(c), brightness(c));
  popStyle();
  return aux;
}

color sat(color c, float cant) {
  pushStyle(); 
  colorMode(HSB);
  color aux = color(hue(c), saturation(c)+cant, brightness(c));
  popStyle();
  return aux;
}

color bri(color c, float cant) {
  pushStyle(); 
  colorMode(HSB);
  color aux = color(hue(c), saturation(c), brightness(c)+cant);
  popStyle();
  return aux;
}
