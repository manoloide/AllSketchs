class Selector {
  boolean press;
  int x1, y1, x2, y2;
  Nivel n;
  Selector(Nivel n) {
    this.n = n;
    press = false;
  }
  void act(int px, int py) {
    if (press) {
      x2 = mouseX - n.px;
      y2 = mouseY - n.py;
      stroke(0, 255, 0, 200);
      fill(0, 255, 0, 40);
      ellipse(x2+px,y2+py,5,5);
      ellipse(x1+px,y1+py,5,5);
      rectMode(CORNERS);
      rect(x1+px, y1+py, x2+px, y2+py);
      rectMode(CORNER);
    }
  }

  void click() {
    x1 = mouseX - n.px;
    y1 = mouseY - n.py;
    press = true;
  }

  void desclick() {
    press = false;
  }
}
class Seleccionable {
  boolean seleccionado;
  int prioridad;
  void seleccionar() {
  }
  void orden() {
  }
  void deseleccionar() {
  }
}

class Nivel {
  int w, h, tam;
  int px, py, sx, sy;
  Tile mapa[][];
  Jugador jugador;
  ArrayList<Entidad> entidades;
  ArrayList<Particula> particulas;
  Humano j;
  Clima clima;
  Selector selector;
  Consola consola;
  Nivel(int w, int h) {
    this.w = w;
    this.h = h;
    tam = 40;
    px = int(random(w))*tam*-1;
    py = int(random(h))*tam*-1;
    mapa = new Tile[w][h];
    jugador = new Jugador();
    entidades = new ArrayList<Entidad>();
    particulas = new ArrayList<Particula>();
    clima = new Clima(this, 1000);
    clima.arrancar();
    generarMapa();
    selector = new Selector(this);
    consola = new Consola(this);
    //thread("actLuz");
  }
  void act() {
    //orde
    Collections.sort(entidades);
    if (focused) {
      int cx = 240;
      int cy = height/2;
      float dis = dist(mouseX, mouseY, cx, cy);
      if (mouseX < 480 && dis > 100) {
        float disx = dist(cx, 0, mouseX, 0);
        float disy = dist(cy, 0, mouseY, 0);
        int vel = 60;
        int mx = int((disx > 120)? disx/vel : 0);
        int my = int((disy > 100)? disy/vel : 0);

        px = (cx > mouseX)? px+mx : px-mx;
        py = (cy > mouseY)? py+my : py-my;
      }
      int tt = int(tam*1.5);
      if (px < -(w*tam-480+tt)) px = -(w*tam-480+tt);
      if (px > tt) px = tt;
      if (py < -(h*tam-height+tt)) py = -(h*tam-height+tt);
      if (py > tt) py = tt;
    }
    sx = int((mouseX-px%tam)/tam-px/tam);
    sy = int((mouseY-py%tam)/tam-py/tam);
    dibujarMapa();
    dibujarGui();
    consola.act();
  }
  void arrancar() {
    clima.arrancar();
  }
  void pausar() {
    clima.pausar();
  }
  void dibujarMapa() {
    int x0 = (px*-1)/tam;
    x0 = (x0 < 0)? 0 : x0;
    int y0 = (py*-1)/tam;
    y0 = (y0 < 0)? 0 : y0;
    int x1 = x0+17;
    x1 = (x1 > w)? w : x1;
    int y1 = y0+13;
    y1 = (y1 > h)? h : y1;
    for (int j = y0; j < y1; j++) {
      for (int i = x0; i < x1; i++) {
        int x = i*tam+px;
        int y = j*tam+py;
        mapa[i][j].act(x, y);
      }
    }
    //recuadro;
    noFill();
    stroke(250, 100);
    int x = px%tam+(sx+px/tam)*tam;
    int y = py%tam+(sy+py/tam)*tam;
    rect(x, y, 40, 40);
    //
    for (int i = 0; i < entidades.size(); i++) {
      Entidad aux = entidades.get(i);
      aux.act(px, py);
      if (aux.eliminar) {
        entidades.remove(i--);
      }
    }
    for (int i = 0; i < particulas.size(); i++) {
      Particula aux = particulas.get(i);
      aux.act(px, py);
      if (aux.eliminar) {
        particulas.remove(i--);
      }
    }
    selector.act(px, py);
  }
  void dibujarGui() {
    //menu lateral;
    dibujarBordes(488, 8, 144, 464, 1);
    fchica.escribir("Minuto: "+clima.minuto, 500, 16, color(255));
    fchica.escribir("Hora: "+clima.hora, 500, 32, color(255));
    fchica.escribir("Dia: "+clima.dia, 500, 48, color(255));
    fchica.escribir("Temp: "+clima.temp, 500, 64, color(255));
    //menu superior;
    dibujarBordes(8, 8, 300, 32, 1);
    dibujarIcono(18, 18, 0, 0);
    fchica.escribir(""+jugador.madera, 38, 18, color(255));
    dibujarIcono(112, 18, 1, 0);
    fchica.escribir(""+jugador.piedra, 132, 18, color(255));
    dibujarIcono(206, 18, 2, 0);
    fchica.escribir(""+jugador.comida, 226, 18, color(255));
  }
  void generarMapa() {
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        if (random(1) > 0.2) {
          mapa[i][j] = new Tile(0);
        }
        else {
          mapa[i][j] = new Tile(0);//1
        }
      }
    }
    for (int i = 0; i < (h*w)/10; i++) {
      int x = int(random(w));
      int y = int(random(h));
      mapa[x][y].agregar(new Arbol());
    }
    for (int i = 0; i < (h*w)/20; i++) {
      int x = int(random(w));
      int y = int(random(h));
      mapa[x][y].agregar(new Piedra());
    }
    for (int i = 0; i < (h*w)/40; i++) {
      int x = int(random(w));
      int y = int(random(h));
      mapa[x][y].agregar(new Moras());
    }
    for (int i = 0; i < 40; i++) {
      int x = int(random(w));
      int y = int(random(h));
      if (!mapa[x][y].ocupado) {
        entidades.add(new Oso(x*tam, y*tam, this));
      }
    }
    j = new Humano(px*-1, py*-1, this);
    entidades.add(j);
    px += 240;
    py += 240;
  }
}

