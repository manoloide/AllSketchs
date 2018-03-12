Jugador j;
Mapa m;
ArrayList<Tiro> tiros = new ArrayList<Tiro>();

void setup() {
  size(400, 400);
  smooth();
  noStroke();
  m = new Mapa();
  j = new Jugador(20, 20, m, "name");
}

void draw() {
  background(140);
  m.draw();
  j.act();
  stroke(255,0,0);
  for(int i = 0; i < tiros.size(); i++){
     tiros.get(i).act(); 
  }
  noStroke();
  sombras(j, m);
}

void mousePressed(){
   tiros.add(new Tiro(j.x+j.tam/2,j.y+j.tam/2,atan2(j.y-mouseY,j.x-mouseX),j));  
}

void keyPressed() {
  if (key == 'a' || keyCode == LEFT) {
    j.izquierda = true;
  } 
  else if (key == 'd' || keyCode == RIGHT) {
    j.derecha = true;
  }
  else if (key == 'w' || keyCode == UP) {
    j.arriba = true;
  } 
  else if (key == 's' || keyCode == DOWN) {
    j.abajo = true;
  }
}
void keyReleased() {
  if (key == 'a' || keyCode == LEFT) {
    j.izquierda = false;
  } 
  else if (key == 'd' || keyCode == RIGHT) {
    j.derecha = false;
  }
  else if (key == 'w' || keyCode == UP) {
    j.arriba = false;
  } 
  else if (key == 's' || keyCode == DOWN) {
    j.abajo = false;
  }
}

void sombras(Jugador ju, Mapa m) {
  ArrayList<Punto> puntos = new ArrayList<Punto>();
  for (int j = 1; j < m.cv-1; j++) {
    for (int i = 1; i < m.ch-1; i++) {
      if (m.ma[i][j] == 1) {
        float jx = ju.x + ju.tam/2; 
        float jy = ju.y + ju.tam/2; 


        Punto pun[] = new Punto[4];
        float dis[] = new float[4];

        int x = 0, y = 0;
        float ang = 0, adis = 0;
        Punto aux = null;

        for (int k = 0; k < 4; k++) {
          if (k == 0) {
            x = i*m.tam;
            y = j*m.tam;
          }
          else if ( k == 1) {
            x = i*m.tam + m.tam;
            y = j*m.tam;
          }
          else if ( k == 2) {
            x = i*m.tam;
            y = j*m.tam + m.tam;
          }
          else if ( k == 3) {
            x = i*m.tam + m.tam;
            y = j*m.tam+ m.tam;
          }
          ang = atan2(jy-y, jx-x);
          aux = new Punto(x, y, ang);
          adis = dist(x, y, jx, jy);

          int l = 0;
          while (l < k && adis >= dis[l]) {
            l++;
          }
          for (int n = k; n > l; n--) {
            pun[n] = pun[n-1];
            dis[n] = dis[n-1];
          }
          pun[l] = aux;
          dis[l] = adis;
        }

        Punto pa = null;
        float ax, ay;
        ArrayList<Punto> punt = new ArrayList<Punto>();

        int mt = int(ju.tam/2);
        x = int(i*m.tam)+mt;
        y = int(j*m.tam)+mt;

        int xj = int(ju.x)+mt;
        int yj = int(ju.y)+mt;

        if ((jx-mt < x && jx+mt > x)||(jy-mt < y && jy+mt > y)) {
          ax = pun[0].x-cos(pun[0].ang)*600;
          ay = pun[0].y-sin(pun[0].ang)*600;
          pa = new Punto(ax, ay, pun[0].ang);
          punt.add(pa);
          punt.add(pun[0]);
          punt.add(pun[1]);
          ax = pun[1].x-cos(pun[1].ang)*600;
          ay = pun[1].y-sin(pun[1].ang)*600;
          pa = new Punto(ax, ay, pun[1].ang);
          punt.add(pa);
        }
        else {
          ax = pun[1].x-cos(pun[1].ang)*600;
          ay = pun[1].y-sin(pun[1].ang)*600;
          pa = new Punto(ax, ay, pun[1].ang);
          punt.add(pa);
          punt.add(pun[1]);
          punt.add(pun[0]);          
          punt.add(pun[2]);
          ax = pun[2].x-cos(pun[2].ang)*600;
          ay = pun[2].y-sin(pun[2].ang)*600;
          pa = new Punto(ax, ay, pun[2].ang);
          punt.add(pa);
        }

        fill(0);
        beginShape();
        for (int k = 0; k < punt.size();k++) {
          Punto paux = punt.get(k);
          vertex(paux.x, paux.y);
        }
        endShape(CLOSE);
      }
    }
  }
}



