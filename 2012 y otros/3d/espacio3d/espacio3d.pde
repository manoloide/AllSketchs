import java.awt.event.*;

ArrayList<Punto> puntos;
float ax, ay, px, py, zoom;

void setup() {
  size(800, 600, P3D);
  addMouseWheelListener(new MouseWheelListener() { 
    public void mouseWheelMoved(MouseWheelEvent mwe) { 
      mouseWheel(mwe.getWheelRotation());
    }
  }
  );

  puntos = new ArrayList<Punto>();
  for (int i = 0; i < 600; i++) {
    puntos.add(new Punto(random(-width, width), random(-height, height), random(-800, 800)));
  }
  puntos.add(new Punto(0, 0, 0));
}

void draw() {
   background(0);
  if (mousePressed) {
    ax -= (mouseY-pmouseY*1.)/100;
    ay += (mouseX-pmouseX*1.)/100;
  }
  translate(px, py, zoom);
  rotateX(ax);
  rotateY(ay);
  stroke(255);
  strokeWeight(2);
  for (int i = 0; i < puntos.size(); i++) {
    Punto aux = puntos.get(i);
    point(aux.x, aux.y, aux.z);
    for (int j = i+1; j < puntos.size(); j++) {
      Punto aux2 = puntos.get(j);
      if (dist(aux.x, aux.y, aux.z, aux2.x, aux2.y, aux2.z)<300) {
        line(aux.x, aux.y, aux.z, aux2.x, aux2.y, aux2.z);
      }
    }
  }
}

void keyPressed() {
  int vel = 4;
  if (keyCode == LEFT) {
    px += vel;
  } 
  else if (keyCode == RIGHT) {
    px -= vel;
  } 
  else if (keyCode == UP) {
    py += vel;
  } 
  else if (keyCode == DOWN) {
    py -= vel;
  }
}

void mouseWheel(int delta) {
  zoom -= delta*100;
}


class Punto {
  float x, y, z;
  Punto(float x, float y, float z) {
    this.x = x; 
    this.y = y;
    this.z = z;
  }
}

