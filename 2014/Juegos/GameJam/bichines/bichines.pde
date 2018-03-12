/*
 -terminar Slider
 -agregar sonido
 -colores retocar
 -terminar placas
 -agregar loader
 */

import ddf.minim.*;

Minim minim;

ArrayList<Entidad> entidades;
ArrayList<Particula> particulas;
Boton nuevoJuego, opciones, atras;
Input input;
Jugador jugador;
Score score;
Slider musica, vfx;
String estado = "menu"; // menu, opciones, jugar, ganaste, perdiste;
Sonido sonido;
PImage img_fondo, img_slider, img_pointslider, img_cursor;
PImage[] img_jugador, img_placas, img_draco, img_comida;

void setup() {
  size(800, 600);
  colorMode(HSB, 256);
  noCursor();
  noStroke();
  frame.setTitle("Balanced meal");
  input = new Input();
  img_fondo = loadImage("img/fondo.png");
  img_pointslider = loadImage("img/pointslider.png");
  img_slider = loadImage("img/slider.png");
  img_cursor = loadImage("img/cursor.png");
  img_jugador = new PImage[15];
  for (int i = 0; i < 15; i++) {
    img_jugador[i] = loadImage("img/l_"+(i+1)+".png");
  }
  img_placas = new PImage[4];
  for (int i = 0; i < 4; i++) {
    img_placas[i] = loadImage("img/P_"+(i+1)+".png");
  }
  img_draco = new PImage[4];
  for (int i = 0; i < 4; i++) {
    img_draco[i] = loadImage("img/D_"+(i+1)+".png");
  }
  img_comida = new PImage[17];
  for (int i = 0; i < 17; i++) {
    img_comida[i] = loadImage("img/C_"+(i+1)+".png");
  }

  nuevoJuego = new Boton(258, 208, 288, 74);
  opciones = new Boton(292, 330, 212, 64);
  atras = new Boton(66, 472, 60, 60);
  vfx = new Slider(450, 258);
  musica = new Slider(450, 354);


  minim = new Minim(this);
  sonido = new Sonido();

  reiniciar();
}

void draw() {
  //if (frameCount%10 == 0) frame.setTitle("Balanced meal    Fps: "+frameRate + " "+score.avance*100);
  sonido.act();
  dibujarFondo();
  if (estado.equals("menu")) {
    image(img_placas[0], 0, 0);
    nuevoJuego.act();
    opciones.act();
    if (nuevoJuego.click) {
      estado = "jugar";
      nuevoJuego.click = false;
    }
    if (opciones.click) {
      estado = "opciones";
      opciones.click = false;
    }
  }
  else if (estado.equals("opciones")) {
    image(img_placas[1], 0, 0);
    atras.act();
    musica.act();
    vfx.act();
    if (atras.click) {
      estado = "menu";
      atras.click = false;
    }
  }
  else if (estado.equals("jugar")) {
    for (int i = 0; i < entidades.size(); i++) {
      Entidad aux = entidades.get(i);
      aux.act();
      if (aux.eliminar) entidades.remove(i--);
    }

    jugador.act();
    score.act();

    if (jugador.eliminar) {
      estado = "perdiste";
    }
    if (score.avance >= 1) {
      estado = "ganaste";
    }
  }
  else if (estado.equals("ganaste")) {
    image(img_placas[3], 0, 0);
    if (input.click) {
      estado = "menu";
      reiniciar();
    }
  } 
  else if (estado.equals("perdiste")) {
    image(img_placas[2], 0, 0);
    if (input.click) {
      estado = "menu";
      reiniciar();
    }
  } 
  if (!estado.equals("jugar")) {
     image(img_cursor, mouseX-1, mouseY-1); 
  }
  
  input.act();
}

void stop() {
  sonido.close();
}

void mousePressed() {
  input.mpress();
}
void mouseReleased() {
  input.mreleased();
}

void keyPressed() {
  input.event(true);
}

void keyReleased() {
  input.event(false);
}

void reiniciar() {
  score = new Score();
  entidades = new ArrayList<Entidad>();
  particulas = new ArrayList<Particula>();
  for (int i = 0; i < 50; i++) {
    particulas.add(new Luces(random(width), random(height)));
  }
  for (int i = 0; i < 6; i++) {
    entidades.add(new Bicho(random(width), random(height), 40));
  }
  jugador = new Jugador(width/2, height/2);
}

void dibujarFondo() {
  image(img_fondo, 0, 0);
  int r, g, b, cant;
  r = g = b = cant = 0;  
  for (int i = 0; i < entidades.size(); i++) {
    if (entidades.get(i) instanceof Bicho) {
      color col = entidades.get(i).col;
      cant++;
      r += red(col);
      g += green(col);
      b += blue(col);
    }
  }
  colorMode(RGB, 256);
  color colfondo;
  if (cant > 0) colfondo = color(r/cant, g/cant, b/cant, 20+score.avance*80);
  else colfondo = color(0, 20);
  colorMode(HSB, 256);
  noStroke();
  for (int i = 0; i < particulas.size(); i++) {
    Particula aux = particulas.get(i);
    aux.act();
    if (aux.eliminar) particulas.remove(i--);
  }
  colfondo = color(hue(colfondo),saturation(colfondo)+score.avance*140,brightness(colfondo)+score.avance*200, 20+score.avance*80);
  fill(colfondo);
  rect(0, 0, width, height);
}
