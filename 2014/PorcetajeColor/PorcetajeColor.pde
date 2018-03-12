boolean render;
ColorPorcentaje cp;
float porcentaje_render;
Input input;
Paleta paleta;
PGraphics img;

void setup() {
  size(420, 460);
  input = new Input();
  paleta = new Paleta(#029978, #342D27, #F9F3CF, #FFB007, #F8411F);
  cp = new ColorPorcentaje(10, 410, 310, 40, paleta);
  img = createGraphics(390, 390);
  img.beginDraw();
  img.background(255);
  img.endDraw();
  thread("generar");
}

void draw() {
  frame.setTitle("Holis "+frameRate);
  background(220);
  stroke(0, 20);
  noFill();
  for (int i = 0; i < 5; i+=2) {
    strokeWeight(i);
    rect(10, 10, 400, 440, 6);
  }
  strokeWeight(1);
  noStroke();
  fill(255);
  rect(10, 10, 400, 400, 6, 6, 0, 0);
  img.beginDraw();
  img.endDraw();
  image(img, 15, 15);
  fill(2);
  //rect(10, 410, 310, 40, 0, 0, 6, 6);
  cp.act();
  fill(20);
  if (mouseX >= 320 && mouseX < 410 && mouseY >= 410 && mouseY < 450) {
    fill(25);
    if (input.click && !render) thread("generar");
  }
  rect(320, 410, 90, 40, 0, 0, 6, 0);
  fill(255);
  textAlign(CENTER, CENTER);
  text("GENERAR", 320, 410, 82, 36);
  if (render) {
    noStroke();
    fill(0, 120);
    rect(0, 0, width, height);
    stroke(50);
    strokeWeight(26);
    line(width/2-100,height/2,width/2+100,height/2);
    stroke(20);
    strokeWeight(20);
    line(width/2-100,height/2,width/2+100,height/2);
    stroke(140);
    line(width/2-100,height/2,width/2-100+200*porcentaje_render,height/2);
  }
  input.act();
}

void keyPressed() {
  input.event(true);
}
void keyReleased() {
  input.event(false);
}

void mousePressed() {
  input.mpress();
}
void mouseReleased() {
  input.mreleased();
}

void generar() {
  render = true;
  img.beginDraw();
  for (int i = 0; i < 10000; i++) {
    porcentaje_render = i/10000.;
    float tam = random(10, 40);
    float x = random(img.width);
    float y = random(img.height);
    int r = int(random(3));
    switch(r) {
    case 0:
      img.noStroke();
      img.fill(cp.rcol());
      img.ellipse(x, y, tam, tam);
      break;
    case 1:
      img.stroke(cp.rcol());
      img.strokeWeight(random(1, 6));
      img.noFill();
      img.ellipse(x, y, tam, tam);
      break;
    case 2:
      img.stroke(cp.rcol());
      img.strokeWeight(random(1, 6));
      float ang = random(TWO_PI);
      img.line(x+cos(ang)*tam/2, y+sin(ang)*tam/2, x-cos(ang)*tam/2, y-sin(ang)*tam/2);
      img.line(x+cos(ang+PI/2)*tam/2, y+sin(ang+PI/2)*tam/2, x-cos(ang+PI/2)*tam/2, y-sin(ang+PI/2)*tam/2);
      break;
    }
  }
  img.endDraw();
  render = false;
}


class ColorPorcentaje {
  boolean sobre, mover;
  float x, y, w, h;
  float[] val;
  int cant, sobre_time, sobv;
  Paleta paleta;
  ColorPorcentaje(float x, float y, float w, float h, Paleta paleta) {
    this.x = x; 
    this.y = y;
    this.w = w; 
    this.h = h;
    this.paleta = paleta;
    cant = paleta.colores.length;
    val = new float[cant];
    for (int i = 1; i <= cant; i++) {
      val[i-1] = (i*1./cant);
    }
    sobv = -1;
  }
  void act() {
    if (mouseX >= x && mouseX < x+w && mouseY >= y && mouseY < y+h)
      sobre = true; 
    else
      sobre = false; 
    if (sobre && input.click) {
      sobv = -1;
      for (int i = 0; i < cant-1; i++) {
        if (abs(mouseX-(x+val[i]*w)) < 6) {
          mover = true; 
          sobv = i;
        }
      }
    }
    if (mover) {
      float pos = mouseX;
      float min = (sobv == 0)? x+6 : x+(val[sobv-1]*w)+6;
      float max = (sobv == cant-1)? x+w-6 : x+val[sobv+1]*w-6;
      pos = constrain(pos, min, max);
      val[sobv] = (pos-x)/w;
    }
    if (input.released) {
      mover = false;
    }
    dibujar();
  }
  void dibujar() {
    noStroke();
    for (int i = 0; i < cant; i++) {
      fill(paleta.get(i));
      if (i == 0) rect(x, y, val[i]*w, h, 0, 0, 0, 6);
      else rect(x+val[i-1]*w, y, val[i]*w-val[i-1]*w, h);
    }
    if (sobv != -1) {
      float xx = x+val[sobv]*w;
      fill(2);
      rect(xx-3, y, 2, h);
      rect(xx+1, y, 2, h);
      /*
      rect(xx-3, y, 6, h);
       fill(240);
       rect(xx-1, y, 2, h);
       */
    }
    stroke(0, 30);
    noFill();
    rect(x, y, w, h, 0, 0, 0, 6);
  }
  color rcol() {
    color aux = -1;
    float r = random(1);
    for (int i = 0; i < cant; i++) {
      if (r <= val[i]) return paleta.get(i);
    }
    return aux;
  }
}

class Paleta {
  color colores[];
  Paleta() {
  }
  Paleta(color... colores) {
    this.colores = colores;
  }
  void agregar(color c) {
    if (colores == null) {
      colores = new color[1]; 
      colores[0] = c;
    }
    int l = colores.length;
    colores = expand(colores, l+1);
    colores[l] = c;
  }
  color get(int i) {
    return colores[i];
  }
  color rcol() {
    int r = int(random(colores.length));
    return colores[r];
  }
};

class Key { 
  boolean press, click, release;
  int clickCount;
  void act() {
    if (!focused) release();
    click = release = false;
    if (press) clickCount++;
  }
  void press() {
    if (!press) {
      click = true; 
      press = true;
      clickCount = 0;
    }
  }
  void release() {
    release = true;
    press = false;
  }
  void event(boolean estado) {
    if (estado) press();
    else release();
  }
}

class Input {
  boolean click, dclick, press, released, kclick, kpress, kreleased;
  int amouseX, amouseY;
  int pressCount, mouseWheel, timepress;
  Key CONTROL; 
  Input() {
    click = dclick = released = press = false;
    kclick = kreleased = kpress = false;
    pressCount = 0;

    CONTROL = new Key();
  }
  void act() {
    mouseWheel = 0;
    if (press) {
      pressCount++;
    }
    click = dclick = released = false;
    kclick = kreleased = false;

    CONTROL.act();
  }
  void mpress() {
    amouseX = mouseX;
    amouseY = mouseY;
    click = true;
    press = true;
  }
  void mreleased() {
    released= true;
    press = false;
    if (millis() - timepress < 400) dclick = true;
    timepress = millis();
  }

  void event(boolean estado) {
    if (estado) {
      kclick = true;
      kpress= true;
    }
    else {
      kreleased = true;
      press = false;
    }
    if (keyCode == 17) CONTROL.event(estado);
  }
}
