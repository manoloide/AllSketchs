ArrayList<Gato> gatos;
Alf alf;
Willie willie;
PImage ialf, ialfintro, iwillie;
PImage igatos[];

int INTRO=0, MENU=1, JUEGO=2, GANASTE=3, PERDISTE=4;
int estado = INTRO;
int timeEstado;
int tiempo, cantGatos, maxGatos;

/* @pjs preload="img/Alf_1.png"; */
/* @pjs preload="img/Alf_3.png" */
/* @pjs preload="img/willie.png" */
/* @pjs preload="img/Gato_1.png" */
/* @pjs preload="img/Gato_2.png" */
/* @pjs preload="img/Gato_3.png" */
/* @pjs preload="img/Gato_4.png" */
/* @pjs preload="img/Gato_5.png" */
/* @pjs preload="img/Gato_6.png" */
/* @pjs preload="img/Gato_7.png" */


void setup() {
  size(800, 600);
  frameRate(60);
  maxGatos = 24;
  cargarImagenes(); 
  willie = new Willie();
  iniciar();
}

void draw() {
  timeEstado++;
  if (estado == INTRO) {
    if (timeEstado <= 30) background(5);
    else {
      textAlign(CENTER, CENTER);
      int tt = timeEstado-30;
      textSize(tt*1.25);
      imageMode(CENTER);
      fill(tt*4);
      text("LA ODISEA DE ALF", width/2, height*0.38-tt*1.8);
      if (timeEstado > 120) {  
        float es = map(timeEstado, 80, 180, 0, 2);
        image(ialfintro, width/2, height/2, ialfintro.width*es, ialfintro.height*es);
      }
    }
    if (timeEstado > 180) cambiarEstado(JUEGO);
  } else if (estado == JUEGO) {
    background(80);
    if (timeEstado < 360) {
      alf.draw();
    } else {
      tiempo--;
      if (tiempo < 0) cambiarEstado(PERDISTE);
      if (cantGatos >= maxGatos) cambiarEstado(GANASTE); 
      if (tiempo % 120 == 0) gatos.add(new Gato());
      for (int i = 0; i < gatos.size (); i++) {
        Gato g = gatos.get(i);
        g.update();
        if (colisionRect(g.x, g.y, g.w, g.h, alf.x, alf.y, alf.w, alf.h)){
          cantGatos++;
          gatos.remove(i--);
        }else if (g.eliminar) gatos.remove(i--);
      }
      alf.update();
      gui();
    }
    willie.update();
    if (timeEstado == 0) willie.hablar("Alf tiene que ir al cumpleaños de nec. Pero no se siente con fuerza, unos gatos le vendrian bien"); 
    if (timeEstado == 360) willie.hablar("Ayuda a alf a coger la mayor cantidad de gatos y asi porder darle una alegria a nec. (haz click para mover a alf)");
  } else if (estado == GANASTE) {
    background(5);
    textAlign(CENTER, CENTER);
    textSize(80);
    fill(250);
    text("GANASTE", width/2, height/2);
    if (frameCount%60 < 30) {
      textSize(26);
      text("Haz click para rejugar", width/2, height-60);
    }
    if (timeEstado > 40 && mousePressed) {
      cambiarEstado(JUEGO);
      timeEstado = 360;
      iniciar();
    }
  } else if (estado == PERDISTE) {
    background(5);
    textAlign(CENTER, CENTER);
    textSize(80);
    fill(250);
    text("PERDISTE", width/2, height/2);
    if (frameCount%60 < 30) {
      textSize(26);
      text("Haz click para rejugar", width/2, height-60);
    }
    if (timeEstado > 40 && mousePressed) {
      cambiarEstado(JUEGO);
      timeEstado = 360;
      iniciar();
    }
  }
}

void iniciar() {
  alf = new Alf();
  gatos = new ArrayList<Gato>();
  tiempo = 60*60;
  cantGatos = 0;
}

