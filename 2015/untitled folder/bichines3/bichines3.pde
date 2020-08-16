ArrayList<Rupel> rupeles;

PFont font80;
int paleta[] = {
      -11578785,
      -305294,
      -16602,
      -5184480,
      -5970753
};

int paleta2[] = new int[2];

void setup() {
  size(800, 600);
  font80 = createFont("Exo-Bold", 80, true);
  thread("generar");
}

void draw() {
  //background(80);
  /*
    for (int j = 0; j < 100; j++) {
   for (int i = 0; i < rupeles.size (); i++) {
   Rupel r = rupeles.get(i);
   r.update();
   if (r.remove) rupeles.remove(i--);
   }
   }
   */
}

void keyPressed() {
  if (key == 's') saveImage();
  if (key == 'n') noiseee(8);
  if (key == 'g') thread("generar");
}

void mousePressed() {
  for (int i = 0; i < 10; i++) {
    rupeles.add(new Rupel(mouseX, mouseY));
  }
}

void generar() {

  color bac = rcol();
  PImage back = gradient(width, height, color(rcol()), color(rcol()));
  background(bac);
  ArrayList<Particle> points = new ArrayList<Particle>();
  for (int c = 0; c < 100; c++) {
    noStroke();
    /*
    fill(bac, 16);
     rect(0, 0, width, height);
     */

    tint(255, 36);
    image(back, 0, 0);
    noTint();
    for (int i = 0; i < 10; i++) {
      points.add(new Particle(random(width), random(height)));
    }
    for (int i = 0; i < points.size (); i++) {
      Particle p = points.get(i);
      p.update();
    }
  }
  //filter(BLUR, 1);
  /*
  for(int i = 0; i < 24; i++){
   float x = cos(random(PI))*width/2+width/2;//random(width); 
   float y = cos(random(PI))*height/2+height/2;
   float d = random(5, 200);
   color col = rcol();
   stroke(col);
   strokeWeight(d*0.1);
   line(x, y, x, y-height);
   noStroke();
   fill(col);
   ellipse(x, y, d, d);
   }*/

  for (int i = 0; i < paleta2.length; i++) {
    paleta2[i] = rcol();
  }
  rupeles = new ArrayList<Rupel>();
  stroke(254, 40);
  fill(254, 60);
  strokeWeight(1);
  int des = int(random(2, 5));
  for (int i = (int)-random (des); i < width+height; i+=des) {
    line(-2, i, i, -2);
  }

  for (int c = 0; c < 8; c++) {
    //noiseee(-8);
    for (int i = 0; i < 80; i++) {
      rupeles.add(new Rupel(width/2, height/2));
    }

    while (rupeles.size () > 0) {
      for (int i = 0; i < rupeles.size (); i++) {
        Rupel r = rupeles.get(i);
        r.update();
        if (r.remove) rupeles.remove(i--);
      }
    }
  }
   
   /*
  for (int i = 0; i < 10; i++) {
    int w = (int)pow(8, int(random(1, 3)));
    int h = (int)pow(8, int(random(1, 3)));
    int x = int(random((width-w)/8))*8;
    int y = int(random((height-h)/8))*8; 
    invert(g, x, y, w, h);
  }
  */

  String palabras[] = {
    "inovacion", "vanguardia", "games", "fanny", "concentracion", "felicidad"
  };

  /*
  textAlign(LEFT, TOP);
   textFont(font80);
   fill(250);
   text("Wannabe", 80, 80);
   */

  float dis = 1.2;
  displace(g, random(-dis, dis), random(-dis, dis), random(-dis, dis));
  /*  
   stroke(255, 30);
   fill(255, 20);
   */
  /*
  for (int j = 0; j < 120; j++) {
   float x = random(width);
   float y = random(height);
   float t = random(10, 120);
   stroke(0, 5);
   noFill();
   for(float i = 0.2; i <= 1; i+=0.2){
   strokeWeight(5*i);
   rect(x, y, t, t, t/2, t/2, t/2, 0);
   }
   fill(120);
   noStroke();
   rectMode(CENTER);
   rect(x, y, t, t, t/2, t/2, t/2, 0);
   fill(240);
   ellipse(x, y+t*0.4, t*0.05, t*0.05);
   }*/
}

void displace(PGraphics ori, float dr, float dg, float db) {
  PImage aux = createImage(ori.width, ori.height, RGB);
  //aux.copy(ori, 0, 0, ori.width, ori.height, 0, 0, ori.width, ori.height);
  aux.loadPixels();
  for (int j = 0; j < ori.height; j++) {
    for (int i = 0; i < ori.width; i++) {
      float r = red(ori.get(int(i+dr), int(j+dr)));
      float g = green(ori.get(int(i+dg), int(j+dg)));
      float b = blue(ori.get(int(i+db), int(j+db)));
      color col = color(r, g, b);
      aux.set(i, j, col);
    }
  }
  aux.updatePixels();
  ori.image(aux, 0, 0);
}


