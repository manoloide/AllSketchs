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


int h = 3;

void setup() {
  size(800, 600);

  generar();
}

void draw() {
}
void mousePressed(){
  generar(); 
}

void generar() {
  noStroke();
  for (int y = 0; y < height; y+=h) {
    int x = 0;
    /*
    if (random(100) < 8) {
      int col = int(random(colores.length));
      fill(colores[col]);
      rect(x, y, width, h*2);
      y += h;   
      continue;
    }*/
    int col2 = int(y/(height/5));
    while (x < width) {
      int col = int(random(colores.length));
      int lar = h+col*h;//int(random(60)*h);
      fill(colores[col]);//lerpColor(colores[col],colores[col2],0.4));
      rect(x, y, lar, h);
      x += lar;
    }
  }
}
