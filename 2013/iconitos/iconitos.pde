/*
int[] colores = {
 #63C0C9, 
 #B4E86F, 
 #FCF662, 
 #FE852E, 
 #FE3709
 };
 
 int[] colores = {
 #8400FF, 
 #C509F4, 
 #FC0ACB, 
 #FCD80A, 
 #FBEDF8
 };*/

int[] colores = {
  #D1FF19, 
  #FFB300, 
  #EC390E, 
  #5930FC, 
  #2B0018
};


int es= 1;
int t = 12; 
PImage iconos;

void setup() {
  size(851, 315);
  iconos = loadImage("iconos.png");
  generar();
  saveFrame("holis.png");
}

void draw() {
}
void mousePressed() {
  generar();
}

void generar() {
  noStroke();
  for (int y = 0; y < height; y+=t*es) {
    for (int x = 0; x < width; x+=t*es) {
      dibujarIcono(x, y, int(random(8)), es, colores[int(random(colores.length))], colores[int(random(colores.length))]);
    }
  }
}

void dibujarIcono(int x, int y, int sel, int es, int col1, int col2) {
  for (int j = 0; j < t; j++) {
    for (int i = 0; i < t; i++) {
      if(alpha(iconos.get(i+sel*t,j)) < 200){
        fill(col1);
        rect(x+i*es,y+j*es, t, t);
      }else{
        fill(col2);
        rect(x+i*es,y+j*es, t, t); 
      }
    }
  }
}