class Jugador {
  int madera, piedra, comida;
  //ArrayList<Entidad> entidades;
  Jugador() {
    madera = 0;
    piedra = 0;
    comida = 0;
  }
}

class Tile {
  int val;
  boolean ocupado;
  Cosa c;
  Tile(int val) {
    this.val = val;
    ocupado = false;
  }
  void act(int x, int y) {
    image(sprites[val][0], x, y);
    if (c!= null) {
      c.act(x, y);
      if (c.eliminar) {
        vaciar();
      }
    }
  }
  void agregar(Cosa c) {
    if (this.c == null) {
      this.c = c;
      ocupado = true;
    }
  }
  void vaciar() {
    c = null;
    ocupado = false;
  }
}

class Clima extends Thread {
  boolean andando; 
  int esperar; 
  int temp, dia, hora, minuto;
  Nivel n;
  Clima(Nivel n, int esperar) {
    this.n = n;
    this.esperar = esperar;
    dia = 1;
    hora = int(random(24));
    minuto = 0;
    temp = int(random(18, 24));  
    andando = false;
  }

  void arrancar() {
    andando = true;
    super.start();
  }

  void run() {
    while (andando) {
      minuto++;
      if (minuto >= 60) {
        //thread("actLuz");
        minuto = 0;
        hora++;
        temp = actualizaTemp(temp, hora);
        if (hora >= 24) {
          hora = 0;
          dia++;
        }
      }
      try {
        sleep((long)esperar);
      }
      catch(Exception e) {
      }
    }
  }

  void pausar() {
    andando = false;
  }

  void parar() {
    interrupt();
  }

  private int randomPor(int valor1, int pos1, int valor2, int pos2) {
    int res;
    Random rand = new Random();
    int x = rand.nextInt(pos1+pos2);
    if (x < pos1) {
      res = valor1;
    }
    else {
      res = valor2;
    }
    return res;
  }

