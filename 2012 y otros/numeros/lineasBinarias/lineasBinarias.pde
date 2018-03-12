int numero, col;
float tam; 
String lineas = "";
String comando = "ingrese un numero";

void setup() {
  size(400, 400);
  noStroke();
  textAlign(CENTER);
  colorMode(HSB);
}

void draw() {
  background((col+128)%256, 256, 256);
  fill(col, 256, 256);
  for (int i = 0; i < lineas.length(); i++) {
    if (lineas.charAt(i) == '1') {
      rect(tam*i, 0, tam, height);
    }
  }
  fill(0, 200);
  text(comando, width/2, height/2);
}



void keyPressed() {
  if (comando.length() >= 10) {
    comando = "";
    textSize(56);
  }
  if (key == '\n' && comando.length() >= 1) {
    numero = int(comando);
    lineas = binario(numero);
    col = int(map(sumaDigitos(numero),0,9,0,256));
    tam = width*1./lineas.length();
    comando = "";
  } 
  else if (keyCode == BACKSPACE) {
    int lar = comando.length();
    if (lar > 0) {
      comando = comando.substring(0, lar-1);
    }
  }
  else if (key >= '0' && key <= '9') {
    comando += key;
  }
}

String binario(int num) {
  String bi = "";
  if (num == 0) {
    return "0";
  }
  while (num != 0) {
    bi = (num%2)+bi;
    num = num/2;
  }
  return bi;
}

int sumaDigitos(int num) {
  int suma = int(num/10)+(num%10);
  if (num >= 10) {
    suma = sumaDigitos(suma);
  }
  return suma;
}

