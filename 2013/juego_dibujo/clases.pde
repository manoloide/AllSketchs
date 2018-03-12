class Jugador {
  color col;
  Jugador() {
  }
  void act(PGraphics pg) {
    if (dibujar) {
      draw(pg);
    }
  }
  void draw(PGraphics pg) {
    pg.beginDraw();
    col = color(gui.col);
    colorMode(HSB, 255);
    float t = (256+hue(col)+random(int(gui.tono.val)*2))%256;
    float s = saturation(col)+random(int(gui.sat.val)*2);
    s = (s < 0)? 0 : (s > 255)? 255 : s;
    float l = brightness(col)+random(int(gui.lum.val)*2);
    l = (l < 0)? 0 : (l > 255)? 255 : l;
    col = color(t, s, l, alpha(col));
    colorMode(RGB);
    pg.stroke(col);
    pg.fill(col);
    if (gui.pincel.val == 0) {
      pg.strokeWeight(gui.grosor.val);
      pg.line(mouseX, mouseY, pmouseX, pmouseY);
      if (gui.espv.val) {
        pg.line(mouseX, height-mouseY, pmouseX, height-pmouseY);
      }
      if (gui.esph.val) {
        pg.line(width-mouseX, mouseY, width-pmouseX, pmouseY); 
        if (gui.espv.val) {
          pg.line(width-mouseX, height-mouseY, width-pmouseX, height-pmouseY);
        }
      }
    }
    else if (gui.pincel.val == 1) {
      float mg = gui.grosor.val;
      for (int i = 0; i <= mg; i++) {
        float alp = alpha(col)/mg;//mg - (i/mg * alpha(col));
        pg.strokeWeight(i);
        pg.stroke(red(col), green(col), blue(col), alp);
        pg.line(mouseX, mouseY, pmouseX, pmouseY);
        if (gui.espv.val) {
          pg.line(mouseX, height-mouseY, pmouseX, height-pmouseY);
        }
        if (gui.esph.val) {
          pg.line(width-mouseX, mouseY, width-pmouseX, pmouseY); 
          if (gui.espv.val) {
            pg.line(width-mouseX, height-mouseY, width-pmouseX, height-pmouseY);
          }
        }
      }
      /*
      float mg = gui.grosor.val;
       for (int i = 0; i <= mg; i++) {
       float alp = 255 - (i/mg * 255);
       pg.strokeWeight(i);
       pg.stroke(red(col), green(col), blue(col), alp);
       pg.line(mouseX, mouseY, pmouseX, pmouseY);
       if (gui.espv.val) {
       pg.line(mouseX, height-mouseY, pmouseX, height-pmouseY);
       }
       if (gui.esph.val) {
       pg.line(width-mouseX, mouseY, width-pmouseX, pmouseY); 
       if (gui.espv.val) {
       pg.line(width-mouseX, height-mouseY, width-pmouseX, height-pmouseY);
       }
       }
       }
       */
    }
    else if (gui.pincel.val == 2) {
      pg.noStroke();
      float x = (mouseX+pmouseX)/2;
      float y = (mouseY+pmouseY)/2;
      float dis = dist(mouseX, mouseY, pmouseX, pmouseY)+0.5;
      float ang = atan2(mouseY-pmouseY, mouseX-pmouseX);
      cuadrado(pg, x, y, dis, ang);
      if (gui.espv.val) {
        cuadrado(pg, x, height-y, dis, -ang);
      }
      if (gui.esph.val) {
        cuadrado(pg, width-x, y, dis, -ang); 
        if (gui.espv.val) {
          cuadrado(pg, width-x, height-y, dis, ang);
        }
      }
    }
    else if (gui.pincel.val == 3) {
      pg.noStroke();
      float x = (mouseX+pmouseX)/2;
      float y = (mouseY+pmouseY)/2;
      float dis = dist(mouseX, mouseY, pmouseX, pmouseY);
      pg.ellipse(x, y, dis, dis);
      if (gui.espv.val) {
        pg.ellipse(x, height-y, dis, dis);
      }
      if (gui.esph.val) {
        pg.ellipse(width-x, y, dis, dis); 
        if (gui.espv.val) {
          pg.ellipse(width-x, height-y, dis, dis);
        }
      }
    }
    else if (gui.pincel.val == 4) {
      pg.strokeWeight(gui.grosor.val/5);
      float cx = (mouseX+pmouseX)/2;
      float cy = (mouseY+pmouseY)/2;
      float ang = atan2(mouseY-pmouseY, mouseX-pmouseX) + PI/2;
      float tam = dist(mouseX, mouseY, pmouseX, pmouseY);
      float x = cx + cos(ang) * tam; 
      float y = cy + sin(ang) * tam;  
      float ax = cx - cos(ang) * tam;
      float ay = cy - sin(ang) * tam;
      pg.line(ax, ay, x, y);
      if (gui.espv.val) {
        pg.line(ax, height-ay, x, height-y);
      }
      if (gui.esph.val) {
        pg.line(width-ax, ay, width-x, y); 
        if (gui.espv.val) {
          pg.line(width-ax, height-ay, width-x, height-y);
        }
      }
    }
    else if (gui.pincel.val == 5) {
      pg.strokeWeight(gui.grosor.val/10);
      float dis = dist(mouseX, mouseY, pmouseX, pmouseY);
      float ang = atan2(mouseY-pmouseY, mouseX-pmouseX);
      float ax = pmouseX;
      float ay = pmouseY;
      int cant = int(dis/5);
      if (cant < 1) {
        cant = 1;
      }
      for (int i = 1; i <= cant; i++) {
        float dr = random(dis*2);
        float ar = random(TWO_PI);
        float x = pmouseX + (cos(ang)*(dis/cant)*i) + cos(ar) * dr; 
        float y = pmouseY + (sin(ang)*(dis/cant)*i) + sin(ar) * dr;  
        if (i == cant) {
          x = mouseX;
          y = mouseY;
        }
        pg.line(ax, ay, x, y);
        if (gui.espv.val) {
          pg.line(ax, height-ay, x, height-y);
        }
        if (gui.esph.val) {
          pg.line(width-ax, ay, width-x, y); 
          if (gui.espv.val) {
            pg.line(width-ax, height-ay, width-x, height-y);
          }
        }
        ax = x;
        ay = y;
      }
    }
    else if (gui.pincel.val == 6) {
      pg.strokeWeight(gui.grosor.val/20);
      float dis = dist(mouseX, mouseY, pmouseX, pmouseY);
      float ang = atan2(mouseY-pmouseY, mouseX-pmouseX);
      int cant = int(dis/2);
      if (cant < 1) {
        cant = 1;
      }
      for (int i = 0; i <= cant; i++) {
        float dr = random(dis*2);
        float ar = random(TWO_PI);
        float x = pmouseX + (cos(ang)*(dis/cant)*i) + cos(ar) * dr; 
        float y = pmouseY + (sin(ang)*(dis/cant)*i) + sin(ar) * dr;  
        float ax = pmouseX + (cos(ang)*(dis/cant)*i) - cos(ar) * dr; 
        float ay = pmouseY + (sin(ang)*(dis/cant)*i) - sin(ar) * dr; 
        pg.line(ax, ay, x, y);
        if (gui.espv.val) {
          pg.line(ax, height-ay, x, height-y);
        }
        if (gui.esph.val) {
          pg.line(width-ax, ay, width-x, y); 
          if (gui.espv.val) {
            pg.line(width-ax, height-ay, width-x, height-y);
          }
        }
      }
    }
    else if (gui.pincel.val == 7) {
      pg.noStroke();
      int cant = int(random(5));
      for (int i = 0; i < cant; i++) {
        float dr = random(gui.grosor.val/2);
        float ar = random(TWO_PI);
        float x = mouseX + cos(ar) * dr;
        float y = mouseY + sin(ar) * dr;
        float tam = random(0.5, gui.grosor.val/4);
        pg.ellipse(x, y, tam, tam);
        if (gui.espv.val) {
          pg.ellipse(x, height-y, tam, tam);
        }
        if (gui.esph.val) {
          pg.ellipse(width-x, y, tam, tam); 
          if (gui.espv.val) {
            pg.ellipse(width-x, height-y, tam, tam);
          }
        }
      }
      pg.endDraw();
    }
    /*
    noStroke();
     if (random(100) < 20) {
     float dis = random(20);
     float ang = random(TWO_PI);
     float ax = mouseX + cos(ang)*dis;
     float ay = mouseY + sin(ang)*dis;
     int at = int(random(1,20));
     ellipse(ax,ay,at,at);  
     }*/
  }
  void cuadrado(PGraphics pg, float x, float y, float dis, float ang) {
    float mitad = dis/2;
    pg.translate(x, y);
    pg.rotate(ang);
    pg.rect(-mitad, -mitad, dis, dis);
    pg.resetMatrix();
  }
}

class Moneda {
}

class Torreta {
  int x, y, tipo;
  Torreta(int x, int y, int t) {
    this.x = x; 
    this.y = y;
    tipo = t;
  }
  void act() {
  }
  void dibujar() {
  }
}