  private int actualizaTemp(int temp, int hora) {
    int res = 0;
    switch(hora) {
      //baja
      case(18):
      res = randomPor(-1, 2, 0, 1);
      res = randomPor(res, 5, 1, 1);
      break;
      case(19):
      res = randomPor(-1, 3, 0, 1);
      res = randomPor(res, 6, 1, 1);
      break;
      case(20):
      res = randomPor(-2, 5, -1, 1);
      res = randomPor(res, 4, 0, 1);
      res = randomPor(res, 6, 1, 1);
      break;
      case(21):
      res = randomPor(-2, 5, -1, 1);
      res = randomPor(res, 5, 0, 1);
      res = randomPor(res, 6, 1, 1);
      break;
      case(22):
      res = randomPor(-2, 5, -1, 1);
      res = randomPor(res, 6, 0, 1);
      break;
      case(23):
      res = randomPor(-2, 1, -1, 4);
      res = randomPor(res, 2, 0, 1);
      res = randomPor(res, 8, 1, 1);
      break;      
      case(0):
      res = randomPor(-2, 1, -1, 3);
      res = randomPor(res, 2, 0, 1);
      break;
      case(1):
      res = randomPor(-2, 1, -1, 4);
      res = randomPor(res, 2, 0, 1);
      break;
      case(2):
      res = randomPor(-2, 1, -1, 3);
      res = randomPor(res, 1, 0, 1);
      break;
      case(3):
      res = randomPor(-2, 1, -1, 1);
      res = randomPor(res, 6, 0, 1);
      break;
      case(4):
      res = randomPor(-1, 1, 0, 1);
      res = randomPor(res, 6, 1, 1);
      break;
      case(5):
      res = randomPor(-1, 1, 0, 1);
      res = randomPor(res, 5, 1, 1);
      break;

      //sube
      case(6):
      res = randomPor(1, 2, 0, 1);
      res = randomPor(res, 5, -1, 1);
      break;
      case(7):
      res = randomPor(1, 3, 0, 1);
      res = randomPor(res, 6, -1, 1);
      break;
      case(8):
      res = randomPor(2, 5, 1, 1);
      res = randomPor(res, 4, 0, 1);
      res = randomPor(res, 6, -1, 1);
      break;
      case(9):
      res = randomPor(2, 5, 1, 1);
      res = randomPor(res, 5, 0, 1);
      res = randomPor(res, 6, -1, 1);
      break;
      case(10):
      res = randomPor(2, 5, 1, 1);
      res = randomPor(res, 6, 0, 1);
      break;
      case(11):
      res = randomPor(2, 1, 1, 4);
      res = randomPor(res, 2, 0, 1);
      res = randomPor(res, 8, -1, 1);
      break;      
      case(12):
      res = randomPor(2, 1, 1, 3);
      res = randomPor(res, 2, 0, 1);
      break;
      case(13):
      res = randomPor(2, 1, 1, 4);
      res = randomPor(res, 2, 0, 1);
      break;
      case(14):
      res = randomPor(2, 1, 1, 3);
      res = randomPor(res, 1, 0, 1);
      break;
      case(15):
      res = randomPor(2, 1, 1, 1);
      res = randomPor(res, 6, 0, 1);
      break;
      case(16):
      res = randomPor(1, 1, 0, 1);
      res = randomPor(res, 6, -1, 1);
      break;
      case(17):
      res = randomPor(1, 1, 0, 1);
      res = randomPor(res, 5, -1, 1);
      break;
    }
    res = temp + res;
    if (res < -10) {
      res = -10;
    }
    else if (res > 42) {
      res = 42;
    }
    return res;
  }
}

//Cosas

class Cosa {
  int vida, tipo;
  boolean eliminar;
  void act(int x, int y) {
  }
}

class Arbol extends Cosa {
  Arbol() {
    tipo = 0;
    vida = int(random(8, 13))*10; 
    eliminar = false;
  }
  void act(int x, int y) {
    image(sprites[0][1], x, y);
    if (vida <= 0) {
      eliminar = true;
    }
  }
}

class Piedra extends Cosa {
  Piedra() {
    tipo = 1;
    vida = int(random(30, 51))*10; 
    eliminar = false;
  }
  void act(int x, int y) {
    image(sprites[1][1], x, y);
    if (vida <= 0) {
      eliminar = true;
    }
  }
}

class Moras extends Cosa {
  Moras() {
    tipo = 2;
    vida = int(random(8, 23))*10; 
    eliminar = false;
  }
  void act(int x, int y) {
    image(sprites[2][1], x, y);
    if (vida <= 0) {
      eliminar = true;
    }
  }
}

