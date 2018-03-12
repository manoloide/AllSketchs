float tam = 50;
float h = sqrt(pow(tam/2, 2)-pow(tam/4, 2))*2;
float h2 = tam*0.25;
int mw = 100, mh = 100, md = 100;
Tile[][][] mapa = new Tile[mw][mh][md];
void setup() {
  size(800, 600);
  colorMode(HSB,256);
  noStroke();
  background(0);
  for (int i = 0; i < 100; i++) {
    //mapa[i][i][i] = new Tile(color(random(256),random(200,256),random(100,256)));
  }
  //cuboCubo(mapa, 40, 40, 40, 20, color(30, 80, 80));
  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 8; j++) {
      //mapa[0][j][0] = new Tile(color(0.5*i, 10*j, 200));
      
      mapa[i][j][0] = new Tile(color(15*(j+i*0.53), 200, 200));
      mapa[i][7][j] = new Tile(color(20, 120+10*j, 200));
      mapa[0][i][j] = new Tile(color(200+5*(j+i*0.53), 200, 200));
      
    }
  }
}

void draw() {
  if(frameCount%10 == 0)
  frame.setTitle("FPS: "+frameRate);  
  background(30, 26, 40);
  //mapa[int(random(2, 6))][0][int(random(2, 6))] = new Tile(color(random(256), random(200, 256), random(100, 256)));  
  dibujarMapa(mapa);
  /*
  for (int j = letras.length-1; j >= 0 ; j--) {  
   for (int i = letras[0].length-1; i >= 0 ; i--) {
   float x = (i) *(h /2); 
   float y = (j)*(h2)-(i*h2/2);
   if ((y/h2)%2 == 0) {
   //x += h/2;
   }
   if (letras[j][i] == 1) {
   cubo(x+posx-(h /2)*count, y+posy-h2/2*count, tam, col);
   }
   }
   }*/
}

void mousePressed() {
  saveFrame("adas####.png");
}

void dibujarMapa(Tile[][][] mapa) {
  for (int j = mh-1; j >= 0; j--) {
    for (int k = 0; k < md; k++) {
      for (int i = 0; i < mw; i++) {
        Tile t = mapa[i][j][k]; 
        if (t != null) {
          cubo((i-k) *(-h /2)+width/2, (k+i+j*2)*(h2)+40, tam, t.col);
        }
      }
    }
  }
}

class Tile {
  color col;
  Tile(color col) {
    this.col = col;
  }
}

void cuboCubo(Tile[][][] mapa, int x, int y, int d, int tam, color col) {
  for (int i = 0; i < tam; i++) {
    mapa[x+tam-1][y+i][d-i] = new Tile(col); 
    mapa[x+tam-1+i][y+i][d+i] = new Tile(col); 
    mapa[x+i][y+i][d+i] = new Tile(col);  
    mapa[x+i][y+i+tam-1][d+i] = new Tile(col); 
    mapa[x+i+tam-1][y+i+tam-1][d+i] = new Tile(col);  
    mapa[x+i][y+tam-1][d-i] = new Tile(col);
    mapa[x+i][y][d-i] = new Tile(col);
    mapa[x][y+i][d-i] = new Tile(col);
  }
}

void cubo(float x, float y, float tam, color col) {
  tam = tam/2;
  float a = TWO_PI/6;
  float d = TWO_PI/12+PI;
  pushStyle();
  colorMode(HSB);
  noStroke();
  //strokeWeight(2);
  //stroke(col);
  //stroke(255);
  //stroke(hue(col), saturation(col)+5, brightness(col)+15);
  fill(hue(col), saturation(col)+10, brightness(col)+20);
  quad(x, y, x+cos(a*0+d)*tam, y+sin(a*0+d)*tam, x+cos(a*1+d)*tam, y+sin(a*1+d)*tam, x+cos(a*2+d)*tam, y+sin(a*2+d)*tam);
  fill(col);
  quad(x, y, x+cos(a*2+d)*tam, y+sin(a*2+d)*tam, x+cos(a*3+d)*tam, y+sin(a*3+d)*tam, x+cos(a*4+d)*tam, y+sin(a*4+d)*tam);
  fill(hue(col), saturation(col)+10, brightness(col)-20);
  quad(x, y, x+cos(a*4+d)*tam, y+sin(a*4+d)*tam, x+cos(a*5+d)*tam, y+sin(a*5+d)*tam, x+cos(d)*tam, y+sin(d)*tam);
  popStyle();
}
