class Slide {
  boolean sobre, mover;
  color c1, c2;
  float x, y, w, gro, val;
  Slide(float x, float y, float w, float gro) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.gro = gro;
  }
  void act() {
    if (mouseX >= x-gro/2 && mouseX < x+w+gro/2 && mouseY >= y-gro/2 && mouseY < y+gro/2) {
      sobre = true;
      if (input.click) mover = true;
    }
    else {
      sobre = false;
    }
    if (input.released) mover = false;
    if (mover) {
      float pos = mouseX-x;
      val = map(pos, 0, w, 0, 1);
      if (val < 0) val = 0;
      if (val > 1) val = 1;
    }
  }
  void act(float v) {
    val = v;
    act();
  }
  void dibujar(color c1, color c2) {
    this.c1 = c1;
    this.c2 = c2;
    pushStyle();
    noStroke();
    fill(c1);
    ellipse(x, y, gro, gro);
    fill(c2);
    ellipse(x+w, y, gro, gro);
    //line(x, y, x+w, y);
    for (int i = 0; i < w; i++) {
      color c = lerpColor(c1, c2, map(i, 0, w, 0, 1));
      for (int j = 0; j < gro; j++) {
        set(int(x+i), int(y+j-gro/2), c);
      }
    }
    strokeWeight(4);
    stroke(255);
    fill(lerpColor(c1, c2, val));
    float dx = map(val, 0, 1, 0, w);
    ellipse(x+dx, y, gro+4, gro+4);
    popStyle();
  }
}

void circuloCruz(float x, float y, float d, float t, float g) {
  float r = d/2;
  x -= r;
  y -= r;
  float des = r*g/2;
  float anc = r*t;
  float kappa = 0.5522848;
  float ox = r* kappa;
  float oy = r * kappa;
  float ox2 = r * kappa;
  float oy2 = r * kappa;
  float xe = x + d;
  float ye = y + d;
  float xm = x + r;
  float ym = y + r;
  beginShape();
  vertex(x, ym);
  bezierVertex(x, ym - oy, xm - ox, y, xm, y);
  bezierVertex(xm + ox2, y, xe, ym - oy2, xe, ym);
  bezierVertex(xe, ym + oy, xm + ox, ye, xm, ye);
  bezierVertex(xm - ox2, ye, x, ym + oy2, x, ym);
  vertex(x, ym);
  x += d/2;
  y += d/2;
  vertex(x-anc, y+des);
  vertex(x-des, y+des);
  vertex(x-des, y+anc);
  vertex(x+des, y+anc);
  vertex(x+des, y+des);
  vertex(x+anc, y+des);
  vertex(x+anc, y-des);
  vertex(x+des, y-des);
  vertex(x+des, y-anc);
  vertex(x-des, y-anc);
  vertex(x-des, y-des);
  vertex(x-anc, y-des);
  vertex(x-anc, y+des);
  endShape();
}

class CampoTexto {
  boolean sobre, press, click;
  boolean editar, numerico;
  int x, y, w, h, pos;
  String val;
  CampoTexto(int x, int y, int w, String val) {
    this.x = x;
    this.y = y;
    this.w = w; 
    this.h = 60;
    this.val = val;
  } 
  void act(){
     act(0,0); 
  }
  void act(int dx, int dy) {
    sobre = press = click = false;
    if (mouseX >= x+dx && mouseX < x+w+dx && mouseY >= y+dy && mouseY < y+h+dy) {
      sobre = true;
      if (input.press)press = true;
      if (input.released)click = true;
    }
    if (sobre && input.click) {
      buscarPos(x+dx, y+dy);
      editar = true;
    }
    if (editar) {
      if (input.ENTER.click) editar = false;
      if (input.click && !sobre) editar = false;
      if (pos > 0 && (input.IZQUIERDA.click || (input.IZQUIERDA.press && input.IZQUIERDA.clickCount%3 == 0 && input.IZQUIERDA.clickCount > 30))) pos--;
      if (pos < val.length() && (input.DERECHA.click || (input.DERECHA.press && input.DERECHA.clickCount%3 == 0 && input.DERECHA.clickCount > 30))) pos++;
      if (input.BACKSPACE.click || (input.BACKSPACE.press && input.BACKSPACE.clickCount%3 == 0 && input.BACKSPACE.clickCount > 30)) {
        int lar = val.length();
        if (lar > 0 && pos > 0) {
          val = val.substring(0, pos-1)+val.substring(pos, lar);
          pos--;
        }
      }
      if (input.kclick) {
        if (!numerico && key >= 32 && key <= 126) {
          val = val.substring(0, pos)+ key +val.substring(pos);
          pos++;
          //val += key;
        }
        else if (key >= 48 && key < 58) {
          val = val.substring(0, pos)+ key +val.substring(pos);
          pos++;
        }
      }
    }
    dibujar(dx, dy);
  }
  void dibujar(){
     dibujar(0,0); 
  }
  void dibujar(int dx, int dy) {
    fill(250);
    textFont(fontG);
    textAlign(LEFT, TOP);
    text(val, x+dx+4, y+dy+6);
    if (editar && frameCount%60 < 30) {
      float xx = x+dx+2+textWidth(val.substring(0, pos));
      rect(xx, y, h/14, h);
    }
  }
  String getString() {
    return val;
  }
  int getInt() {
    return int(val);
  }
  float getFloat() {
    return float(val);
  }
  void buscarPos(int x, int y) {
    textFont(fontG);
    if (mouseX < x) {
      pos = 0;
      return;
    }
    if (mouseX >= x+textWidth(val)) { 
      pos = val.length();
      return;
    }
    int at = 4;
    for (int i = 0; i <= val.length(); i++) {
      int tam = int(textWidth(val.substring(0, i))+4);
      if (mouseX >= x+at && mouseX < x+tam) {
        pos = i-1;
        break;
      }
      at = tam;
    }
  }
}
