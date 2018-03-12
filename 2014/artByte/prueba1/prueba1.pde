String name;

void setup() {
  size(600, 600);
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveFrame(name+".png");
  if (key == 'a') selectInput("Abrir archivo:", "cargarArchivo");
}

void cargarArchivo(File f) {
  int pixeles;
  int tam = 200;
  if (f == null) return;
  byte bb[] = loadBytes(f.toString());
  pixeles = bb.length/3;
  tam = int(sqrt(pixeles)); 
  println(tam,f.toString());
  if(tam > 600) tam = 600;
  frame.setResizable(true);
  size(tam, tam);
  frame.setResizable(false);
  for (int j = 0; j < tam; j++) {
    for (int i = 0; i < tam; i++) {
      int pos = (j*3)*tam+(i*3);
      int r = bb[pos+0] & 0xff; 
      int g = bb[pos+1] & 0xff; 
      int b = bb[pos+2] & 0xff; 
      color col = color(r,g,b);   //<>//
      set(i, j, col);
    }
  }
}
