int paleta[] = {
  #4D275E,
  #3EE0C2,
  #B8FF52,
  #FCD245,
  #FE8F2C
};

void setup() {
  size(800, 800);
  generar();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else generar();
}

void generar() {

  int capas = int(random(10)); 
  float ccc = random(2, 200);
  for (int i = 1;  i <= capas; i++) {
    int cc = int((capas-1)*ccc)+1;
    for (int j = 0; j < cc; j++) {  
      float tt = (width/pow(2, i-1));
      float xx = int(random(width/tt))*tt;
      float yy = int(random(height/tt))*tt;
      stroke(0, 2);
      noFill();
      for (int k = 6; k > 0; k--) {
        strokeWeight(k); 
        rect(xx, yy, tt, tt);
      }
      noStroke();
      fill(rcol());
      float r = random(10);
      if (r < 6) {
        rect(xx, yy, tt, tt);
      } else if(r < 8){
        fill(rcol());
        rect(xx, yy, tt, tt);
        fill(rcol());
        triangle(xx+tt, yy+tt, xx+tt, yy, xx, yy+tt);
      }else {
        fill(rcol());
        rect(xx, yy, tt, tt);
        fill(rcol());
        triangle(xx, yy, xx, yy+tt, xx+tt, yy+tt);
      }
    }
  }
}

void saveImage() {
  int n = (new File(sketchPath)).listFiles().length-1;
  saveFrame(nf(n, 4)+".png");
}

int rcol(){
   return paleta[int(random(paleta.length))]; 
}

