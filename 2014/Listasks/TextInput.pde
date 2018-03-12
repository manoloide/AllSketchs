class TextInput {
  boolean on, press, click;
  boolean edit, number;
  float x, y, w, h; 
  int pos;
  String val;
  TextInput(float x, float y, float w, float h, String val) {
    this.x = x;
    this.y = y;
    this.w = w; 
    this.h = h;
    this.val = val;
  } 
  void update(float dx, float dy) {
    on = press = click = false;
    if (mouseX >= x+dx && mouseX < x+w+dx && mouseY >= y+dy && mouseY < y+h+dy) {
      on = true;
      if (input.press)press = true;
      if (input.released)click = true;
    }
    if (on && input.dclick) {
      buscarPos(x+dx, y+dy);
      edit = true;
    }
    if (edit) {
      if (input.ENTER.click) edit = false;
      if (input.click && !on) edit = false;
      if (input.click && on) buscarPos(x+dx, y+dy);
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
        if (!number && key >= 32 && key <= 126) {
          val = val.substring(0, pos)+ key +val.substring(pos);
          pos++;
        } else if (key >= 48 && key < 58) {
          val = val.substring(0, pos)+ key +val.substring(pos);
          pos++;
        }
      }
    }
  }
  void show(float dx, float dy) {
    /*
    fill(255, 0, 0);
    rect(x+dx, y+dy, w, h);
    */
    fill(#F2F7FC);
    text(val, x+dx, y+dy);
    noStroke();
    if (edit && frameCount%60 < 30) {
      rect(x+dx+textWidth(val.substring(0, pos)), y+dy, 1.5, (textAscent()+textDescent())+1);
    }     //<>//
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
  void buscarPos(float x, float y) {
    if (mouseX < x) {
      pos = 0;
      return;
    }
    if (mouseX >= x+textWidth(val)) { 
      pos = val.length();
      return;
    }
    int at = 4;
    for (int i = 0; i <= val.length (); i++) {
      int tam = int(textWidth(val.substring(0, i)));
      if (mouseX >= x+at && mouseX < x+tam) {
        pos = i-1;
        break;
      }
      at = tam;
    }
  }
};
