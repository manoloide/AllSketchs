Camara camara;
int w, h;
int[][] mapa; 

void setup() {
  size(800, 600);
  camara = new Camara(0, 0);
  w = h = 10;
  mapa = new int[w][h];
  for (int j = 0; j < h; j++) {
    for (int i = 0; i < w; i++) {
      mapa[i][j] = int(random(5));
    }
  }
}

void draw() {
  frame.setTitle("FPS: "+frameRate);
  background(0);
  camara.act();
  dibujarMapa();
}

class Camara {
  float x, y;
  Camara(float x, float y) {
    this.x = x;
    this.y = y;
  }
  void act() {
    float mx = (width/2.-mouseX)/(width/2);
    if (abs(mx) < 0.5) mx = 0;
    float my = (height/2.-mouseY)/(height/2);
    if (abs(my) < 0.5) my = 0;
    x += mx;
    y += my;
    translate(int(x), int(y));
  }
}
/*
 x = (j+i)/w;
 y = (i-j)/h;
 
 j = (x/w)-i;
 
 y = (i-((x/w)-1)/h
 y = (i*2-(x/w))/h
 
 i = (y*h+(x/w))/2;
*/

void dibujarMapa() {
  int tam = 64;
  int ww = tam;
  int hh = tam/2;
  noStroke();
  for (int j = 0; j < h; j++) {
    for (int i = 0; i < w; i++) {
      int x = (j+i)*ww/2;
      int y = (i-j)*hh/2;
      stroke(0);
      fill(40);
      rombo(x, y, ww, hh);
      noStroke();
      switch(mapa[i][j]) {
      case 0:
        fill(#4E5A72);
        break;
      case 1:
        fill(#8E6F6C);
        break;
      case 2:
        fill(#FF7076);
        break;
      case 3:
        fill(#FF876F);
        break;
      case 4:
        fill(#FCDF6A);
        break;
      }
      rombo(x, y, ww, hh);
      //ellipse(x, y, ww/2, hh/2);
    }
  }
  int mx = int((mouseX-camara.x+ww/2)/ww);
  int my = int((mouseY-camara.y+hh/2)/hh);
  int ix = int(my + mx);
  int iy = int(mx - my);
  stroke(0, 255, 0);
  noFill();
  rombo((ix+iy)*ww/2, (ix-iy)*hh/2, ww, hh);
  fill(0, 255, 0);
  text(ix+" "+iy+" "+mx+" "+my, mx*ww, my*hh);
}

void rombo(float x, float y, float w, float h) {
  beginShape();
  vertex(x-w/2, y);
  vertex(x, y-h/2);
  vertex(x+w/2, y);
  vertex(x, y+h/2);
  endShape(CLOSE);
}

