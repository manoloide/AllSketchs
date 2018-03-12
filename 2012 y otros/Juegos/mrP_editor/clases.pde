class Nivel {
  int[][] mapa;

  Nivel() {
    mapa = new int[height/10][height/10];
    //cargar mapa vacias.
    for (int j = 0; j < height/10; j++) {
      for (int i = 0; i < height/10; i++) {
        mapa[i][j] = 0;
      }
    }
  }

  void guardar() {
    int lar = int(height/10);
    String[] lines = new String[lar];
    //guardar pared
    for (int j = 0; j < lar; j++) {
      lines[j] = "";
      for (int i = 0; i < lar; i++) {
        lines[j] += str(mapa[i][j]);
      }
    }
    saveStrings("niveles/nivel.nvl", lines);
  }

  void cargar() {
    int lar = int(height/10);
    String[] lines = loadStrings("niveles/nivel.nvl");
    for (int j = 0; j < lar; j++) {
      String linea = lines[j];
      for (int i = 0; i < lar; i++) {
        mapa[i][j] = int(str(linea.charAt(i)));
      }
    }
  }

  void draw() {
    noStroke();
    for (int j = 0; j < height/10; j++) {
      for (int i = 0; i < height/10; i++) {
        if (mapa[i][j] == 1) {
          fill(100, 255, 127);
          rect(10*i, 10*j, 10, 10);
        }
        if (mapa[i][j] == 2) {
          fill(0, 255, 200);
          rect(10*i, 10*j, 10, 10);
        }
        if (mapa[i][j] == 3) {
          fill(230, 255, 127);
          rect(10*i, 10*j, 10, 10);
        }
        if (mapa[i][j] == 4) {
          fill(0, 0, 127);
          rect(10*i, 10*j, 10, 10);
        }
        if (mapa[i][j] == 5) {
          fill(30, 255, 200);
          ellipse(10*i, 10*j, 10, 10);
        }
        if (mapa[i][j] == 6) {
          fill(random(255), random(255), 255);
          rect(10*(i-1), 10*(j-1), 10, 10);
          fill(random(255), random(255), 255);
          rect(10*(i-1), 10*j, 10, 10);
          fill(random(255), random(255), 255);
          rect(10*i, 10*(j-1), 10, 10);
          fill(random(255), random(255), 255);
          rect(10*i, 10*j, 10, 10);
        }
      }
    }
  }
}

//gui
class Pulsador {
  float x, y, width, height;
  boolean val, aux;
  String name;

  Pulsador(float nx, float ny, float nw, float nh, String n) {
    x = nx;
    y = ny;
    width = nw;
    height = nh;
    val = false;
    name = n;
    aux = false;
  }

  void act() {
    if (mousePressed) {
      if (!aux) {
        if ( mouseX >= x  && mouseX <= x + width ) {
          if ( mouseY >= y  && mouseY <= y + height ) {
            val = true;
            aux = true;
          }
        }
      }
      else {
        val = false;
      }
    }
    else {
      aux = false;
      val = false;
    }
    draw();
  }

  void draw() {
    noStroke();
    if (val) {
      fill(150);
    }
    else {
      fill(120);
    }
    rect(x, y, width, height);
    fill(255);
    text(name, x+2, y+height-2);
  }
}

class Selector {
  int cant, val;
  float x, y, width, height;
  boolean aux;
  String name;

  Selector(float nx, float ny, float nw, float nh, int nc, int nv, String n) {
    x = nx;
    y = ny;
    width = nw;
    height = nh;
    cant = nc;
    val = nv;
    name = n;
    aux = false;
  }

  void act() {
    if (mousePressed) {
      if ( mouseX >= x  && mouseX < x + width ) {
        if ( mouseY >= y  && mouseY <= y + height ) {
          val = int((mouseX - x)/(width/cant));
        }
      }
    }
    draw();
  }

  void draw() {
    noStroke();
    for (int i = 0; i < cant; i++) {
      if (val == i) {
        fill(150);
      }
      else {
        fill(120);
      }
      rect(x+(width)/cant*i, y, width/cant, height);
    }
    fill(255);
  }
}

