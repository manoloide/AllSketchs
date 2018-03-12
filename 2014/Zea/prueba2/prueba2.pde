ArrayList<Pasto> pastos;
PFont helve;
PGraphics mask; 
String texto;

void setup() {
  size(800, 450);
  frameRate(24);
  helve = createFont("Helvetica Neue Bold", 180, true);
  texto = "ZEA";
  mask = createGraphics(width, height);
  randomSeed(10);
  pastos = new ArrayList<Pasto>();
}

void draw() {
  for (int i = 0; i < 400; i++) {
    float x = random(width);
    float y = random(height);
    if (brightness(mask.get(int(x), int(y))) > 240) {
      pastos.add(new Pasto(x, y));
    }
  }
  mask.beginDraw();
  mask.background(0);
  mask.fill(255);
  mask.textAlign(CENTER, CENTER);
  mask.textFont(helve);
  mask.text(texto, width/2, height/2);
  mask.endDraw();
  background(0);
  //image(mask, 0, 0);
  for (int i = 0; i < pastos.size(); i++) {
    Pasto p = pastos.get(i); 
    p.update();
    if (p.eliminar) pastos.remove(i--);
  }
}


class Pasto {
  boolean eliminar, nace;
  float x, y, tam, vel, ang, tam_max; 
  Pasto(float x, float y) {
    this.x = x;
    this.y = y;
    tam_max = random(2, 6);
    tam = 0;
    vel = random(0.05, 0.4);
    ang = random(TWO_PI);
    nace = true;
  }
  void update() {
    ang += random(-0.2, 0.2);
    y -= vel;
    x += cos(ang)*vel*0.8;
    y += sin(ang)*vel*0.8;
    if (nace) {
      tam += 0.2;
      if(tam >= tam_max) nace = false;
    }
    else {
      tam *= 0.98;
    }
    if (brightness(mask.get(int(x), int(y))) < 240){
      nace = false;
      tam *= 0.9;
    }else if(tam > 0){
      if(brightness(mask.get(int(x-tam/2), int(y))) < 240){
        tam -= 0.2;
      }
      if(brightness(mask.get(int(x), int(y-tam/2))) < 240){
        tam -= 0.2;
      }
      if(brightness(mask.get(int(x+tam/2), int(y))) < 240){
        tam -= 0.2;
      }
      if(brightness(mask.get(int(x), int(y+tam/2))) < 240){
        tam -= 0.2;
      }
    }
    if (tam < 0.2 && nace == false) eliminar = true;
    draw();
  }

  void draw() {
    noStroke();
    fill(255);
    ellipse(x, y, tam, tam);
  }
}

