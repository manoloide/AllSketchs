color[] paleta;
Camara camara;
Pilar[][] pilares;

void setup() {
  size(800, 600, P3D);
  frameRate(25);
  textureMode(NORMAL);
  paleta = new color[5];
  paleta[0] = color(#D70052);
  paleta[1] = color(#EDEFE7);
  paleta[2] = color(#3C0A4F);
  paleta[3] = color(#3C0A4F);
  paleta[4] = color(#629D75);
  camara = new Camara();
  pilares = new Pilar[20][20];
  for (int j = 0; j < 20; j++) {
    for (int i = 0; i < 20; i++) {
      pilares[i][j] = new Pilar(i, j);
    }
  }
}

void draw() {
  if (frameCount%10 == 0) frame.setTitle("FPS: "+frameRate);
  background(0);

  if (frameCount%int(random(80, 90)) == 0) {
    float r = random(100);
    if (r < 50) {
      thread("remplazar");
    }
    else if (r < 70) {
      thread("reconstruir");
    }
  }
  camara.act();
  ambientLight(40, 40, 40);
  directionalLight(240, 240, 240, -1, 0, 0);
  directionalLight(160, 160, 160, 1, 0, 0);
  directionalLight(200, 200, 200, 0, 1, 0);
  for (int j = 0; j < 20; j++) {
    for (int i = 0; i < 20; i++) {
      pushMatrix();
      pilares[i][j].act();
      popMatrix();
    }
  }
  //saveFrame("####");
  if(frameCount == 25*90){
     exit(); 
  }
}

void mousePressed() {
  thread("remplazar");
}

void mouseDragged() {
  float rate = 0.01;
  camara.rotx += (pmouseY-mouseY) * rate;
  camara.roty += (mouseX-pmouseX) * rate;
  println(camara.rotx, camara.roty);
}

class Pilar {
  color c1, c2;
  int w, h, d;
  float x, y, z;
  PImage arriba, abajo, costado1, costado2;
  Pilar(float x, float z) {
    this.x = (x-10)*50; 
    this.z = (z-10)*50;
    int tam = int(random(1, 8))*50;
    /*
    colorMode(HSB, 256);
     c1 = color(random(256), random(20, 160), random(100, 256));
     c2 = color(random(256), random(20, 120), random(100, 256));
     colorMode(RGB);
     */
    /*
    c1 = paleta[int(random(5))];
     c2 = paleta[int(random(5))];
     while (c1 == c2) {
     c2 = paleta[int(random(5))];
     }*/
    c1 = color(#FFCB3B);
    c2 = color(#FA2844);
    this.y = -tam/2;
    this.w = 50; 
    this.h = tam; 
    this.d = 50;
    generarCaras();
  }
  Pilar(float x, float y, float z, int w, int h, int d, color c1, color c2) {
    this.x = x; 
    this.y = y; 
    this.z = z; 
    this.w = w; 
    this.h = h;
    this.d = d;
    this.c1 = c1;
    this.c2 = c2;
    generarCaras();
  }
  void act() {
    dibujar();
  }
  void dibujar() {
    translate(x, y, z);
    noStroke();
    beginShape(QUADS);
    texture(costado1);
    int w = this.w/2;
    int h = this.h/2;
    int d = this.d/2;
    vertex(-w, -h, d, 0, 0);
    vertex( w, -h, d, 1, 0);
    vertex( w, h, d, 1, 1);
    vertex(-w, h, d, 0, 1);
    endShape();
    beginShape(QUADS);
    texture(costado1);
    vertex( w, -h, -d, 0, 0);
    vertex(-w, -h, -d, 1, 0);
    vertex(-w, h, -d, 1, 1);
    vertex( w, h, -d, 0, 1);
    endShape();
    beginShape(QUADS);
    texture(abajo);
    vertex(-w, h, d, 0, 0);
    vertex( w, h, d, 1, 0);
    vertex( w, h, -d, 1, 1);
    vertex(-w, h, -d, 0, 1);
    endShape();
    beginShape(QUADS);
    texture(arriba);
    vertex(-w, -h, -d, 0, 0);
    vertex( w, -h, -d, 1, 0);
    vertex( w, -h, d, 1, 1);
    vertex(-w, -h, d, 0, 1);
    endShape();
    beginShape(QUADS);
    texture(costado2);
    vertex( w, -h, d, 0, 0);
    vertex( w, -h, -d, 1, 0);
    vertex( w, h, -d, 1, 1);
    vertex( w, h, d, 0, 1);
    endShape();
    beginShape(QUADS);
    texture(costado2);
    vertex(-w, -h, -d, 0, 0);
    vertex(-w, -h, d, 1, 0);
    vertex(-w, h, d, 1, 1);
    vertex(-w, h, -d, 0, 1);
    endShape();
  }
  void generarCaras() {
    arriba = createImage(w, d, RGB);
    for (int i = 0; i < arriba.pixels.length; i++) {
      arriba.pixels[i] = c2;
    }
    abajo = createImage(w, d, RGB);
    for (int i = 0; i < arriba.pixels.length; i++) {
      abajo.pixels[i] = c1;
    }
    costado1 = createImage(w, h, RGB);
    for (int j = 0; j < h; j++) {
      color col = lerpColor(c1, c2, map(j, 0, h, 1, 0));
      for (int i = 0; i < w; i++) {
        costado1.set(i, j, col);
      }
    }
    costado2 = createImage(d, h, RGB);
    for (int j = 0; j < h; j++) {
      color col = lerpColor(c1, c2, map(j, 0, h, 1, 0));
      for (int i = 0; i < d; i++) {
        costado2.set(i, j, col);
      }
    }
  }
}

class Camara {
  float x, y, z, rotx, roty, vely;
  int time;
  Camara() {
    x = width/2;
    y = height/2;
    z = -100;
    rotx = -0.8046021;
    roty = 4.3054013;
  }
  void act() {
    rotx += cos(((frameCount%1000)/1000.) * TWO_PI)/-1000;
    roty += vely;
    time--;
    if (time <= 0) randomCam();
    translate(x, y, z);
    rotateX(rotx);
    rotateY(roty);
    scale(map(frameCount,0,25*90,0.23,0.65));
  }
  void randomCam() {
    roty = random(TWO_PI); 
    rotx = random(PI*1.7, TWO_PI);
    vely = random(-0.005, 0.005);
    time = int(random(18, 100));
  }
}

void remplazar() {
  for (int i = 0; i < 50; i++) {
    int x = int(random(20));
    int y = int(random(20));
    pilares[x][y] = new Pilar(x, y);
    delay(int(random(50, 100)));
  }
}

void reconstruir() {
  if (random(1) < 0.5) {
    for (int j = 0; j < 20; j++) {
      for (int i = 0; i < 20; i++) {
        pilares[i][j] = new Pilar(i, j);
        delay(10);
      }
    }
  }
  else {
    for (int j = 0; j < 20; j++) {
      for (int i = 0; i < 20; i++) {
        pilares[j][i] = new Pilar(j, i);
        delay(10);
      }
    }
  }
}
