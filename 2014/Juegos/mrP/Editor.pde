class Editor { //<>//
  int tam;
  int px, py;
  Gui gui;
  Editor() {
    tam = TAMTILE;

    gui = new Gui("Editor");
    gui.px = width-200;
    gui.py = 0;
    gui.w = 200;
    gui.agregarPestana(new Pestana("Basicas"));
    gui.agregarElemento(new scrollH(10, 10, 180, 10, 10, 200, nivel.w, "Ancho"), "Basicas");
    gui.agregarElemento(new scrollH(10, 30, 180, 10, 10, 200, nivel.h, "Alto"), "Basicas");
    gui.agregarElemento(new Selector(10, 50, 70, 10, 7, 0, "Tipo tile"), "Basicas");
    //gui.agregarElemento(new scrollH(10, 30, 180, 10, 10, 200, nivel.h, "Alto"), "Basicas");
    //gui.agregarElemento(new scrollH(10, 30, 180, 10, 10, 200, nivel.h, "Alto"), "Basicas");
  }
  void act() {
    if (input.ARRIBA.press) {
      camara.y -= 2;
    }
    else if (input.ABAJO.press) {
      camara.y += 2;
    }
    else if (input.IZQUIERDA.press) {
      camara.x -= 2;
    }
    else if (input.DERECHA.press) {
      camara.x += 2;
    }
    //camara.x = 0;
    //camara.y = 0;
    px = floor((camara.x+mouseX-width/2+100)/tam);
    py = floor((camara.y+mouseY-height/2)/tam);
    if (mouseX < width-200 && mouseY < height-80 && px >= 0 && px < nivel.w && py >= 0 && py < nivel.h) { 
      if (input.press && mouseButton == LEFT) {
        int val = int(gui.getValor("Tipo tile"));
        if (val < 5) nivel.mapa[px][py] = val;
        if (val == 5) {
          for (int j = 0; j < nivel.h; j++) {
            for (int i = 0; i < nivel.w; i++) {
              if(nivel.mapa[i][j] == 5) nivel.mapa[i][j] = 0; 
            }
          }
          nivel.mapa[px][py] = val;
        }
        if (val == 6) {
          nivel.ix = px;
          nivel.iy = py;
        }
      }
      if (input.press && mouseButton == CENTER) {
        camara.x += (pmouseX-mouseX)/1.5;
        camara.y += (pmouseY-mouseY)/1.5;
      }
      if (input.press && mouseButton == RIGHT) {
        nivel.mapa[px][py] = 0;
      }
    }
    dibujar();
  }
  void dibujar() {
    noStroke();
    for (int j = 0; j < nivel.h; j++) {
      for (int i = 0; i < nivel.w; i++) {
        if (nivel.mapa[i][j] == 0) {
          fill(#292923);
          rect(tam*i, tam*j, tam, tam);
        }
        if (nivel.mapa[i][j] == 1) {
          fill(100, 255, 127);
          rect(tam*i, tam*j, tam, tam);
        }
        if (nivel.mapa[i][j] == 2) {
          fill(0, 255, 200);
          rect(tam*i, tam*j, tam, tam);
        }
        if (nivel.mapa[i][j] == 3) {
          fill(230, 255, 127);
          rect(tam*i, tam*j, tam, tam);
        }
        if (nivel.mapa[i][j] == 4) {
          fill(0, 0, 127);
          rect(tam*i, tam*j, tam, tam);
        }
        if (nivel.mapa[i][j] == 5) {
          fill(random(255), random(255), 255);
          rect(tam*(i-1), tam*(j-1), tam, tam);
          fill(random(255), random(255), 255);
          rect(tam*(i-1), tam*j, tam, tam);
          fill(random(255), random(255), 255);
          rect(tam*i, tam*(j-1), tam, tam);
          fill(random(255), random(255), 255);
          rect(tam*i, tam*j, tam, tam);
        }
      }
    }
    fill(30, 255, 200);
    ellipse(nivel.ix*tam, nivel.iy*tam, nivel.it, nivel.it);
    //pushMatrix();
    resetMatrix();
    stroke(255, 30);
    for (float i = ((width-200)/2-camara.x)%tam; i < width-200; i+=tam) {
      line(i, 0, i, height);
    }
    for (float i = (height/2-camara.y)%tam; i < height; i+=tam) {
      line(0, i, width-200, i);
    }
    noStroke();
    fill(80);
    rect(width-200, gui.h, 200, height-gui.h);
    gui.act();
    fill(255);
    text("x: "+px+" y: "+py, 20, 20);
    //popMatrix();
  }
}
