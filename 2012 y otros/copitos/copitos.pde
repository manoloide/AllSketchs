int cant = 100;
int cx, cy;

ArrayList<Bicho> bichos;

void setup() {
  size(600, 400);
  //smooth(); 
  bichos = new ArrayList<Bicho>();
  for (int i = 0; i < cant; i++) {
    bichos.add(new Bicho(random(width), random(height)));
  }
  Collections.sort(bichos);
  noStroke();
}

void draw() {
  fill(0, 100);
  rect(0, 0, width, height);
  fill(255);
  for (int i = 0; i < bichos.size(); i++) {
    Bicho aux = bichos.get(i);
    aux.act(mousePressed);
  }
}

void mousePressed() {
  cx = mouseX;
  cy = mouseY;
  for (int i = 0; i < bichos.size(); i++) {
    Bicho aux = bichos.get(i);
    aux.setangclic();
  }
}

class Bicho implements Comparable {
  float x, y, tam, vel, ang, angclic;
  Bicho(float x, float y) {
    this.x = x;
    this.y = y;
    vel = random(0.5, 2);
    tam = 10*vel;
    ang = PI/4;
    angclic = 0;
  }

  void act(boolean c) {
    if (c) {
      float mx = width/2;
      float my = height/2;
      float dis = dist(x, y, mx, my);
      float angc = atan2(y-mx, x-my)+atan2(mouseY-my, mouseX-mx)-angclic;
      float a = atan2(y-cy, x-cx)+angc;
      x = cx + cos(a)*dis;
      y = cy + sin(a)*dis;
    }
    else {
      mover();
    }
    ellipse(x, y, tam, tam);
  }

  void setangclic() {
    float mx = width/2;
    float my = height/2;
    angclic = atan2(mouseY-my, mouseX-mx);
  }

  void mover() {
    if (x < -tam) x = width +tam;
    else {
      x = (x > width +tam) ? -tam : x+cos(ang)*vel;
    }
    if (y < -tam) y = height +tam;
    else {
      y = (y > height +tam) ? -tam : y+sin(ang)*vel;
    }
  }

  public int compareTo(Object object) { 
    int res = 0;  
    Bicho b = (Bicho)object; 
    if (this.vel < b.vel) { 
      res = -1;
    }
    else if (this.vel > b.vel) { 
      res = 1;
    }
    return res;
  }
} 

