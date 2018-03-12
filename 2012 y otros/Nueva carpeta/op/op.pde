/////////////////////////
// Gamboa Naon, Manuel //
// Nº alumno: 65518/0  //
// manoloide@gmail.com //
/////////////////////////

int tam = 10;
int difY = 50;
float angulos[];
int h, s, b;

void setup() {
  size(600, 600);
  //smooth();
  frameRate(30);
  noStroke();
  colorMode(HSB);

  angulos = new float[5];
  for (int i = 0; i < 5; i++) {
    angulos[i] = random(TWO_PI);
  }
}

void draw() {
  h += 3;
  h %= 256;
  s += 1;
  s %= 256;
  b += 1;
  b %= 256;
  background(0);
  difY = (int) map(mouseY, 0, height, -50, 50);
  for (int i = 0; i < 10; i++) {
    int dify;
    if (i%2 == 0) {
      dify = -difY;
      angulos[int(i/2)] += random(0.3, 1.5);
    }
    else {
      dify = difY;
    }
    for (int j = -10; j < height/tam+10; j++) {
      int d1, d2;
      if (j%2 == 0) {
        fill(0);
      }
      else {
        fill(255);
      }
      if (i%2 == 0) {
        d1 = 0;
        d2 = 1;
      }
      else {
        d1 = 1;
        d2 = 0;
      }
      float ang = angulos[int(i/2.0)];
      int amplitud = 15;
      float periodo = 8;
      beginShape();
      vertex(i*60+cos((ang+j)/periodo)*d1*amplitud, j*tam+dify);   
      vertex(i*60+cos((ang+j+1)/periodo)*d1*amplitud, (j+1)*tam+dify); 
      vertex((i+1)*60+cos((ang+j+1)/periodo)*d2*amplitud, (j+1)*tam-dify);  
      vertex((i+1)*60+cos((ang+j)/periodo)*d2*amplitud, j*tam-dify);    
      endShape(CLOSE);
    }
  }
}

void mousePressed(){
  h = int(random(256));
  s = int(random(256));
  b = int(random(256));
}

