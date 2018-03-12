class Fuente {
  PImage[][] letra;
  int es;
  int[] tam = {
    2, 2, 4, 6, 6, 6, 6, 2, 3, 3, 6, 6, 3, 3, 2, 4, 6, 4, 6, 6, 6, 6, 6, 6, 6, 6, 2, 2, 4, 4, 4, 6, 
    6, 6, 6, 6, 6, 6, 6, 6, 6, 4, 5, 6, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 3, 4, 3, 4, 5, 
    3, 6, 6, 6, 6, 6, 6, 6, 5, 2, 3, 5, 3, 6, 6, 5, 6, 6, 6, 6, 4, 6, 6, 6, 6, 5, 6, 4, 2, 4, 5, 5
  };
  Fuente(PImage img, int es) {
    this.es = es;
    letra = recortarImagen(img, 5, 7, es);
    for (int i = 0; i < tam.length; i++) {
      tam[i] *= es;
    }
  }
  void escribir(String texto, int x, int y) {
    int dx = 0; 
    int dy = 0;
    for (int i = 0; i < texto.length(); i++) {
      PImage aux = null;
      int ind = texto.charAt(i)-32;
      if (ind >= 0 && ind < 96) {
        aux = letra[ind%32][ind/32];
      }
      else {
        aux = letra[2][31];
      }
      image(aux, x+dx, y+dy);
      dx += tam[ind];
    }
  }
  void escribir(String texto, int x, int y, color col) {
    int dx = 0; 
    int dy = 0;
    for (int i = 0; i < texto.length(); i++) {
      int ind = texto.charAt(i)-32;
      if (ind == -22) {
        dx = 0;
        dy += 22;
        continue;
      }
      PImage aux = letra[ind%32][ind/32];
      for (int k = 0; k < aux.height; k++) {
        for (int j = 0; j < aux.width; j++) {
          color ac = aux.get(j, k);
          if (alpha(ac) > 0) {
            set(x+dx+j, y+dy+k, col);
          }
        }
      }
      dx += tam[ind];
    }
  }
  int tamano(String texto) {
    int aux = 0; 
    for (int i = 0; i < texto.length(); i++) {
      int ind = texto.charAt(i)-32;
      aux += tam[ind];
    }
    return aux;
  }
}

class Menu {
  String estado;
  Boton bnuevo, bcargar, bopciones, bsalir, bslot1, bslot2, bslot3, bvolver;
  Menu() {
    estado = "menu_principal";
    bnuevo = new Boton(220, 100, 200, 56, "Nuevo");
    bcargar = new Boton(220, 180, 200, 56, "Cargar");
    bopciones = new Boton(220, 260, 200, 56, "Opciones");
    bsalir = new Boton(220, 340, 200, 56, "Salir");
    bslot1 = new Boton(220, 100, 200, 56, "Slot1");
    bslot2 = new Boton(220, 180, 200, 56, "Slot2");
    bslot3 = new Boton(220, 260, 200, 56, "Slot3");
    bvolver = new Boton(220, 340, 200, 56, "Volver");
  }

  void act() {
    background(40, 40, 30);
    if (estado.equals("menu_principal")) {
      bnuevo.act();
      bcargar.act();
      bopciones.act();
      bsalir.act();
      if (bnuevo.press) {
        nuevoNivel(); 
        pausa = false;
      }
      if (bcargar.press) {
        estado = "menu_cargar";
      }
      if (bsalir.press) {
        exit();
      }
    }
    else if (estado.equals("menu_cargar")) {
      bslot1.act();
      bslot2.act();
      bslot3.act();
      bvolver.act();

      if (bvolver.press) {
        estado = "menu_principal";
      }
    }
  }
}

class Boton {
  boolean press, sobre;
  String nombre;
  int x, y, w, h, t;
  Boton(int x, int y, int w, int h, String n) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    nombre = n;
  }
  void act() {
    sobre = false;
    press = false;
    if (mouseX >= x && mouseX < x+w && mouseY >= y && mouseY < y+h) {
      sobre = true;
      if (click) {
        press = true;
      }
    }
    draw();
  }
  void draw() {
    dibujarBordes(x, y, w, h, 0);
    int tam = fgrande.tamano(nombre);//145,145,131
    fgrande.escribir(nombre, x+w/2-tam/2+2, y+14+2, color(177, 177, 152));
    fgrande.escribir(nombre, x+w/2-tam/2, y+14, color(33, 33, 22));
    if (sobre) {
      fill(0, 20);
      if (press) {
        fill(0, 40);
      }
      rect(x, y, w, h);
    }
  }
}