void invert(PGraphics ori, int x, int y, int w, int h) {
  PImage aux = createImage(w, h, RGB);
  //aux.copy(ori, 0, 0, ori.width, ori.height, 0, 0, ori.width, ori.height);
  aux.loadPixels();
  for (int j = 0; j < w; j++) {
    for (int i = 0; i < h; i++) {
      color col = ori.get(x+i, y+(h-1-j));
      aux.set(i, j, col);
    }
  }
  aux.updatePixels();
  ori.image(aux, x, y);
}

void noiseee(float val) {
  for (int j = 0; j < height; j++) {
    for (int i = 0; i < width; i++) {
      color col = get(i, j); 
      float bri = random(val);
      set(i, j, color(red(col)+bri, green(col)+bri, blue(col)+bri));
    }
  }
}

void saveImage() {
  int n = (new File(sketchPath)).listFiles().length-2;
  saveFrame(nf(n, 4)+".png");
}

PImage gradient(int w, int h, color c1, color c2) {
  PImage aux = createImage(w, h, RGB);
  aux.loadPixels();
  for (int j = 0; j < h; j++) {
    color col = lerpColor(c1, c2, j*1./h);
    for (int i = 0; i < w; i++) {
      aux.set(i, j, col);
    }
  }
  aux.updatePixels();
  return aux;
}

class Particula {
  color col;
  float x, y, ang, vel;
  Particula(float x, float y) {
    this.x = x;
    this.y = y;
    ang = random(TWO_PI);
  }
  void update() {
    x *= cos(ang)*vel;
    y *= sin(ang)*vel;
    vel = random(0.2, 0.8);

    fill(col);
    ellipse(x, y, 2, 2);
  }
}

class Rupel {
  boolean remove;
  color col;
  float x, y, d, ang, da;
  float velx, vely, vel, des;
  int c;
  Rupel(float x, float y) {
    this.x = x;
    this.y = y;
    d = random(40, 120);
    ang = random(TWO_PI);
    c = int(random(3, 10));
    vel = random(0.1, 1);
    da = random(TWO_PI);
    col = color(lerpColor(rcol(), rcol(), random(1)));
    col = paleta2[int(random(paleta2.length))];
    des = random(0.001, 0.08);
  }

  void update() {
    float dis = dist(mouseX, mouseY, x, y);
    if (dis < d*0.5) {
      float ang = atan2(y-mouseY, x-mouseX);
      velx += cos(ang)*dis*0.1;
      vely += sin(ang)*dis*0.1;
    }
    velx *= 0.9;
    vely *= 0.9;
    da += random(-0.2, 0.2);
    x += velx + cos(da)*vel;
    y += vely+ sin(da)*vel;
    ang += random(0.01, 0.1);
    d *= 1-(des*random(0.5, 1));
    if (d < 1) remove = true;
    show();
  }

  void show() {
    /*
    stroke(bri(col, 40), 120);
     fill(col, 100);
     stroke(0);
     fill(255);
     */
    stroke(col, 200);
    fill(bri(col, 180), 200);
    stroke(0, 120);
    fill(col);
    strokeWeight(d/60.);
    estrella(x, y, d, c, ang);
    if (random(10) < 0.8) {
      float aa = random(TWO_PI);
      float dd = log10(d+1);
      noStroke();
      fill(254, 80);
      ellipse(x+cos(aa)*d*0.9, y+sin(aa)*d*0.9, dd*1.18, dd*1.18);
      fill(254);
      ellipse(x+cos(aa)*d*0.9, y+sin(aa)*d*0.9, dd, dd);
    }
  }
}

class Particle {
  color col;
  float ax, ay, x, y;
  float ang, rot, vel;
  Particle(float x, float y) {
    this.x = ax = x;
    this.y = ay = y;
    ang = random(TWO_PI);
    col = rcol();
    rot = random(PI/4);
    vel = random(1, 4);
  }
  void update() {
    ang += random(-rot, rot);
    ax = x;
    ay = y;
    x += cos(ang)*vel;
    y += sin(ang)*vel;
    show();
  }

  void show() {
    stroke(col);
    line(ax, ay, x, y);
  }
}

float log10 (float x) {
  return (log(x) / log(10));
}

int rcol() {
  return paleta[(int)random(paleta.length)];
}

void estrella(float x, float y, float d, int c, float ang) {
  float r = d*0.5; 
  float da = TWO_PI/c;
  beginShape();
  for (int i = 0; i < c; i++) {
    vertex(x+cos(ang+da*i)*r, y+sin(ang+da*i)*r);
    float rr = r*0.2;
    vertex(x+cos(ang+da*i+da*0.5)*rr, y+sin(ang+da*i+da*0.5)*rr);
  }  
  endShape(CLOSE);
}

color bri(int col, float val) {
  return color(red(col)+val, green(col)+val, blue(col)+val, alpha(col));
}
