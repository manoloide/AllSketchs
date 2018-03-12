String palabras[] = {
  "hola", "pepe", "señor", 
  "dios", "pepuso", "golondrina", "sangre", "arbol", "hoja", "salto"
};

void setup() {
  size(400, 400);
  background(0);
  for (int i = 0; i < palabras.length; i++) {
    text(palabras[i], 20, 40+30*i);
  }
}

void draw() {
}

void mousePressed() {
  background(0);
  for (int i = 1; i < palabras.length; i+=2) {
    text(palabras[i], 20, 40+15*i);
  }
}

