ArrayList<Pelota> pelotas;
Constructor c;
Input input;
Nivel nivel;

void setup() {
  size(800, 600);
  input = new Input();
  pelotas = new ArrayList<Pelota>();
  for (int i = 0; i < 10; i++) {
    pelotas.add(new Pelota(random(40, width-40), random(80, height-40)));
  }
  nivel = new Nivel(0, 40, width/20, height/20-2, 20);
}

void draw() {
  background(#6156A0);
  nivel.act();
  if (input.released && c == null) {
    int dir = 0; 
    if (abs(input.amouseX-mouseX) < abs(input.amouseY-mouseY)) dir = 1;
    boolean choca = false;
    for (int i = 0; i < pelotas.size(); i++) {
      Pelota aux = pelotas.get(i);
      int xx = 0; 
      int yy = 40; 
      int tam = nivel.tam;
      if (colisionRect(aux.x, aux.y, aux.tam, aux.tam, nivel.x+(mouseX/20)*tam+tam/2, nivel.y+(mouseY/20-2)*tam+tam/2, tam, tam)) {
        choca = true;
      }
    }
    if (!choca && nivel.tiles[mouseX/20][mouseY/20-2] == 0)
      c = new Constructor(mouseX/20, mouseY/20-2, dir);
  }
  if (c != null) {
    c.act();
    if (c.eliminar) {
      nivel.buscarZonas();
      c = null;
    }
  }
  for (int i = 0; i < pelotas.size(); i++) {
    Pelota aux = pelotas.get(i);
    aux.act();
    for (int j = i+1; j < pelotas.size(); j++) {
      Pelota aux2 = pelotas.get(j);
      aux.colisiona(aux2);
    }
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

class Key { 
  boolean press, click;
  int clickCount;
  void act() {
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
  boolean click, dclick, press, released, kclick, kpress, kreleased;
  int amouseX, amouseY;
  int pressCount, mouseWheel, timepress;
  ;
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

class Nivel {
  int x, y, w, h, tam;
  int[][] tiles;
  Nivel(int x, int y, int w, int h, int tam) {
    this.x = x; 
    this.y = y;
    this.w = w; 
    this.h = h; 
    this.tam = tam;
    tiles = new int[w][h];
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        tiles[i][j] = 0;
        if (i == 0 || i == w-1 || j == 0 || j == h-1) {
          tiles[i][j] = 1;
        }
      }
    }
  }
  void act() {
    dibujar();
  }
  void dibujar() {
    noStroke();
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        switch(tiles[i][j]) {
          case 1:
          fill(#7E6F52);
          rect(x+i*tam, y+j*tam, tam, tam);
          break;
        }
      }
    }
  }
  boolean colisiona(Pelota p) {
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        if (tiles[i][j] > 0 && colisionRect(x+i*tam+tam/2, y+j*tam+tam/2, tam, tam, p.x, p.y, p.tam, p.tam)) {
          return true;
        }
      }
    }
    return false;
  }
  void buscarZonas(){
    int cant = 0;
    ArrayList<PVector> casillas = new ArrayList<PVector>();
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        if(tiles[i][j] == 0){
          boolean nueva = true;
          int zona = cant;
          for(int k = 0; k < casillas.size(); k++){
            PVector otro = casillas.get(k);
            if(abs(i-otro.x) <= 1 && abs(j-otro.y) <= 1){
              nueva = false;
              zona = int(otro.z);
            }
          }
          if(nueva){
            cant++;
          }
          casillas.add(new PVector(i, j, zona));
        }
      }
    }
    for(int j = 0; j < casillas.size(); j++){
      PVector cas = casillas.get(j);
      for(int i = 0; i < casillas.size(); i++){
        PVector otra = casillas.get(i);
        if(cas.z == otra.z) continue;
        if(abs(cas.x-otra.x) <= 1 && abs(cas.y-otra.y) <= 1){
          cant--;
          for(int k = 0; k < casillas.size(); k++){
            PVector rem = casillas.get(k);
            if(rem.z == cas.z || rem.z == otra.z){
              rem.z = min(cas.z, otra.z);
            }else if(int(rem.z) == cant) rem.z = max(cas.z, otra.z);
          }
          i--;
        }
      }
    }
    int cl = 0;
    for(int i = 0; i < cant; i++){
      boolean llenar = true;
      for(int j = 0; j < casillas.size(); j++){
        if(int(casillas.get(j).z) != i) continue;
        int ii = int(casillas.get(j).x);
        int jj = int(casillas.get(j).y);
        for(int k = 0; k < pelotas.size(); k++){
          Pelota p = pelotas.get(k);
          if (colisionRect(nivel.x+ii*nivel.tam+nivel.tam/2, nivel.y+jj*nivel.tam+nivel.tam/2, tam, tam, p.x, p.y, p.tam, p.tam)) {
            llenar = false;
          }
        }
      }
      if (llenar) {
        for(int j = 0; j < casillas.size(); j++){
          if(int(casillas.get(j).z) != i) continue;
          int ii = int(casillas.get(j).x);
          int jj = int(casillas.get(j).y);
          tiles[ii][jj] = 1;
        }
      }
    }
    println(cant, cl);
  }
}

