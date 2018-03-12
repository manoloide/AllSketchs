
int col, vec, estado, alfa;
float dista, ang;
//7
ArrayList giradores;
int ran, can;
girador g1, g2, g3;
//thread
SimpleThread t1;

void setup() {
  size(600, 600); 
  colorMode(HSB);
  smooth();
  noStroke();
  iniciar();
  background((col+128)%256, 255, 255);

  estado = int(random(1, 3))*int(random(1, 2));
  alfa = 1;
  vec = 10;
  //7
  ran = 10;
  can = 20;
  giradores = new ArrayList();
  for (int i = 0; i < can; i++) {
    giradores.add(new girador());
  }
  //thread;
  t1 = new SimpleThread();
  t1.start();
}

void draw() {
  fill((col+128)%256, 255, 255, alfa);
  rect(0, 0, width, height);
  if (estado == 1) {
    alfa = 1;
    f1();
  }
  else if (estado == 2) {
    alfa = 2;
    f2();
  }
  else if (estado == 3) {
    alfa = 2;
    f3();
  }
  else if (estado == 5) {
    alfa = 5;
    f5();
  }
  else if (estado == 6) {
    alfa = 5;
    f6();
  }
  else if (estado == 7) {
    alfa = 5;
    f7();
  }
  //cambio de color
  col += int(random(-1, 2));
  col = col%256;
  //angulo 
  ang += 0.02;
  ang = ang%(PI*2);
}

void keyPressed() {
  if (key == 'r') {
    iniciar();
  }else if (key == 't') {
    t1.andando = !t1.andando;
  }
  else if (key == '1') {
    estado = 1;
  }
  else if (key == '2') {
    estado = 2;
  }
  else if (key == '3') {
    estado = 3;
  }
  else if (key == '5') {
    estado = 5;
  }
  else if (key == '6') {
    estado = 6;
  }
  else if (key == '7') {
    estado = 7;
  }
}

void f1() {
  float grosor = random(20, 100);
  fill(color(col, 200, random(100, 180)));
  ellipse(mouseX, mouseY, grosor, grosor);
}

void f2() {
  for (int i = 0; i < random(5); i++) {
    float grosor = random(20, 100);
    fill(color(col, 200, random(100, 180)));
    ellipse(random(width), random(height), grosor, grosor);
  }
}

void f3() {
  for (int i = 0; i < random(9); i++) {
    float grosor = random(4, 10);
    fill(color(col, 200, random(100, 180)));
    ellipse(random(width), random(height), grosor, grosor);
  }
  //dibujar puntero
  float grosor = random(20, 100);
  fill(color(col, 200, random(100, 180)));
  ellipse(mouseX, mouseY, grosor, grosor);
}

void f5() {
  dista = dist(mouseX, mouseY, width/2, height/2)*10;
  for (int i = 0; i < vec; i++) {
    float dis = (dista/vec)*i;
    if (i%2 == 1) {
      fill(col, 255, 255);
    }
    else {
      fill((col+128)%256, 255, 255);
    }
    ellipse(width/2 + cos(ang)*dis, height/2 +sin(ang)*dis, dis, dis);
    ellipse(width/2 + cos(ang+2*PI/3)*dis, height/2 +sin(ang+2*PI/3)*dis, dis, dis);
    ellipse(width/2 + cos(ang+2*PI/3*2)*dis, height/2 +sin(ang+2*PI/3*2)*dis, dis, dis);
  }
}

void f6() {
  for (int j = 0; j < height/ran; j++) {
    for (int i = 0; i < width/ran; i++) {
      if (random(2) > 1) {
        fill((col+128)%256, 255, 255);
      }
      else {
        fill(col, 255, 255);
      }
      rect(ran*i, ran*j, ran, ran);
    }
  } 
  for (int i = 0; i < can; i++) {
    girador aux = (girador) giradores.get(i);
    aux.alfa = 255;
    aux.act();
  }
}

void f7() {
  for (int j = 0; j < height/ran; j++) {
    for (int i = 0; i < width/ran; i++) {
      if (random(2) > 1) {
        fill((col+128)%256, 255, 255, 10);
      }
      else {
        fill(col, 255, 255, 10);
      }
      rect(ran*i, ran*j, ran, ran);
    }
  } 
  for (int i = 0; i < can; i++) {
    girador aux = (girador) giradores.get(i);
    aux.alfa = 100;
    aux.act();
  }
}

void iniciar() {
  col = int(random(256));
  background((col+128)%256, 215, 255);
}

class girador {
  float x, y, ang, vel, rad, dim, alfa;
  girador() {
    x = random(width);
    y = random(height);
    ang = random(TWO_PI);
    vel = 1;
    dim = random(20, 200);
    rad = dim/2;
    alfa = 255;
  } 
  void act() {
    //mueve
    x += cos(ang)*vel;
    y += sin(ang)*vel;
    //aleja del mouse
    float distancia = dist(x, y, mouseX, mouseY);
    if (distancia < dim) {
      float angu = atan2(mouseY-y, mouseX-x);
      float velo = (dim - distancia)/10;
      x -= cos(angu)*velo;
      y -= sin(angu)*velo;
    }
    //controla los bordes...
    if (x > width+rad) {
      x = -rad;
    }
    else if (x < -rad) {
      x = width+rad;
    }

    else if (y > height+rad) {
      y = -rad;
    }

    else if (y < -rad) {
      y = height+rad;
    }
    //color aleatorio
    if (random(2) > 1) {
      fill((col+128)%256, 255, 255, alfa);
    }
    else {
      fill(col, 255, 255, alfa);
    }
    //dibuja
    ellipse(x, y, dim, dim);
    ang += random(-0.1, 0.1);
    ang = ang%TWO_PI;
  }
}

class SimpleThread extends Thread {
  boolean andando;           // esta andando
  int esperar;               // cuanto tiempo espera
  String nombre;             // nombre
  int contador;              // cuenta 

  SimpleThread () {
    andando = false;
    contador = 0;
  }

  int getCount() {
    return contador;
  }

  void start () {
    andando = true;
    esperar = int(random(100, 5000));
    println("Arranco un thread"); 
    super.start();
  }

  void run () {
    while (andando) {
      contador++;
      if (random(2) > 1) {
        estado = int(random(1, 4));
      }else{
        estado = int(random(5, 8));
      }
      try {
        sleep((long)(esperar));
        esperar = int(random(100, 2000));
      } 
      catch (Exception e) {
        println(e);
      }
    }
  }

  void quit() { 
    andando = false;  // Setting running to false ends the loop in run()
    // IUn case the thread is waiting. . .
    interrupt();
  }
}

