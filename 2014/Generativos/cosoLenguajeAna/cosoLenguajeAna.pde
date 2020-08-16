color paleta[];
int tam = 10;

void setup() {
  size(800, 600);
  noStroke();
  rectMode(CENTER);
  /*
  paleta = new color[4];
   paleta[0] = color(#2A3A71);
   paleta[1] = color(#2C3348);
   paleta[2] = color(#FFD136);
   paleta[3] = color(#EAE8DF);
   */
  thread("generar");
}

void draw() {
  //if (random(100) < 1) thread("generar");
}

void keyPressed() {
  if (key == 's') saveFrame("######.png");
  else thread("generar");
}

void generar() {
  coloresRand();
  background(colrad());
  tam = width/int(random(5, 50));
  int w = width/tam;
  int h = height/tam;
  for (int j = 0; j < h; j++) {
    for (int i = 0; i < w; i++) {
      float a1 = int(random(8))*PI/2;
      float a2 = a1+int(random(1, 9))*PI/2;
      float x = tam/2+i*tam;
      float y = tam/2+j*tam;
      boolean arcs = (random(1) < 0.9)? true : false;
      boolean rects = (random(1) < 0.2)? true : false;
      boolean soles = (random(1) < 0.0)? true : false;
      int ccc = 5;//int(random(2, 10));
      for (int k = ccc; k > 1; k--) {
        fill(colrad()); 
        if (rects)
          rect(x, y, (tam/ccc)*k, (tam/ccc)*k);
        else {
          ellipse(x, y, (tam/ccc)*k, (tam/ccc)*k);
          noStroke();
          if (arcs) {
            fill(colrad()); 
            arc(x, y, (tam/ccc)*k, (tam/ccc)*k, a1, a2);
          }
        }
      }
      if (soles) {
        int cc = 2*(int(random(2, 8)));
        float da = TWO_PI/cc;
        for (int c = 0; c < cc; c++) {
          stroke(colrad());
          line(x, y, x+cos(c*da)*tam/2, y+sin(c*da)*tam/2);
        }
        noStroke();
      }
    }
  }
}

void coloresRand() {
  paleta = new color[int(random(3, 20))];
  paleta[0] = color(random(256), random(256), random(256));
  for (int i = 1; i < paleta.length; i++) {
    int r = int(random(4));
    switch(r) {
    case 0:
      paleta[i] = oscure(paleta[i-1], random(-50, 50));
      break;
    case 1:
      paleta[i] = hueCam(paleta[i-1], random(-50, 50));
      break;
    case 2:
      paleta[i] = oscure(paleta[i-1], random(-50, 50));
      break;
    case 3:
      paleta[i] = comple(paleta[i-1]);
      break;
    }
  }
}

color colrad() {
  return paleta[int(random(paleta.length))];
}

color comple(color ori) {
  pushStyle();
  colorMode(HSB, 256);
  color aux = color(hue(ori)+128, saturation(ori), brightness(ori));
  popStyle();
  return aux;
}

color oscure(color ori, float osc) {
  return color(red(ori)+osc, green(ori)+osc, blue(ori)+osc);
}

color hueCam(color ori, float h) {
  pushStyle();
  colorMode(HSB, 256);
  color aux = color((hue(ori)+h+256)%256, saturation(ori), brightness(ori));
  popStyle();
  return aux;
}

