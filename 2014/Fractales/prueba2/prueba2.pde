color paleta[];  //<>//

int tri_alp = 40; 
int cant_cir = 4;
boolean lineas = true;
int lineas_alp = 40;
int alp_stroke_cir = 80;
int circulos_alp = 30;

boolean save = true;

void setup() {
  size(600, 800);
  paleta  = new color[5];
  paleta[0] = color(#FBE085);
  paleta[1] = color(#F87970);
  paleta[2] = color(#B1185B);
  paleta[3] = color(#8F2C6F);
  paleta[4] = color(#1D717B);
  background(0);
  noStroke();
  noStroke();
  for (int i = 0; i < 100000; i++) {
    fill(paleta[int(random(5))], tri_alp);
    triangle(random(width), random(height), random(5, 20), random(TWO_PI));
  }
  stroke(255, alp_stroke_cir);
  noFill();
  crearCirculo(random(width/2)+width/4, random(height/2)+height/4, height*2, cant_cir);

  strokeWeight(1.5);
  stroke(255, 20);
  noStroke();
  if (lineas) {
    for (int i = 2; i < height*2; i+=15) {
      fill(paleta[int(random(5))], lineas_alp);
      beginShape();
      vertex(-15, i);
      vertex( i, -15);
      vertex( i-15, -15);
      vertex(-15, i-15);
      endShape(CLOSE);
    }
  }
  if(save) saveFrame("f_"+random(100));
}

void crearCirculo(float x, float y, float d, float n) {
  //strokeWeight(d/600);
  fill(paleta[int(random(5))], circulos_alp);
  line(x, y-d/20, x, y+d/20);
  line(x-d/20, y, x+d/20, y);
  ellipse(x, y, d, d);
  n--;
  if (n > 0) {
    int cant = int(random(3, 8));
    float da = TWO_PI/cant;
    beginShape();
    for (int i = 0; i < cant; i++) {
      float ax = x+cos(da*i)*d/4; 
      float ay = y+sin(da*i)*d/4;
      vertex(ax, ay);
      crearCirculo(ax, ay, d/2, n);
    }
    endShape(CLOSE);
  }
}

void triangle(float x, float y, float dim, float ang) {
  float da = TWO_PI/3;
  beginShape();
  for (int i = 0; i < 3; i++) {
    vertex(x+cos(da*i+ang)*dim/2, y+sin(da*i+ang)*dim/2);
  }
  endShape(CLOSE);
}
