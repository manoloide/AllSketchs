import java.awt.event.*;

int mapa[][];
int tam = 20;
int cant = 20;
int alejar = -200;
int altura = 10;

void setup() {
  size(400, 400, P3D);
  noStroke();
  mapa = new int[cant][cant];
  for (int j = 0; j < cant; j++) {
    for (int i = 0; i < cant; i++) {
      mapa[i][j] = int(random(5)+1);
    }
  }
  //rueda del mouse
  addMouseWheelListener(new MouseWheelListener() { 
    public void mouseWheelMoved(MouseWheelEvent mwe) { 
      mouseWheel(mwe.getWheelRotation());
    }
  }
  );
}

void draw() {
  background(0);
  translate(width/2, height/2, alejar);
  rotateX(map(mouseY, 0, height, PI*3/2, TWO_PI));
  rotateY(map(mouseX, 0, width, 0, TWO_PI));
  for (int j = 0; j < cant; j++) {
    float valorZ = tam*(j-(cant/2))+tam/2;
    for (int i = 0; i < cant; i++) {
      pushMatrix();
      float valorX = tam*(i-(cant/2))+tam/2; 
      translate(valorX, -altura*(mapa[i][j]/2.0), valorZ);
      fill(map(mapa[i][j], 1, 5, 100, 200));
      box(tam, altura*mapa[i][j], tam);
      popMatrix();
    }
  }
}

void mouseWheel(int delta) {
  alejar-=delta*10;
}
 
