import ddf.minim.*;

Minim minim;
AudioPlayer s1, s2, s3;

int cant = 15;
int count = 0;
int distancia = -4;

Triangulo[] triangulos;
String estado = "negro"; //negro,v1,v2,v3;

void setup() {
  size(displayWidth, displayHeight);
  minim = new Minim(this);
  //aca estan los sonidos
  s1 = minim.loadFile("sonido.mp3", 2048);
  s2 = minim.loadFile("sonido.mp3", 2048);
  s3 = minim.loadFile("sonido.mp3", 2048);

  s1.pause();
  s2.pause();
  s3.pause();
  background(0);
  noStroke();
  triangulos = new Triangulo[cant];
  for (int i = 0; i < cant; i++) {
    triangulos[i] = new Triangulo();
  }
}

void draw() {
  if (estado.equals("negro")) {
    background(0);
  } else if (estado.equals("v1")) {
    noStroke();
    background(255);
    fill(0);
    for (int i = 0; i < triangulos.length; i++) {
      triangulos[i].act();
    }
    float mov = (frameCount%70 < 8)? 4 : 0;
    fill(0, 255, 255, 120);
    rect(width-160-distancia, height-120-mov, 60, 80);
    fill(255, 0, 0, 120);
    rect(width-160+distancia, height-120-mov, 60, 80);
    fill(0);
    rect(width-160, height-120-mov, 60, 80);
  } else if (estado.equals("v2")) {
    noStroke();
    background(0);
    float tam = 1800-count*5;
    if (tam <= 0) {
      count = 0;
    } 
    fill(0, 255, 255, 120);
    ellipse(width/2-distancia, height/2, tam, tam);
    fill(255, 0, 0, 120);
    ellipse(width/2+distancia, height/2, tam, tam);
    fill(255);
    ellipse(width/2, height/2, tam, tam);
    count++;
  } else if (estado.equals("v3")) {
    background(255);
    for (int i = 0; i < 20; i ++) {
      float ang = random(TWO_PI);
      float tam = random(60);
      strokeWeight(2);
      stroke(0, 255, 255, 120);
      line(width/2+cos(ang)*tam+distancia, height/2+sin(ang)*tam, width/2-cos(ang)*tam+distancia, height/2-sin(ang)*tam);
      stroke(255, 0, 0, 120);
      line(width/2+cos(ang)*tam-distancia, height/2+sin(ang)*tam, width/2-cos(ang)*tam-distancia, height/2-sin(ang)*tam);
      stroke(0);
      line(width/2+cos(ang)*tam, height/2+sin(ang)*tam, width/2-cos(ang)*tam, height/2-sin(ang)*tam);
    }
    noStroke();
  }
}

void stop() {
  s1.close();
  s2.close();
  s3.close();
  minim.stop();

  super.stop();
}

void keyPressed() {
  s1.pause();
  s2.pause();
  s3.pause();
  if (key == '0') {
    estado = "negro";
    s1.loop(0);
    s2.loop(0);
    s3.loop(0);
  } else if (key == '1') {
    estado = "v1";
    s1.loop(0);
  } else if (key == '2') {
    estado = "v2";
    count = 0;
    s2.loop(0);
  } else if (key == '3') {
    estado = "v3";
    s3.loop(0);
  }
}

class Triangulo {
  float ang, da, tam, x, y, vel;
  Triangulo() {
    ang = random(TWO_PI);
    da = TWO_PI/3;
    tam = 40/2;
    x = random(280);
    y = random(250);
    vel = 0.5;
  }
  void act() {
    float dis = dist(250, 250, x, y);
    float da = atan2(250-y, 250-x);
    ang += random(-0.1, 0.1);//-abs(ang-da)*dis/400)%TWO_PI;
    x += cos(ang)*vel;
    y += sin(ang)*vel;
    dibujar();
  }
  void dibujar() {
    float dis = distancia;
    float x = this.x + random(-1, 1)*0.5;
    float y = this.y + random(-1, 1)*0.5;
    fill(0, 255, 255, 120);
    triangle(x+cos(ang)*tam+dis, y+sin(ang)*tam, x+cos(ang+da)*tam+dis, y+sin(ang+da)*tam, x+cos(ang+da*2)*tam+dis, y+sin(ang+da*2)*tam);
    fill(255, 0, 0, 120);
    triangle(x+cos(ang)*tam-dis, y+sin(ang)*tam, x+cos(ang+da)*tam-dis, y+sin(ang+da)*tam, x+cos(ang+da*2)*tam-dis, y+sin(ang+da*2)*tam);
    fill(0);
    triangle(x+cos(ang)*tam, y+sin(ang)*tam, x+cos(ang+da)*tam, y+sin(ang+da)*tam, x+cos(ang+da*2)*tam, y+sin(ang+da*2)*tam);
  }
}

