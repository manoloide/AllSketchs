ArrayList<Pelota> pelotas;
Camara camara;
void setup() {
  size(800, 600, P3D); 
  smooth(8);
  camara = new Camara();
  pelotas = new ArrayList<Pelota>();
}


void draw() {
  camara.act();
  background(#BC1515);
  for(int i = 0; i < pelotas.size(); i++){
     Pelota p = pelotas.get(i); 
     p.update();
     if(p.eliminar) pelotas.remove(i--);
  }
}

void mousePressed(){
   pelotas.add(new Pelota(random(-width/2, width/2),random(-height/2, height/2), random(-1000))); 
   //pelotas.add(new Pelota(0,0,0)); 
}

class Pelota {
  boolean eliminar;
  float x, y, z, tam, time, timeMax;
  int cant;
  Pelota(float x, float y, float z) {
    this.x = x; 
    this.y = y;
    this.z = z;
    tam = random(80, 300)*2;
    time = 0;
    timeMax = int(random(120, 360));
    cant = int(random(4, 14));
  }
  void update() {
    time++;
    if (time > timeMax) eliminar = true;
    draw();
  }
  void draw() {
    float tt = map(time, 0, timeMax, 0, tam); 
    noFill();
    strokeWeight(tt/cant/2);
    pushMatrix();
    translate(x, y-tt/2, z);
    for (int i = 0; i < cant; i++) {
      float pos = (i+(frameCount%80)*1./80);
      float dy = (1./cant) * pos;
      float yy = tt * dy;
      float ttt = sqrt(yy*(tt-yy))*2;//cos(map(pos, 0, cant, PI/2, TWO_PI-PI/2))*tt;
      pushMatrix();
      translate(0, yy, 0);
      rotateX(PI/2);
      colorMode(HSB, 256);
      stroke(((i+frameCount*0.2)%cant)*256./cant, 200, 200);
      ellipse(0,0, ttt, ttt);
      popMatrix();
    }
    popMatrix();
  }
}

class Camara {
  float x, y, z, rotx, roty, vely;
  int time;
  Camara() {
    x = width/2;
    y = height/2;
    z = -100;
    rotx = -0.8046021;
    roty = 4.3054013;
  }
  void act() {
    rotx += cos(((frameCount%1000)/1000.) * TWO_PI)/-1000;
    roty += vely;
    time--;
    if (time <= 0) randomCam();
    translate(x, y, z);
    rotateX(rotx);
    rotateY(roty);
    //scale(map(frameCount,0,25*90,0.23,0.65));
  }
  void randomCam() {
    roty = random(TWO_PI); 
    rotx = random(PI*1.7, TWO_PI);
    vely = random(-0.005, 0.005);
    time = int(random(18, 100));
  }
}
