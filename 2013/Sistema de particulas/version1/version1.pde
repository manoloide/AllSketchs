import java.util.Calendar;

ArrayList<Particula> particulas;
color fondo; 
float cx, cy, hue;
Gui gui;
MenuPressets mp;
void setup() {
  size(1280, 720);
  fondo = color(53, 117, 203);
  hue =(float) hue(fondo);
  colorMode(HSB, 256);
  frame.setResizable(true);
  frame.setTitle("Particuleitor 0.1");
  gui = new Gui("Particuleitor 0.1");
  gui.agregarPestana(new Pestana("Particulas"));
  gui.getPestana("Particulas").desplagada = false;
  gui.agregarElemento(new scrollH(10, 10, 180, 10, 0, 200, 80, "Cantidad"), "Particulas");
  gui.agregarElemento(new scrollH(10, 30, 180, 10, 0.1, 30, 2, "Tamaño minimo"), "Particulas");
  gui.agregarElemento(new scrollH(10, 50, 180, 10, 1, 60, 10, "Tamaño maximo"), "Particulas");
  gui.agregarElemento(new scrollH(10, 70, 180, 10, -0.2, 2, 0.2, "Atraccion"), "Particulas");
  gui.agregarElemento(new scrollH(10, 90, 180, 10, 0, 8, 1, "Estabilidad"), "Particulas");
  gui.agregarElemento(new Pulsador(10, 110, 10, 10, "Reset"), "Particulas");
  gui.agregarPestana(new Pestana("Lineas"));
  gui.getPestana("Lineas").desplagada = false;
  gui.agregarElemento(new Boton(10, 10, 10, 10, 0, "Activar"), "Lineas");
  gui.agregarElemento(new Comentario(62, 10, 10, 40, "c1", "(se puede realentizar)"), "Lineas");
  gui.agregarElemento(new scrollH(10, 30, 180, 10, 0.1, 8, 0.5, "Ancho"), "Lineas");
  gui.agregarElemento(new scrollH(10, 50, 180, 10, 0, 500, 10, "Distancia minima"), "Lineas");
  gui.agregarElemento(new scrollH(10, 70, 180, 10, 0, 500, 60, "Distancia maxima"), "Lineas");
  gui.agregarPestana(new Pestana("Forma y color"));
  gui.getPestana("Forma y color").desplagada = false;
  gui.agregarElemento(new Selector(10, 10, 70, 10, 7, 0, "Forma"), "Forma y color");
  gui.agregarElemento(new scrollH(10, 30, 180, 10, -8, 8, 0, "Variar color fondo"), "Forma y color");
  gui.agregarElemento(new scrollH(10, 50, 180, 10, 10, 256, 256, "Alpha fondo"), "Forma y color");
  gui.agregarPestana(new Pestana("Pressets"));
  gui.getPestana("Pressets").margen = false;
  mp = new MenuPressets(0, 0, 200, 3, "MenuPressets");
  gui.agregarElemento(mp, "Pressets");
  mp.agregarPresset(new Presset(0, 0, 200, 20, "Curvas"));
  mp.agregarPresset(new Presset(0, 20, 200, 20, "Dragon"));
  mp.agregarPresset(new Presset(0, 40, 200, 20, "Mosquitos"));
  mp.agregarPresset(new Presset(0, 60, 200, 20, "Redes"));
  mp.agregarPresset(new Presset(0, 80, 200, 20, "Hambrientos"));
  mp.agregarPresset(new Presset(0, 100, 200, 20, "Trama"));
  gui.agregarPestana(new Pestana("Utilidades y configuraciones"));
  gui.getPestana("Utilidades y configuraciones").desplagada = false;
  gui.agregarElemento(new Boton(10, 10, 10, 10, 0, "Info"), "Utilidades y configuraciones");
  gui.agregarElemento(new Boton(80, 10, 10, 10, 0, "Seguir cursor"), "Utilidades y configuraciones");
  gui.agregarElemento(new Boton(10, 30, 10, 10, 0, "Menu fijo"), "Utilidades y configuraciones");
  gui.agregarElemento(new Boton(80, 30, 10, 10, 1, "Esconder menu"), "Utilidades y configuraciones");
  gui.agregarElemento(new Boton(80, 50, 10, 10, 1, "Mundo abierto"), "Utilidades y configuraciones");
  gui.agregarElemento(new Boton(10, 50, 10, 10, 1, "Smooth"), "Utilidades y configuraciones");
  gui.agregarPestana(new Pestana("Informacion"));
  gui.getPestana("Informacion").desplagada = false;
  String informacion = "Atajos teclado:\n  s - Guardar imaguien\n  m - esconder-abrir menu\nGracias por usar el Particuleitor. \n\nManoloide! - 2013\nmanoloide@guimail.com";
  gui.agregarElemento(new Comentario(10, 10, 180, 130, "informacion", informacion), "Informacion");
  reset();
}