void dibujarBordes(int x, int y, int nw, int nh, int tipo) {
  int tam = 8;
  int w = nw/tam; 
  int h = nh/tam;
  image(bordes[0+tipo*3][0], x, y);
  for (int i = 1; i < h-1; i++) {
    image(bordes[0+tipo*3][1], x, y+i*tam);
  }
  image(bordes[0+tipo*3][2], x, y+tam*(h-1));
  for (int i = 1; i < w-1; i++) {
    image(bordes[1+tipo*3][0], x+i*tam, y);
  }
  image(bordes[2+tipo*3][2], x+tam*(w-1), y+tam*(h-1));
  for (int i = 1; i < h-1; i++) {
    image(bordes[2+tipo*3][1], x+tam*(w-1), y+i*tam);
  }
  image(bordes[2+tipo*3][0], x+tam*(w-1), y);
  for (int i = 1; i < w-1; i++) {
    image(bordes[1+tipo*3][2], x+i*tam, y+tam*(h-1));
  }
  for (int j = 1; j < h-1; j++) {
    for (int i = 1; i < w-1; i++) {
      image(bordes[1+tipo*3][1], x+i*tam, y+j*tam);
    }
  }
}

void dibujarIcono(int x, int y, int nx, int ny) {
  image(iconos[nx][ny], x, y);
}

class Consola {
  /*
  COMANDOS:
   - /salir salir del juego
   - /tiempo numero setea la hora;
   - /temperatura numero setea la temperatura;
   */
  boolean activo, visible;
  String entrada, texto;
  int renglones, tiempo;
  Nivel n;
  Consola(Nivel n) {
    this.n = n;
    activo = false;
    visible = false;
    entrada = "";
    texto = "";
    renglones = 0;
  }

  void act() {
    if (activo) {
      noStroke();
      fill(0, 120);
      rect(8, 450, 464, 22);
      fchica.escribir(entrada, 12, 454, color(255));
      rect(8, 442 - renglones * 22, 464, 22 * renglones);
      for (int i = 0; i < renglones; i++) {
        fchica.escribir(texto+"\n", 12, 446 - renglones * 22, color(255));
      }
    }
    if (visible && !activo) {
      fchica.escribir(entrada, 14, 426, color(0, tiempo));
      fchica.escribir(entrada, 12, 424, color(255, tiempo));
      tiempo--;
      if (tiempo == 0) {
        visible = false;
      }
    }
  }

  void pressTecla(char code) {
    if (code == ENTER || code == RETURN) {
      activo = !activo;
      if (activo) {
        visible = true;
        entrada = "";
      }
      if (!activo && !entrada.equals("")) {
        tiempo = 100;
        if (entrada.charAt(0) == 47) {
          escribirTexto(entrada);
          String[] palabra = split(entrada, ' ');
          //salir
          if (palabra[0].equals("/salir")) {
            if (palabra.length == 1) {
              exit();
            }
            else {
              escribirTexto("/salir no acepta parametros!");
            }
          }
          //tiempo
          else if (palabra[0].equals("/tiempo")) {
            int lar = palabra.length;
            int h = 0, m = 0;
            if (lar > 1 && lar < 4) {
              boolean error = false;
              if (lar == 2) {
                try { 
                  h = Integer.parseInt(palabra[1]);
                }
                catch(NumberFormatException e) {
                  error = true;
                } 
                m = 0;
              }
              if (lar == 3) {
                try { 
                  h = Integer.parseInt(palabra[1]);
                  m = Integer.parseInt(palabra[2]);
                }
                catch(NumberFormatException e) {
                  error = true;
                }
              }
              if (h < 0 || h >= 24 || m < 0 || m >= 60) {
                error = true;
              }
              if (error) {
                entrada = "Parametro no valido!";
              }
              else {
                n.clima.hora = h;
                n.clima.minuto = m;
                entrada = "Tiempo: "+h+":"+m;
              }
            }
            else {
              entrada = "Cantidad de parametros incorrecta!";
            }
          }   
          //temperatura   
          else if (palabra[0].equals("/temperatura")) {
            boolean error = false;
            int t = -999;
            if (palabra.length == 2) {
              try { 
                t = Integer.parseInt(palabra[1]);
              }
              catch(NumberFormatException e) {
                error = true;
              }
            }
            else {
              error = true;
              entrada = "Cantidad de parametros incorrecta!";
            }
            if (t < -4 || t > 44) {
              error = true;
              entrada = "Parametro no valido!";
            }
            if (!error) {
              n.clima.temp = t;
              entrada = "Temperatura: "+t;
            }
          }
          else {
            entrada = "Comando no valido!";
          }
          escribirTexto(entrada);
        }
      }
    }
    else {
      if (activo) {
        if (key >= 32 && key <= 126) {
          entrada += code;
        }
        if (key == BACKSPACE) {
          int lar = entrada.length();
          if (lar > 0) {
            entrada = entrada.substring(0, lar-1);
          }
        }
      }
    }
  }


  void escribirTexto(String ent) {
    ent += "\n";
    texto += ent;
    if (renglones < 5) {
      renglones++;
    }
    else {
      int aux = 0;
      while (texto.charAt (aux) != 10) {
        aux++;
      } 
      texto = texto.substring(aux+1, texto.length());
    }
  }
}
