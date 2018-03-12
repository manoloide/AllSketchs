bichito b; 
String comando = "ingrese numeros de 3 a 5 caracteres";

void setup() {
  size(400, 400);
  smooth();
  textAlign(CENTER);
}

void draw() {
  background(0);
  if (b != null) {
    b.act();
  }
  fill(255, 200);
  text(comando, width/2, height/2);
}



void keyPressed() {
  if (comando.length() >= 10) {
    comando = "";
    textSize(56);
  }
  if (key == '\n' && comando.length() >= 3) {
    b = new bichito(width/2, height/2, int(comando));
    comando = "";
  } 
  else if (keyCode == BACKSPACE) {
    int lar = comando.length();
    if (lar > 0) {
      comando = comando.substring(0, lar-1);
    }
  }
  else if (key >= '0' && key <= '9' && comando.length() < 5) {
    comando += key;
  }
}


class bichito {
  int num, puntas, tam;
  float x, y, d;
  color col;
  bichito(float nx, float ny, int n) {
    num = n;
    x = nx;
    y = ny;
    puntas = sumaDigitos(num)+2;
    tam = sumatoria(num)%(width-100);
    col = color(((num/100)%10)*25.6, ((num/10)%10)*25.6, (num%10)*25.6);
    d = tam/bits(num);
  }
  void act() {
    fill(col);
    beginShape();
    float rota = TWO_PI/puntas;
    for (int i = 0; i < puntas; i++) {
      vertex(x+cos(rota*i)*tam/2, y+sin(rota*i)*tam/2);
      vertex(x+cos(rota*i+rota/2)*(tam/2-d), y+sin(rota*i+rota/2)*(tam/2-d));
    }
    endShape(CLOSE);
  }
}

