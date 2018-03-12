import manoloide.Input.Input; //<>//

Input input;
Pelota p;

void setup() {
  size(800, 600);
  input = new Input(this);
  p = new Pelota(width/2, height/2, 30, width/2, height/2, 300);
}

void draw() {
  background(255);
  p.act();
  input.act();
}

void mousePressed() {
  input.mpress();
}

void mouseReleased() {
  input.mreleased();
}
class Pelota {
  boolean mover;
  float pelota_x, pelota_y, pelota_tam, centro_x, centro_y, ace_x, ace_y;
  float ang, dist;
  float largo;
  Pelota(float px, float py, float pt, float cx, float cy, float lar) {
    pelota_x = px;
    pelota_y = py;
    pelota_tam = pt;
    centro_x = cx;
    centro_y = cy;
    largo = lar;
    ang = atan2(pelota_y-centro_y, pelota_x-centro_x);
    dist = dist(pelota_x, pelota_y, centro_x, centro_y);
  }
  void act() {
    if (input.click && dist(mouseX, mouseY, pelota_x, pelota_y) < pelota_tam/2) {
      mover = true;
    }
    if (input.released) {
      mover = false;
    }
    ang = atan2(pelota_y-centro_y, pelota_x-centro_x);
    dist = dist(pelota_x, pelota_y, centro_x, centro_y);
    float ant_x = pelota_x;
    float ant_Y = pelota_y;
    if (mover) {
      pelota_x = mouseX;
      pelota_y = mouseY;
      if (dist(mouseX, mouseY, centro_x, centro_y) > largo/2) {
        ang = atan2(pelota_y-centro_y, pelota_x-centro_x);
        pelota_x = centro_x+cos(ang)*largo/2;
        pelota_y = centro_y+sin(ang)*largo/2;
      }
    }
    else {
      ace_y += 0.01;
      if(dist < largo/2){
        
      }
    }

    dibujar();
  }
  void dibujar() {
    strokeWeight(0.5);
    stroke(0);
    noFill();
    ellipse(centro_x, centro_y, largo, largo);
    strokeWeight(2);
    stroke(0);
    float d = map(dist, 0, largo/2, 1, 0);
    float a1 = map(centro_x-pelota_x, -largo/2, largo/2, PI, 0);
    float a2 = map(centro_x-pelota_x, -largo/2, largo/2, 0, PI);
    ellipse(pelota_x+cos(a1)*(largo/2)*d, pelota_y+sin(a1)*(largo/2)*d, 5, 5);
    ellipse(centro_x+cos(a2)*(largo/2)*d, centro_y+sin(a2)*(largo/2)*d, 5, 5);
    bezier(pelota_x, pelota_y, pelota_x+cos(a1)*(largo/2)*d, pelota_y+sin(a1)*(largo/2)*d, centro_x, centro_y, centro_x, centro_y);
    noStroke();
    fill(0);
    noStroke();
    ellipse(centro_x, centro_y, 5, 5);
    ellipse(pelota_x, pelota_y, pelota_tam, pelota_tam);
  }
}
