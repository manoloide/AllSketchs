ArrayList<Paleta> paletas;

void setup() {
  size(600, 600);
  paletas = new ArrayList<Paleta>();
  paletas.add(new Paleta(#BE79DA, #C8F243, #FCE04B, #FF71EC, #FF2740));
  paletas.add(new Paleta(#5B7539, #756529, #D3DF39, #C95520, #8F1810));
  paletas.add(new Paleta(#6EDBD3, #F384BB, #80F28B, #80D7F2, #FC83B7));
  thread("generar");
}
void draw() {
}
void keyPressed() {
  if (key == 's') {
    saveFrame("#####");
    return;
  } 
  thread("generar");
}

void generar() {
  background(paletas.get(int(random(paletas.size()))).rcol());
  int cant = int(dist(0, 0, width, height)/5);
  strokeWeight(0.5);
  for (int i = 0; i < cant; i++) {
    stroke(0, 10);
    line(i*10-10, -10, -10, i*10-10);
    stroke(255, 20);
    line(i*10-11, -11, -11, i*10-11);
  }
  float x = width/2;
  float y = height/2;
  float max_dim = width-40;
  noFill();
  strokeCap(SQUARE);
  Paleta p = paletas.get(int(random(paletas.size())));
  for (int i = 0; i < 60; i++) {
    float rl = random(1, 50);
    strokeWeight(rl);
    stroke(p.rcol(), random(120, 255));
    float dim = random(rl, max_dim);
    arc(x, y, dim, dim, PI, TWO_PI);
  }
  cant = int(random(4));
  noStroke();
  for (int i = 0; i < cant; i++) {
    float tam = random(100);
    float dis = random(tam/2+10, max_dim/2-tam/2);
    float ang = TWO_PI-(PI/4)*(random(3)+1);
    float xx = x+cos(ang)*dis;
    float yy = y+sin(ang)*dis;
    while (tam > 0) {
      fill(p.rcol());
      ellipse(xx, yy, tam, tam);
      tam -= random(4, 20);
    }
  }
  
  for (int i = 0; i < 20; i++) {
    color col = p.rcol();
    float tam = random(1, 4);
    float alp = 240;//random(2, 40);
    float xx = random(width);
    float yy = random(0, height/2);
    noStroke();
    fill(col, alp);
    ellipse(xx, yy, tam, tam);
  }

  noFill();
  strokeCap(SQUARE);
  p = paletas.get(int(random(paletas.size())));
  for (int i = 0; i < 60; i++) {
    float rl = random(1, 50);
    strokeWeight(rl);
    stroke(p.rcol(), random(80, 240));
    float dim = random(rl, width-40);
    arc(x, y, dim, dim, 0, PI);
  }

  cant = int(random(4));
  strokeWeight(1);
  for (int i = 0; i < cant; i++) {
    float tam = random(30, 100);
    float dis = random(tam/2+10, max_dim/2-tam/2);
    float ang = (PI/4)*(random(3)+1);
    float xx = x+cos(ang)*dis;
    float yy = y+sin(ang)*dis;
    stroke(p.rcol());
    //line(x, y, xx, yy);
    noStroke();
    while (tam > 0) {
      fill(p.rcol());
      ellipse(xx, yy, tam, tam);
      tam -= random(4, 16);
    }
  }
  for (int i = 0; i < 20; i++) {
    color col = p.rcol();
    float tam = random(1, 4);
    float alp = 240;//random(2, 40);
    float xx = random(width);
    float yy = random(height/2, height);
    noStroke();
    fill(col, alp);
    ellipse(xx, yy, tam, tam);
  }
}

class Paleta {
  color colores[];
  Paleta() {
  }
  Paleta(color... colores) {
    this.colores = colores;
  }
  void agregar(color c) {
    if (colores == null) {
      colores = new color[1]; 
      colores[0] = c;
    }
    int l = colores.length;
    colores = expand(colores, l+1);
    colores[l] = c;
  }
  color get(int i) {
    return colores[i];
  }
  color rcol() {
    int r = int(random(colores.length));
    return colores[r];
  }
}