void cargarImagenes() {
  ialf = loadImage("img/Alf_1.png");
  ialf.resize(ialf.width/2, 0); 
  ialfintro = loadImage("img/Alf_3.png");
  iwillie = loadImage("img/willie.png"); 
  igatos = new PImage[7];
  for (int i = 1; i <= 7; i++) {
    igatos[i-1] = loadImage("img/Gato_"+i+".png");
    igatos[i-1].resize(80, 0);
  }
}

void cambiarEstado(int ne) {
  estado = ne;
  timeEstado = -1;
}
class Gato {
  boolean eliminar;
  float x, y, w, h;
  int time, tipo;
  Gato() {
    tipo = int(random(7));
    w = igatos[tipo].width;
    h = igatos[tipo].height;
    x = random(w, width-w);
    y = random(h, width-h);
    time = int(random(120, 400));
  }
  void update() {
    time--;
    if (time < 0) eliminar = true;
    draw();
  }
  void draw() {
    imageMode(CENTER);
    image(igatos[tipo], x, y);
  }
}

void gui() {
  float val, w, h;
  w = 200;
  h = 16;
  noStroke();
  val = map(tiempo, 60*60, 0, 0, 1);
  fill(#F03924, 240);
  rect(width/2-w/2, 12, w-w*val, h);
  fill(#74362F, 240);
  rect(width/2-w/2+w-w*val, 12, w*val, h);  
  val = map(cantGatos, maxGatos, 0, 0, 1);
  fill(#5BF022, 240);
  rect(width/2-w/2, 40, w-w*val, h);
  fill(#43762F, 240);
  rect(width/2-w/2+w-w*val, 40, w*val, h);

}


class Alf {
  boolean mover;
  float x, y, w, h, ox, oy, vel;
  Alf() {
    x = width/2;
    y = height/2;
    w = ialf.width;
    h = ialf.height;
    ox = x;
    oy = y;
    vel = 4;
  }  
  void update() {
    if (mousePressed) {
      ox = mouseX;
      oy = mouseY;
      mover = true;
    }
    if (mover) move();
    draw();
  }
  void move() {
    float ang = atan2(oy-y, ox-x);
    float dis = dist(x, y, ox, oy);
    if (dis >= vel) {
      x += cos(ang)*vel;
      y += sin(ang)*vel;
    } else mover = false;
  }
  void draw() {
    imageMode(CENTER);
    image(ialf, x, y);
  }
}

class Willie {
  boolean hablando;
  int alto, vel, time, timeApa, timeEst, timeTotal;
  float des;
  String txt, txtd;
  Willie() {
    timeApa = 30;
    timeEst = 90;
    alto = 160;
    vel = 2;
  }
  void update() {
    if (hablando) {
      if (time < timeApa) {
        des -=  iwillie.height/timeApa;
      } else if (time <= timeTotal-timeApa) {
        int i = constrain((time-timeApa)/vel, 0, txt.length());
        txtd = txt.substring(0, i);
      } else {
        des +=  iwillie.height/timeApa;
      }
      time++;
      draw();
    }
  }
  void draw() {
    imageMode(CORNER);
    fill(#A0AFBF);
    noStroke();
    rect(0, height-alto+des, width, alto);
    fill(5);
    textSize(26);
    textAlign(LEFT, TOP);
    text(txtd, 20, height-(alto-16)+des, width-iwillie.width-20, alto);
    image(iwillie, width-iwillie.width, height-iwillie.height+des);
  }
  void hablar(String txt) {
    time = 0;
    des = iwillie.height;
    timeTotal = timeApa*2 + txt.length() * vel + timeEst;
    this.txt = txt;
    txtd = "";
    hablando = true;
  }
}

boolean colisionRect(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
  float disX = w1/2 + w2/2;
  float disY = h1/2 + h2/2;
  if (abs(x1 - x2) < disX && abs(y1 - y2) < disY) {
    return true;
  }  
  return false;
}
