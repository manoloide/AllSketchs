color Paleta[];

void setup() {
  size(600, 800);
  smooth(4);
  Paleta = new color[4];
  Paleta[0] = color(#2F2C3B);
  Paleta[1] = color(#F57281);
  Paleta[2] = color(#EAEAEA);
  Paleta[3] = color(#EAEAEA);
  thread("generar");
}
void draw() {
}

void keyPressed( ) {
  if (key == 's') {
    saveFrame("####");
    return;
  }
  thread("generar");
}

void generar() {
  int c = int(random(2));
  background(Paleta[c]);
  noStroke();

  fill(Paleta[2], 1);
  if (true) {
    for (int i = 0; i < 200000; i++) {
      float x = random(width);
      float y = random(height);
      float tam = map(y, 0, height, 1, 3);
      ellipse(x, y, tam, tam);
    }
  }
  fill(Paleta[c], 20);
  rect(0, 0, width, height);
  println("listo");
  int bordes = 20;
  noFill();
  int cant = 3;
  int des = 6;
  strokeWeight(0.5);
  for (int i = 0; i < cant; i++) {
    float x = bordes+(cant-i)*des;
    float y = bordes+i*des;
    float w = width-(bordes+(cant-i)*des)*2;
    float h = height-(bordes+i*des)*2;
    stroke(Paleta[2], 40);
    rect(x-1, y-1, w, h);
    stroke(Paleta[1-c%2], 240);
    rect(x, y, w, h);
  }
  int cw = int(random(1, 7));
  int ch = int(random(1, 7));
  float dim = (width-180)/cw;
  if (cw/width > ch/height)
    dim = (height-180)/ch;
    
  for (int jj = 0; jj < ch; jj++) {
    for (int ii = 0; ii < cw; ii++) {
      strokeWeight(0.5);
      noFill();
      stroke(Paleta[2],40);
      float x = width/2+dim*(ii-cw/2.+0.5);
      float y = height/2+dim*(jj-ch/2.+0.5);
      //ellipse(x, y, dim, dim);
      cant = int(random(1,5));
      for (int j = -cant/2; j < cant/2+cant%2; j++) {
        for (int i = -cant/2; i < cant/2+cant%2; i++) {
          float tam = dim/cant;
          float dd = 0;
          if (cant%2 == 0) dd = tam/2;
          float xx = x+(i-j)*tam/2;
          float yy = y+(i+j)*tam/2+dd;
          //rector(xx, yy, tam, 0);
        }
      }
      noStroke();
      for (int j = -cant/2; j < cant/2+cant%2; j++) {
        for (int i = -cant/2; i < cant/2+cant%2; i++) {
          float tam = dim/cant;
          float dd = 0;
          if (cant%2 == 0) dd = tam/2;
          float xx = x+(i-j)*tam/2;
          float yy = y+(i+j)*tam/2+dd;
          for (int k = 0; k < 4; k++) {
            int cc = int(random(4));
            fill(Paleta[cc], 200);
            stroke(Paleta[cc], 200);
            figura(xx, yy, tam, 0);
          }
        }
      }
    }
  }
  noStroke();
  if (true) {
    for (int i = 0; i < 2000; i++) {
      float x = random(width);
      float y = random(height);
      float tam = map(y, 0, height, 1, 3);
      fill(Paleta[int(random(4))], random(1, 20));
      ellipse(x, y, tam, tam);
    }
  }
}

void rector(float x, float y, float tam, int cant) {
  beginShape();
  float ang = PI/2;
  for (int i = 0; i < 4; i++) {
    vertex(x+cos(ang*i)*tam/2, y+sin(ang*i)*tam/2);
  } 
  endShape(CLOSE);
}
void figura(float x, float y, float tam, int cant) {
  beginShape();
  float ang = PI/2;
  int da = int(random(4));
  int c = 2+int(random(4));
  if(c == 2) return;
  for (int i = 0; i < c; i++) {
    if (i == 4) {
      vertex(x, y);
      continue;
    }
    vertex(x+cos(ang*(da+i))*tam/2, y+sin(ang*(da+i))*tam/2);
  } 
  endShape(CLOSE);
}
