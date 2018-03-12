ArrayList<Cosa> cosas;
ArrayList<Cosa> aparecer;
boolean ordenado;
boolean record = false;
int xpress, ypress;
int esperar;
int cantidad = 5;
int paleta[] = {
  #0A1A3D, 
  #852352, 
  #FF2B67, 
  #FB7A63, 
  #F7C95E
};
PFont helve, helveligh;
void setup() {
  size(800, 600);
  cosas = new ArrayList<Cosa>();
  aparecer = new ArrayList<Cosa>();
  helve = createFont("Helvetica Neue", 20, true);
  helveligh = createFont("Helvetica Neue Light", 14, true);

  crear();
}


void mousePressed() {
  xpress = mouseX;
  ypress = mouseY;
}

void mouseReleased() {
  cosas.add(new Ventana(xpress, ypress, mouseX, mouseY));
}

void draw() {
  
  esperar--;
   if (aparecer.size() >= 1) {
   int v = int(random(aparecer.size()));
   if (ordenado) v = 0;
   cosas.add(aparecer.get(v));
   aparecer.remove(v);
   
   esperar = int(random(60, 180));
   } else if(esperar < 0){
   int v = int(random(cosas.size()));
   cosas.remove(v);
   if(cosas.size() == 0){
   cantidad--;
   crear();
   }
   }
   
  background(969998);
  int lll = 10;
  float dd = (frameCount/10)%(lll*2);
  stroke(#A0A3A2);
  strokeWeight(lll*0.5);
  for (float i = -dd; i < width+height; i+=lll*2) {
    line(i, -2, -2, i);
  }
  for (int i = 0; i < cosas.size (); i++) {
    Cosa c = cosas.get(i); 
    c.update();
    if (c.remove) cosas.remove(i--);
  }
  stroke(0, 8);
  for (int i = 5; i >= 1; i--) {
    strokeWeight(i);
    line(0, 28, width, 28);
  }
  noStroke();
  fill(250);
  rect(0, 0, width, 28);
  textFont(helve); 
  fill(0);
  textAlign(LEFT, DOWN);
  text("Manoloide", 10, 24);
  textFont(helveligh); 
  text("Ventanas Visuales 0.1", 110, 24);

  if (record) {
    if (frameCount% 2 == 0) saveFrame("export/"+nf(frameCount/2, 3)+".png");
    if (cantidad == 0) exit();
  }
}


void crear() {
  ordenado = (random(1) < 0.5);
  int tam = int(random(40, 100));
  int bor = int(random(tam*0.1, tam*0.25)); 
  int cw = (width-bor*2)/(tam+bor);
  int ch = (height-bor*2-28)/(tam+bor);
  int dx = (width-(tam*cw+bor*(cw-1)))/2;
  int dy = dx+28;
  if ((dy+(ch-1)*(tam+bor)+tam) > height-bor) ch--;
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      aparecer.add(new Ventana(dx+i*(tam+bor), dy+j*(tam+bor), dx+i*(tam+bor)+tam, dy+j*(tam+bor)+tam));
    }
  }
}
class Cosa {
  boolean remove;
  void update() {
  }
  void show() {
  }
}

class Ventana extends Cosa {
  boolean on;
  color col;
  int x, y, w, h;
  int time;
  Visual visual;
  Ventana(int x1, int y1, int x2, int y2) {
    x = min(x1, x2);
    y = min(y1, y2);
    x2 = max(x1, x2);
    y2 = max(y1, y2);
    x1 = x;
    y1 = y;
    w = x2-x1;
    h = y2-y1;
    col = paleta[int(random(paleta.length))];
    if (random(1) < 0.8) visual = new Visual1(x+4, y+4, w-8, h-8);
    else visual = new Visual2(x+4, y+4, w-8, h-8);
  }
  void update() {
    time++;
    if (mouseX >= x && mouseX < x+w && mouseY >= y && mouseY < y+h) on = true;
    else on = false;
    visual.update();
    if (!remove) show();
  }

  void show() {
    float w = this.w;
    float h = this.h;
    int timeAparece = 20;
    int timeCarga = 30;
    if (time < timeAparece) {
      float tt = sin((time*1./timeAparece)*PI/2);
      w = this.w * tt;
      h = this.h * tt;
    }
    noFill();
    stroke(0, 8);
    for (int i = 5; i >= 1; i--) {
      strokeWeight(i);
      rect(x, y, w, h);
    }
    noStroke();
    fill(#F2F2F2);
    rect(x, y, w, h);
    if (time > timeAparece) {
      float bb = 4;
      if (time < timeAparece+timeCarga) w = this.w * (time-timeAparece)*1./timeCarga;
      else if (time < timeAparece+timeCarga*1.3) bb *= map(time, timeAparece+timeCarga, timeAparece+timeCarga*1.3, 1, 0);
      else bb = 0;
      fill(col);
      rect(x, y+h-bb, w, bb);
    }
    if (time > timeAparece+timeCarga*1.3) {
      float alp = map(time, timeAparece+timeCarga*1.3, timeAparece+timeCarga*1.5, 90, 255);
      if (alp < 255) {
        tint(255, alp);
      }
      visual.show();
      noTint();
    }
    fill(50);
    triangle(x, y, x+20, y, x, y+20);
  }
}

int rcol() {
  return paleta[int(random(paleta.length))];
}