void draw() {
  if (frameCount%10 == 0) {
    frame.setTitle("Particuleitor 0.1 -- FPS: " +frameRate);
  }
  pressets();
  if (gui.getValor("Smooth") == 1) {
    smooth();
  }
  else {
    noSmooth();
  }
  //color fondo
  hue = (hue+(Float)gui.getValor("Variar color fondo")+256)%256;
  fondo = color(hue, 117, 203,(Float) gui.getValor("Alpha fondo"));
  noStroke();
  fill(fondo);
  rect(0, 0, width, height);
  //reiniciar
  if (gui.getValor("Reset") == 1) {
    reset();
  }
  //seguir cursos
  if (gui.getValor("Seguir cursor") == 1) {
    cx = mouseX;
    cy = mouseY;
  }
  //guiestionar cantidad
  int cp = (int)gui.getValor("Cantidad");
  int cantidadParticulas = particulas.size();
  if (cantidadParticulas < cp) {
    Particula aux = crearParticula();
    aux.cambiarCentro(cx, cy);
    particulas.add(aux);
  }
  else if (cantidadParticulas > cp) {
    particulas.remove(cantidadParticulas-1);
  }
  //lineas
  if (gui.getValor("Activar") == 1) {
    for (int j = 0; j < particulas.size(); j++) {
      Particula p1 = particulas.get(j);
      for (int i = j+1; i < particulas.size(); i++) {
        Particula p2 = particulas.get(i);
        float dis = dist(p1.x, p1.y, p2.x, p2.y);
        if (dis < gui.getValor("Distancia minima")) continue;
        if (dis > gui.getValor("Distancia maxima")) continue;
        if (dis > (p1.tam+p2.tam)/2) {
          strokeWeight(gui.getValor("Ancho"));
          stroke(255);
          line(p1.x, p1.y, p2.x, p2.y);
        }
      }
    }
    strokeWeight(1);
  }
  //act y dibujar particulucas :)
  for (int i = 0; i < particulas.size(); i++) {
    Particula aux = particulas.get(i);
    //seguir cursos
    if (gui.getValor("Seguir cursor") == 1) { 
      aux.cambiarCentro(cx, cy);
    }
    aux.act();
    if (aux.eliminar) {
      particulas.remove(i--);
    }
  }
  gui.act();
  if (gui.getValor("Info") == 1) {
    float px = width/2-65;
    float py = 20; 
    noStroke();
    fill(0, 160);
    rect(px, py, 130, 52);
    fill(256);
    text("FPS: "+frameRate, px+2, py+12);
    text("Particulas: "+particulas.size(), px+2, py+24);
    text("Centro X: "+cx, px+2, py+36);
    text("Centro Y: "+cy, px+2, py+48);
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    gui.click = true;
    if (!gui.visible) {
      cx = mouseX;
      cy = mouseY;
      for (int i = 0; i < particulas.size(); i++) {
        Particula aux = particulas.get(i);
        aux.cambiarCentro(cx, cy);
      }
    }
  }
}

void mouseReleased() {
  if (mouseButton == RIGHT) {
    gui.setVisible(true);
  }
}
 
void keyPressed() {
  if(key=='s' || key=='S') saveFrame(timestamp()+"_##.png"); 
  if(key=='m' || key=='M') gui.visible = !gui.visible; 
}


