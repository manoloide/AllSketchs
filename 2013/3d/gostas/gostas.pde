ArrayList<Gota> gotas;

void setup() {
  size(800, 600, P3D); 
  gotas = new ArrayList<Gota>();
  for (int i = 0; i < 1000; i++) {
    gotas.add(new Gota(random(-width, width), random(-height, height), random(-2000, 1000)));
  }
  noSmooth();
  background(0);
}

void draw() {
  translate(width/2, height/2, 0);
  background(0);
  for (int i = 0; i < gotas.size(); i++) {
    Gota a = gotas.get(i); 
    a.act();
  }
}

class Gota {
  color col; 
  float x, y, z, ang;
  int tam; 
  Gota(float x, float y, float z) {
    this.x = x; 
    this.y = y; 
    this.z = z;
    ang = random(TWO_PI);
    tam = int(random(2, 16));
    tam = 8;
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
    ang += random(-0.1,0.1);
    x += cos(ang)*0.2;
    y -= sin(ang)*0.2;
    
    z+=5;
    if(z > 600){
       z = -2000; 
    }
    dibujar();
  }

  void dibujar() {
    stroke(col);
    noFill();
    rect(x-tam/2,y-tam/2,tam,tam);
    line(x-tam/2,y-tam/2,z,x+tam/2,y-tam/2,z);
    line(x+tam/2,y-tam/2,z,x+tam/2,y+tam/2,z);
    line(x+tam/2,y+tam/2,z,x-tam/2,y+tam/2,z);
    line(x-tam/2,y+tam/2,z,x-tam/2,y-tam/2,z);

    //line(x+tam, y, z, x-tam, y, z);
    //line(x, y+tam, z, x, y-tam, z);
    //line(x, y, z+tam, x, y, z-tam);
    
  }
}

