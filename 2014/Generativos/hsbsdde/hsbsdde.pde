void setup() {
  size(600, 600);
  smooth(8);
  colorMode(HSB);
  thread("generar");
}

void draw() {
}

void generar() {
  background(#D3C4C7);
  noStroke();
  int cant = int(random(4, 30));
  for (int i = 0; i < cant; i++) {
    float x = random(width);
    float y = random(height);
    float tam = random(20, 120);
    float des = random(0.1, 0.2);
    float ang = random(TWO_PI);
    float dx = cos(ang)*tam*des;
    float dy = sin(ang)*tam*des;
    float col = random(360);
    int lados = int(random(3, 10));
    float dang = random(TWO_PI);
    int can = int(random(4, 30));
    float dcol = random(1,3);

    int r = 1;//int(random(3)*random(1));
    for (int j = 0; j < can; j++) {
      fill((col+j*dcol)%360, 120, 180);
      stroke((col+j*dcol)%360, 120, 180);
      switch(r) {
      case 0:
        noStroke();
        forma(x+dx*j, y+dy*j, lados, tam, dang);
        break;
      case 1:
        strokeWeight(tam/4);
        noFill();
        ellipse(x+dx*j, y+dy*j, tam, tam);
        break;
      case 2:
        strokeWeight(tam/4);
        line(x+dx*j-cos(ang+dang)*tam/2, y+dy*j-sin(ang+dang)*tam/2, x+dx*j+cos(ang+dang)*tam/2, y+dy*j+sin(ang+dang)*tam/2);
        line(x+dx*j-cos(ang+dang+PI/2)*tam/2, y+dy*j-sin(ang+dang+PI/2)*tam/2, x+dx*j+cos(ang+dang+PI/2)*tam/2, y+dy*j+sin(ang+dang+PI/2)*tam/2);
        break;
      }
    }
  }
  /*
  for (int i = 0; i < 5; i++) {
   fill(120+i*10, 80, 170);
   rect(100+i*30, height/2-50, 50, 200);
   forma(100+i*30, height/2, 3, 100, PI/6);
   }
   */
  textura();
}

void forma(float x, float y, int cant, float dim, float ang) {
  float da = TWO_PI/cant;
  beginShape();
  for (int i = 0; i < cant; i++) {
    vertex(x+cos(ang+da*i)*dim/2, y+sin(ang+da*i)*dim/2);
  }
  endShape(CLOSE);
}

void textura() {
  strokeWeight(1);
  for (int i = 0; i < 40000; i++) {
    float x = random(width);
    float y = random(height);
    float ang = random(TWO_PI);   
    float lar = random(2, 4);
    float dx = cos(ang)*lar*0.5;
    float dy = sin(ang)*lar*0.5;
    stroke(random(256), 4);
    line(x-dx, y-dy, x+dx, y+dy);
  }
}

void keyPressed() {
  if (key == 's') {
    saveFrame("#####");
    return;
  }
  else {
    thread("generar");
  }
}
