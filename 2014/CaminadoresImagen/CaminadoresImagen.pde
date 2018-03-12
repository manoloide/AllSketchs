ArrayList<Particula> particulas;
Scroll cantidadParticulas, anguloInicial, anguloFinal, tamanoMin, tamanoMax;
Scroll velocidadMin, velocidadMax;
Scroll variacionAngulo, variacionTamano, variacionVelocidad, variacionBrillo;
Scroll mezclaColor, alfa;
PGraphics gra;
PImage img;

void setup() {
  img = loadImage("https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xaf1/v/t1.0-9/10411984_10204289879348359_1144123301449970042_n.jpg?oh=41da92dcf510ab2184b4072c5158dda5&oe=551CB10F&__gda__=1423454651_26b413a1101b0cbfa8147221d4ce3c0e");
  size(img.width+200, img.height);
  gra = createGraphics(img.width, img.height);
  particulas = new ArrayList<Particula>();

  cantidadParticulas = new Scroll(10, 10, 180, 20, 0, 50, 10, "Cantidad particulas");
  anguloInicial = new Scroll(10, 40, 180, 20, 0, TWO_PI, 0, "Angulo inicial");
  anguloFinal = new Scroll(10, 70, 180, 20, 0, TWO_PI*2, TWO_PI, "Angulo final");
  tamanoMin = new Scroll(10, 100, 180, 20, 0, 32, 0, "Tamaño minimo");
  tamanoMax = new Scroll(10, 130, 180, 20, 0, 32, 5, "Tamaño maximo");
  velocidadMin = new Scroll(10, 160, 180, 20, 0, 1, 0, "Velocidad minima");
  velocidadMax = new Scroll(10, 190, 180, 20, 0, 1, 0.5, "Velocidad maxima");

  variacionAngulo = new Scroll(10, 220, 180, 20, 0, 1, 0.1, "Variacion angulo");
  variacionTamano = new Scroll(10, 250, 180, 20, 0, 1, 0.999, "Variacion tamaño");
  variacionVelocidad = new Scroll(10, 280, 180, 20, 0, 1, 0.99, "Variacion velocidad");
  variacionBrillo = new Scroll(10, 310, 210, 20, 0, 1, 0.5, "Variacion brillo");
  
  mezclaColor = new Scroll(10, 340, 180, 20, 0, 1, 0.02, "Mezcla color");
  alfa = new Scroll(10, 370, 180, 20, 0, 1, 0.8, "Alfa"); 
  
  gra.beginDraw();
  gra.background(#171717);
  gra.endDraw();
}

void draw() {

  gra.beginDraw();
  for (int i = 0; i < particulas.size (); i++) {
    Particula p = particulas.get(i);
    p.update();
    if (p.eliminar) particulas.remove(i--);
  }
  gra.endDraw();

  image(gra, 0, 0);
  gui();
}

void keyPressed(){
   if(key == 's') saveFrame("#####.png"); 
}

void mouseDragged() {
  float cant = cantidadParticulas.val;
  if (mouseX > width-200) return;
  for (int i = 0; i < cant; i++) {
    particulas.add(new Particula(mouseX, mouseY));
  }
}

void gui() {
  noStroke();
  fill(60);
  rect(width-200, 0, 200, height);
  cantidadParticulas.update(width-200, 0);
  anguloInicial.update(width-200, 0);
  anguloFinal.update(width-200, 0);
  tamanoMin.update(width-200, 0);
  tamanoMax.update(width-200, 0);
  velocidadMin.update(width-200, 0);
  velocidadMax.update(width-200, 0);
  variacionAngulo.update(width-200, 0);
  variacionTamano.update(width-200, 0);
  variacionVelocidad.update(width-200, 0);
  variacionBrillo.update(width-200, 0);
  mezclaColor.update(width-200, 0);
  alfa.update(width-200, 0);
}
/*
iniciar particulas 
 
 cantidadParticulasClic
 cantiadParticulasTick
 
 angInicial
 angFinal
 tamanoMin
 tamanoMax
 velMin
 velMax
 
 
 
 variacionAngulo
 variaconTamano
 varacionVelocidad
 variacionBrillo
 mezclaColor
 alfa
 */
class Particula {
  boolean eliminar;
  color col;
  float x, y, ang, t, vel;
  Particula(float x, float y) {
    this.x = x;
    this.y = y;
    ang = random(anguloInicial.val, anguloFinal.val);
    t = random(tamanoMin.val, tamanoMax.val);
    vel = random(velocidadMin.val, velocidadMax.val)*t;
    col = img.get(int(x), int(y));
  }
  void update() {
    ang += random(-variacionAngulo.val, variacionAngulo.val);
    x += cos(ang)*vel;
    y += sin(ang)*vel;
    col = lerpColor(col, img.get(int(x), int(y)), mezclaColor.val);
    float bri = map(brightness(col), 0, 256, variacionBrillo.val, 1);
    t *= random(variacionTamano.val, 1)*bri;
    vel *= random(variacionVelocidad.val, 1)*bri;
    if (t < 0.1) eliminar = true;
    show();
  }
  void show() {
    gra.noStroke();
    gra.fill(col, brightness(col)*alfa.val);
    gra.ellipse(x, y, t, t);
  }
}


class Scroll {
  boolean move, eliminar;
  float x, y, w, h, val, max, min;
  String nombre;
  Scroll(float x, float y, float w, float h, float min, float max, float val, String nombre) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.min = min;
    this.max = max;
    this.val = val;
    this.nombre = nombre;
    move = false;
    eliminar = false;
  }

  void update(float cx, float cy) {
    float x = cx + this.x;
    float y = cy + this.y;
    if (mousePressed) {
      if ( mouseX + 8 >= x + h/2 && mouseX - 8 <= x + w - h/2+ 8 && mouseY > y && mouseY <= y+h) {
        move = true;
      }
    } else {
      move = false;
    }
    if (move) {
      float posX = mouseX;
      posX = constrain(posX, x, x+w);
      val =(min + (max-min) * ((posX-h/2-x)/(w-h)));
      val = constrain(val, min, max);
    }
    show(cx, cy);
  }

  void show(float cx, float cy) {
    float x = cx + this.x;
    float y = cy + this.y;
    fill(120);
    rect(x, y, w, h);
    fill(150);
    //if(move) fill(255, 0, 0);
    float pos = x + ((w-h) * (val-min)/(max-min));
    rect(pos, y, h, h);
    fill(255);
    if (abs(max-min) >= 20) {
      text(nombre+" "+int(val), x+2, y+9);
    } else {
      text(nombre+" "+val, x+2, y+9);
    }
  }
}
