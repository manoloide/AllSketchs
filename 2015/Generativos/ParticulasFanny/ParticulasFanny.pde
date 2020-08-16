int paleta[] = {
  #7CFF27, 
  #555055, 
  #FC9E40
};

ArrayList<Particula> particulas;

void setup() {
  size(600, 600);
  particulas = new ArrayList<Particula>();  
  background(220);
  stroke(250); 
  float dd = (frameCount*0.2)%8;
  for (int i = -8; i < width+height; i+=8) {
    line(-2, i+dd, i+dd, -2);
  }
}

void draw() {
  boolean clear = true;
  if (clear) {
    background(220);
    stroke(250); 
    float dd = (frameCount*0.2)%8;
    for (int i = -8; i < width+height; i+=8) {
      line(-2, i+dd, i+dd, -2);
    }
  }

  if (mousePressed) {
    float dis = dist(mouseX, mouseY, pmouseX, pmouseY);
    for (int i = 0; i < 10; i++) {
      float r = random(0, 1.12);
      float aa = random(TWO_PI);
      float dd = random(dis);
      float xx = mouseX+cos(aa)*dd;
      float yy = mouseY+sin(aa)*dd;
      if (r < 1) particulas.add(new Cubito(xx, yy));
      else if (r < 1.05) particulas.add(new Cargador(xx, yy));
      else particulas.add(new Linea(xx, yy));
    }
  }

  for (int i = 0; i < particulas.size (); i++) {
    Particula p = particulas.get(i);
    p.update();
    if (p.remove) particulas.remove(i--);
  }
}

class Particula {
  boolean remove;
  color col;
  float x, y, ang;
  float initTime;
  Particula() {
    initTime = millis(); 
    ang = random(TWO_PI);
  }
  void update() {
  }

  void show() {
  }
}

class Cubito extends Particula {
  float tam, tt;
  float ace, vel;
  float time, lifeTime;
  Cubito(float x, float y) {
    super();
    this.x = x; 
    this.y = y;
    ace = random(0.01, 0.5);
    tam = random(1, 10);
    vel = random(2);
    col = color(paleta[int(random(paleta.length))]);
    lifeTime = random(2, 3);
  }
  void update() {
    time = (millis()-initTime)/1000;
    if (time < 1) {
      tt = tam*time;
    }
    if (time > lifeTime-1) {
      tt = tam*(time-lifeTime);
      if (time > lifeTime) remove = true;
    }
    ang += random(-0.1, 0.1)+(atan2(mouseY-y, mouseX-x)-ang)*0.02;
    float dis = dist(x, y, mouseX, mouseY);
    x += cos(ang)*vel*ace;
    y += sin(ang)*vel*ace;
    show();
  }
  void show() {
    pushStyle();
    noStroke();
    rectMode(CENTER); 
    fill(col, 220);
    rect(x, y, tt, tt);
    popStyle();
  }
}

class Cargador extends Particula {
  float tt, tam;
  float vel;
  float time, lifeTime;
  float carga, lfo, rot, velRot;
  Cargador(float x, float y) {
    super();
    this.x = x; 
    this.y = y;
    tam = random(5, 30);
    ang = PI*1.5;
    carga = random(PI/4, TWO_PI);
    rot = random(TWO_PI);
    velRot = random(0.01, 0.28);
    lfo = random(0.01, 0.2);
    col = color(paleta[int(random(paleta.length))]);
    lifeTime = random(2, 3);
    vel = random(0.4);
  }
  void update() {
    time = (millis()-initTime)/1000;
    if (time < 0.5) {
      tt = tam*time*2;
    }
    if (time > lifeTime-0.5) {
      tt = tam*(lifeTime-time);
      if (time >= lifeTime) remove = true;
    }

    rot += velRot;

    ang += random(-0.06, 0.06);
    x += cos(ang)*vel;
    y += sin(ang)*vel;
    show();
  }
  void show() {
    pushStyle();
    noStroke();
    fill(col);
    ellipse(x, y, tt, tt);
    stroke(246, 220);
    if (tt > 0)
      strokeWeight(tt*0.2);
    strokeCap(SQUARE);
    float cc = carga*(cos(time*lfo)*0.5+0.5);
    arc(x, y, tt*0.6, tt*0.6, rot, rot+cc);
    popStyle();
  }
}

class Linea extends Particula {
  float tam, tt, dir, vel;
  float time, lifeTime;
  Linea(float x, float y) {
    super();
    this.x = x; 
    this.y = y;
    tam = random(10, 50);
    dir = (random(10) < 5)? PI/4 : PI*0.75;
    ang = random(TWO_PI);
    vel = random(0.8);
    col = color(paleta[int(random(paleta.length))]);
    lifeTime = random(1, 2);
  }
  void update() {
    time = (millis()-initTime)/1000;
    if (time < 0.5) {
      tt = tam*sin(time*PI);
    }
    if (time > lifeTime-0.5) {
      tt = tam*sin(((lifeTime-time))*PI);
      if (time >= lifeTime) remove = true;
    }
    
    ang += random(-0.02, 0.02);
    x += cos(ang)*vel;
    y += sin(ang)*vel;

    show();
  }
  void show() {
    pushStyle();
    stroke(col);
    float dx = cos(dir)*tt;
    float dy = sin(dir)*tt;
    if (tt >= 0)
      strokeWeight(tt*0.04);
    strokeCap(SQUARE);
    line(x-dx, y-dy, x+dx, y+dy);
    popStyle();
  }
}

