void keyPressed() {
  if (key == 'g'){
    generarSprites();
    world.crearWorld();
  }
  input.event(true);
}

void keyReleased() {
  input.event(false);
}

void mousePressed() {
  input.mouseEvent(true);
}

void mouseReleased() {
  input.mouseEvent(false);
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  int cc = player.inventario.length;
  player.seleccionado = (int)(player.seleccionado+e+cc)%cc;
}

class Key { 
  boolean press, click;
  int clickCount;
  void update() {
    if (!focused) release();
    click = false;
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
    press = false;
  }
  void event(boolean estado) {
    if (estado) press();
    else release();
  }
}

class Input {
  boolean kpress, krelease, kclick;
  boolean mpress, mrelease, mclick;
  int amouseX, amouseY, clickCount;
  Key SALTAR, IZQUIERDA, DERECHA, CAMBIAR; 

  Input() {
    SALTAR = new Key();
    IZQUIERDA = new Key();
    DERECHA = new Key();
    CAMBIAR = new Key();
  }

  void update() {
    SALTAR.update();
    IZQUIERDA.update();
    DERECHA.update();
    CAMBIAR.update();
    kclick = false;
    mclick = false;
    krelease  = false;
    mrelease = false;
    if (mpress) {
      clickCount++;
    }
  }

  void event(boolean estado) {
    if (key == 'w' || key == 'W' || keyCode == UP) SALTAR.event(estado);
    if (key == 'a' || key == 'A' || keyCode == LEFT) IZQUIERDA.event(estado);
    if (key == 'd' || key == 'D' || keyCode == RIGHT) DERECHA.event(estado);
    if (keyCode == TAB) CAMBIAR.event(estado);
    if (estado) {
      kpress = true;
      kclick = true;
    } else {
      krelease = true;
    }
  }

  void mouseEvent(boolean estado) {
    if (estado && !mpress) {
      mpress = true;
      mclick = true;
      amouseX = mouseX;
      amouseY = mouseY;
      clickCount = 0;
    } 
    if (!estado) {
      mpress = false;
      mrelease = true;
    }
  }
}