String timestamp() {
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", Calendar.getInstance());
}

void reset() {
  particulas = new ArrayList();
  cx = random(width);
  cy = random(height);
  for (int i = 0; i < (int)gui.getValor("Cantidad"); i++) {
    Particula aux = crearParticula();
    particulas.add(aux);
    aux.cambiarCentro(cx, cy);
  }
}

Particula crearParticula() {
  return new Particula(random(width), random(height), random(gui.getValor("Tamaño minimo"),gui.getValor("Tamaño maximo")));
}

class Particula {
  boolean eliminar;
  float cx, cy, x, y, dx, dy, vel, tam, dtam, angui;
  Particula(float x, float y, float tam) {
    this.x = x;
    this.y = y;
    this.tam = tam;
    dx = random(0.2);
    dy = random(0.2);
    vel = random(0.2, 0.8);
    eliminar = false;
  }
  void act() {
    float tmin = gui.getValor("Tamaño minimo");
    float tmax = gui.getValor("Tamaño maximo");
    if (tam < tmin || tam > tmax) {
      dtam = random(tmin, tmax);
    }
    tam += (dtam-tam)/20;
    float dist = dist(x, y, cx, cy);
    angui = atan2(cy-y, cx-x);
    float px = x;
    float py = y;
    if (dist/20 > 1) {
      x += cos(dx*frameCount) * vel/2*dist/20 * gui.getValor("Estabilidad") + cos(angui)*dist/10 * gui.getValor("Atraccion");
      y += cos(dy*frameCount) * vel/2*dist/20 * gui.getValor("Estabilidad") + sin(angui)*dist/10 * gui.getValor("Atraccion");
    }
    else {
      x += cos(dx*frameCount) * vel/1.5 + cos(angui)*dist/10;
      y += cos(dy*frameCount) * vel/1.5 + sin(angui)*dist/10;
    }
    angui = atan2(py-y, px-x);
    if (gui.getValor("Mundo abierto") == 0) {
      if ( x < -tam) {
        x = width+tam;
      }
      else if (x > width+tam) {
        x = -tam;
      }
      if ( y < -tam) {
        y = height+tam;
      }
      else if (y > height+tam) {
        y = -tam;
      }
    }
    dibujar();
  }

  void dibujar() {
    noStroke();
    fill(255);
    int val = (int)gui.getValor("Forma");
    if (val == 0) {
      ellipse(x, y, tam, tam);
    }
    else if ( val == 1) {
      stroke(255);
      pushMatrix();
      translate(x, y);
      rotate(angui);  
      line(-tam/2, 0, tam/2, 0);
      popMatrix();
    }
    else if (val == 2) {
      stroke(255);
      pushMatrix();
      translate(x, y);
      rotate(angui);  
      line(-tam/2, 0, tam/2, 0);
      line(0, -tam/2, 0, tam/2);
      popMatrix();
    }
    else {
      pushMatrix();
      translate(x, y);
      rotate(angui);  
      forma(0, 0, tam, val);
      popMatrix();
    }
  }
  void cambiarCentro(float cx, float cy) {
    this.cx = cx;
    this.cy = cy;
  }
}
void forma(float cx, float cy, float tam, int cant) {
  float angui = TWO_PI/cant;
  tam /= 2;
  beginShape();
  for (int i = 0; i < cant; i++) {
    float a = angui*i + angui/2;
    vertex(cos(a)*tam, sin(a)*tam);
  }
  endShape(CLOSE);
}

