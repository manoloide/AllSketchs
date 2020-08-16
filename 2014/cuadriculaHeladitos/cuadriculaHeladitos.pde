int paleta [] = {
   #F6A8A8,
   #FFF7EB,
   #EBAD6B,
   #A87A5C,
   #402A26
};

void setup() {
  size(600, 600);
  generar();
}


void draw() {
}

void keyPressed() {
  if (key == 's') saveFrame();
  else generar();
}
void generar() {
  int tt = 100;
  int cw = width/tt;
  int ch = height/tt;
  fill(#FFF7EB);
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
        noStroke();
      rect(i*tt, j*tt, tt, tt);
      int dir = int(random(4));
      int tts = 200;
      int col = rcol();
      for(int k = 0; k < tts; k++){
          stroke(col, (tts-k)*0.35);
          if(dir == 0) line(i*tt+k, j*tt, i*tt+k, j*tt+tt);
          if(dir == 1) line(i*tt+tt-k, j*tt, i*tt+tt-k, j*tt+tt);
          
          if(dir == 2) line(i*tt, j*tt+k, i*tt+tt, j*tt+k);
          if(dir == 3) line(i*tt, j*tt+tt-k, i*tt+tt, j*tt+tt-k);
      }
    }
  }
}

int rcol(){
   return paleta[int(random(paleta.length))]; 
}
