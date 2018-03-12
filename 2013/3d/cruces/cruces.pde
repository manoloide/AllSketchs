ArrayList<Cruz> cruces;

void setup() {
  size(400, 400, P3D); 
  frameRate(30);
  cruces = new ArrayList<Cruz>();
  for (int i = 0; i < 1000; i++) {
    cruces.add(new Cruz(random(-width, width), random(-height, height), random(-1000, 1000)));
  }
  noSmooth();
  background(0);
  stroke(255);
  fill(255);
  camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
}

void draw() {
  if (frameCount%800 < 0) {
    noStroke();
    for (int i = 0; i < 100; i++) {
      switch(int(random(3))) {
      case 0:
        fill(255, 0, 0);
        break;
      case 1:
        fill(0, 255, 0);
        break;
      case 2:
        fill( 0, 0, 255);
        break;
      }
      rect(int(random(width/4))*4, int(random(height/4))*4, 4, 4);
    }
  }
  else {
    translate(width/2,height/2, -height);
    background(0);
    rotateX(TWO_PI * ((frameCount%100)*1./100));
    rotateY(TWO_PI * ((frameCount%200)*1./200));
    rotateZ(TWO_PI * ((frameCount%354)*1./354));
    for (int i = 0; i < cruces.size(); i++) {
      Cruz a = cruces.get(i); 
      a.act();    
    }
  }
}

void mousePressed(){
   saveFrame("alalala###.png"); 
}

class Cruz {
  color col; 
  float x, y, z;
  int tam; 
  Cruz(float x, float y, float z) {
    this.x = x; 
    this.y = y; 
    this.z = z;
    tam = int(random(2,16));
    switch(int(random(3))) {
    case 0:
      col = color(255, 0, 0);
      break;
    case 1:
      col = color(0, 255, 0);
      break;
    case 2:
      col = color( 0, 0, 255);
      break;
    }
  }
  void act() {
    dibujar();
  }

  void dibujar() {
    stroke(col);
    line(x+tam, y, z, x-tam, y, z);
    line(x, y+tam, z, x, y-tam, z);
    line(x, y, z+tam, x, y, z-tam);
  }
}