void pressets() {
  for (int i = 0; i < mp.pressets.size(); i++) {
    Presset aux = (Presset) mp.pressets.get(i);
    if (aux.click) {
      if (aux.nombre == "Curvas") {
        gui.setValor("Cantidad", 120);
        gui.setValor("Tamaño minimo", 20);
        gui.setValor("Tamaño maximo", 60);
        gui.setValor("Atraccion", 1.2);
        gui.setValor("Estabilidad", 8);
        gui.setValor("Activar", 0);
        //gui.setValor("Ancho", 0.5);
        //gui.setValor("Distancia minima", 80);
        //gui.setValor("Distancia maxima",120);
        gui.setValor("Forma", 1);
        gui.setValor("Variar color fondo", 2);
        gui.setValor("Alpha fondo", 10);
        gui.setValor("Seguir cursor", 1);
        reset();
      }
      else if (aux.nombre == "Dragon") {
        gui.setValor("Cantidad", 80);
        gui.setValor("Tamaño minimo", 10);
        gui.setValor("Tamaño maximo", 60);
        gui.setValor("Atraccion", 2);
        gui.setValor("Estabilidad", 8);
        gui.setValor("Activar", 0);
        //gui.setValor("Ancho", 0.5);
        //gui.setValor("Distancia minima", 80);
        //gui.setValor("Distancia maxima",120);
        gui.setValor("Forma", 3);
        gui.setValor("Variar color fondo", 5);
        gui.setValor("Alpha fondo", 10);
        gui.setValor("Seguir cursor", 1);
        gui.setValor("Mundo abierto", 1);
        reset();
      }
      else if (aux.nombre == "Mosquitos") {
        gui.setValor("Cantidad", 120);
        gui.setValor("Tamaño minimo", 4);
        gui.setValor("Tamaño maximo", 12);
        gui.setValor("Atraccion", 0.8);
        gui.setValor("Estabilidad", 7);
        gui.setValor("Activar", 0);
        //gui.setValor("Ancho", 0.5);
        //gui.setValor("Distancia minima", 30);
        //gui.setValor("Distancia maxima", 350);
        gui.setValor("Forma", 2);
        gui.setValor("Variar color fondo", 0.1);
        gui.setValor("Alpha fondo", 256);
        //gui.setValor("Seguir cursor", 0);
        reset();
      }
      else if (aux.nombre == "Redes") {
        gui.setValor("Cantidad", 20);
        gui.setValor("Tamaño minimo", 6);
        gui.setValor("Tamaño maximo", 8);
        gui.setValor("Atraccion", 1);
        gui.setValor("Estabilidad", 8);
        gui.setValor("Activar", 1);
        gui.setValor("Ancho", 0.5);
        gui.setValor("Distancia minima", 30);
        gui.setValor("Distancia maxima", 350);
        gui.setValor("Forma", 0);
        gui.setValor("Variar color fondo", 0);
        gui.setValor("Alpha fondo", 200);
        gui.setValor("Seguir cursor", 1);
        gui.setValor("Mundo abierto", 1);
        reset();
      }
      else if (aux.nombre == "Hambrientos") {
        gui.setValor("Cantidad", 200);
        gui.setValor("Tamaño minimo", 26);
        gui.setValor("Tamaño maximo", 32);
        gui.setValor("Atraccion", 0.25);
        gui.setValor("Estabilidad", 5);
        gui.setValor("Activar", 0);
        //gui.setValor("Ancho", 0.5);
        //gui.setValor("Distancia minima", 30);
        //gui.setValor("Distancia maxima", 350);
        gui.setValor("Forma", 5);
        gui.setValor("Variar color fondo", 0);
        gui.setValor("Alpha fondo", 256);
        gui.setValor("Seguir cursor", 0);
        gui.setValor("Mundo abierto", 1);
        reset();
      }
      else if (aux.nombre == "Trama") {
        gui.setValor("Cantidad", 200);
        gui.setValor("Tamaño minimo", 20);
        gui.setValor("Tamaño maximo", 60);
        gui.setValor("Atraccion", -0.2);
        gui.setValor("Estabilidad", 8);
        gui.setValor("Activar", 0);
        //gui.setValor("Ancho", 0.5);
        //gui.setValor("Distancia minima", 30);
        //gui.setValor("Distancia maxima", 350);
        gui.setValor("Forma", 2);
        gui.setValor("Variar color fondo", 1.8);
        gui.setValor("Alpha fondo", 12);
        gui.setValor("Seguir cursor", 1);
        gui.setValor("Mundo abierto", 0);
        reset();
      }
    }
  }
}
