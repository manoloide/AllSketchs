import manoloide.Color.Paleta;

Paleta paleta;

void setup() {
  size(1000, 600);
  paleta = new Paleta();
  paleta.load(sketchPath("tea.plt"));
  thread("generar");
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveFrame("#####");
  else thread("generar");;
}

void generar() {
  background(paleta.rcol());
  int bordes = int(random(4, 12))*2;
  int tam = int(random(4, 10));
  int cx = (width-bordes*2)/tam;
  int sw = ((width-bordes*2)-cx*tam)/(cx-1);
  int cy = (height-bordes*2)/tam;
  int sh = ((height-bordes*2)-cy*tam)/(cy-1);
  noStroke();
  for (int j = 0; j < cy; j++) {
    for (int i = 0; i < cx; i++) {
      float x = bordes+tam/2+(tam+sw)*i; 
      float y = bordes+tam/2+(tam+sh)*j;
      float ang = random(TWO_PI);
      int cant = int(random(2, 12));
      float da = TWO_PI/cant;
      for (int k = 0; k < cant; k++) {
        fill(paleta.rcol());
        arc(x, y, tam, tam, (ang+da*k), (ang+da*(k+1)));
      }
    }
  }
}