class Pelota {
  float x, y, tam;
  float ang, vel, velx, vely;
  Pelota(float x, float y) {
    this.x = x;
    this.y = y;
    tam = 20;
    ang = random(TWO_PI);
    vel = 1; 
    velx = cos(ang)*vel;
    vely = sin(ang)*vel;
  }
  void act() {
    //float antx = x;
    //float anty = y;
    x += velx;
    if (nivel.colisiona(this)) {
      velx *= -1;
      x += velx;
    }
    y += vely;
    if (nivel.colisiona(this)) {
      vely *= -1;
      y += vely;
    }
    dibujar();
  }
  void dibujar() {
    fill(240, 35, 67);
    ellipse(x, y, tam, tam);
  }
  boolean colisiona(Pelota p) {
    float dx = x - p.x;
    float dy = y - p.y;
    float dist = round(sqrt(dx*dx + dy*dy));
    if (dist <= (tam/2 + p.tam/2)) {
      /*
      float angle = atan2(dy, dx);
       float sin = sin(angle);
       float cos = cos(angle);
       
       float v1x = velx * cos;
       float v2x = p.velx * cos;
       float v1y = vely * sin;
       float v2y = p.vely * sin;
       velx = v2x; 
       p.velx = v1x;
       vely = v1y; 
       p.vely = v2y;
       */
       return true;
     }
     return false;
   }
 }

 class Constructor {
  boolean eliminar, l1, l2;
  int ix, iy, dir, vel, time;
  Constructor(int ix, int iy, int dir) {
    this.ix = ix;
    this.iy = iy;
    this.dir = dir;
    time = 0;
    vel = 5;
    nivel.tiles[ix][iy] = 1;
    l1 = l2 = true;
  }
  void act() {
    time++;
    if (time%vel == 0) {
      int incx = 0;
      int incy = 0;
      if (dir == 0)
        incx = time/vel;
      else
        incy = time/vel;
      if (l1) {
        int x = ix-incx;
        int y = iy-incy;
        if (x >= 0 && y >= 0 && nivel.tiles[x][y] == 0) {
          boolean choca = false;
          for (int i = 0; i < pelotas.size(); i++) {
            Pelota aux = pelotas.get(i);
            int xx = 0; 
            int yy = 40; 
            int tam = nivel.tam;
            if (colisionRect(aux.x, aux.y, aux.tam, aux.tam, xx+x*tam+tam/2, yy+y*tam+tam/2, tam, tam)) {
              choca = true;
            }
          }
          if (choca)
            l1 = false; 
          else
            nivel.tiles[ix-incx][iy-incy] = 1;
        } 
        else 
          l1 = false;
      }
      if (l2) {
        int x = ix+incx;
        int y = iy+incy;
        if (x < nivel.w && y < nivel.h && nivel.tiles[x][y] == 0) {
          boolean choca = false;
          for (int i = 0; i < pelotas.size(); i++) {
            Pelota aux = pelotas.get(i);
            int xx = 0; 
            int yy = 40; 
            int tam = nivel.tam;
            if (colisionRect(aux.x, aux.y, aux.tam, aux.tam, xx+x*tam+tam/2, yy+y*tam+tam/2, tam, tam)) {
              choca = true;
            }
          }
          if (choca)
            l2 = false; 
          else
            nivel.tiles[x][y] = 1;
        }
        else 
          l2 = false;
      }
      if (!l1 && !l2) {
        eliminar = true;
      }
    }
    dibujar();
  }
  void dibujar() {
    fill(#5475BC);
    ellipse(ix*20+10, iy*20+10+40, 18, 18);
  }
}

boolean colisionRect(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
  float disX = w1/2 + w2/2;
  float disY = h1/2 + h2/2;
  if (abs(x1 - x2) < disX && abs(y1 - y2) < disY) {
    return true;
  }  
  return false;
}
