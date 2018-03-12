import manoloide.Color.Paleta;

Paleta paleta;
PFont miki, peji, marl;

void setup() {
  size(600, 600);
  marl = createFont("Helvetica Neue", 18, true);
  miki = createFont(sketchPath("data/mikiyu-mokomori-kuro.ttf"), 72, true);
  peji = createFont(sketchPath("data/mikiyu-newpenji-p.ttf"), 22, true);
  smooth(8);
  paleta = new Paleta();
  paleta.load(sketchPath("plHelados.plt"));
  generar();
}

void draw() {
}

void keyPressed() {
  if (key == 's') {
    saveFrame("#####");
  } 
  else {
    generar();
  }
}

void generar() {
  float x, y, w, h, dx, dy, tam, gro, es;
  background(paleta.rcol());
  noStroke();
  fill(0, 10);
  rect(0, 0, width, height);
  strokeWeight(2);
  stroke(0, 10);
  es = random(6, 12);
  for (int i = 0; i < dist(0,0,width,height)*1.5; i+=es) {
    line(-10, i, i, -10);
  }
  for (int j = 0; j < width/30; j++) {
    for (int i = 0; i < height/30; i++) {
      helado1(i*30+15, j*30+15, 20, random(TWO_PI));
    }
  }
  x = width/2+120;
  y = height/2+40;
  es = random(400, 440);
  helado1(x, y, es, 0);
  textAlign(CENTER, TOP);
  textFont(miki);
  fill(0, 80);
  text("アイスクリーム", width/2+2, 40+2);
  fill(250);
  text("アイスクリーム", width/2, 40);
  textAlign(LEFT, TOP);
  textFont(peji);
  fill(0, 80);
  text("アイスクリーム\n加糖凍結された液体の種類は、適切にクリームと卵黄から作られたが、多くの場合、ミルクカスタード又は塩基から製造され、様々な方法で味付け", 60+2, 120+2, 200, 400);
  fill(250);
  text("アイスクリーム\n加糖凍結された液体の種類は、適切にクリームと卵黄から作られたが、多くの場合、ミルクカスタード又は塩基から製造され、様々な方法で味付け", 60, 120, 200, 400);
  textAlign(CENTER, DOWN);
  textFont(marl);
  fill(0, 80);
  text("糖凍結された液体 - 2014 - manoloide.", width/2+1, height-10+1);
  fill(250);
  text("糖凍結された液体 - 2014 - manoloide.", width/2, height-10);
}

void helado1(float x, float y, float es, float rot) {
  pushMatrix();
  translate(x, y);
  x = 0;
  y = 0;
  rotate(rot);
  strokeWeight(es/10);
  stroke(paleta.get(3));
  line(x, y-es/2.8+es/20, x, y+es/2-es/20);
  stroke(255, 40);
  line(x, y-es/2.8+es/20, x, y+es/2-es/20);
  noStroke();
  int r = 2;//int(random(3));
  switch(r) {
  case 0:
    fill(paleta.rcol(), 240);
    rect(x-es/5, y-es/2, es/2.5, es/1.45, es/5, es/5, es/15, es/15);
    break;
  case 1:
    fill(paleta.rcol(), 240);
    rect(x-es/5, y-es/2, es/2.5, es/1.45*0.51, es/5, es/5, 0, 0);
    fill(paleta.rcol(), 240);
    rect(x-es/5, y-es/2+es/1.45*0.5, es/2.5, es/1.45*0.5, 0, 0, es/15, es/15);
    break;
  case 2:
    fill(paleta.rcol(), 240);
    rect(x-es/5, y-es/2, es/2.5, es/1.45*1.01/3, es/5, es/5, 0, 0);
    fill(paleta.rcol(), 240);
    rect(x-es/5, y-es/2+es/1.45*1/3, es/2.5, es/1.45*1.01/3);
    fill(paleta.rcol(), 240);
    rect(x-es/5, y-es/2+es/1.45*1/3*2, es/2.5, es/1.45*1/3, 0, 0, es/15, es/15);
    break;
  }
  stroke(255, 10);
  strokeWeight(es/13);
  line(x-es/13, y-es/2.8, x-es/13, y+es/10);
  line(x+es/13, y-es/2.8, x+es/13, y+es/10);
  popMatrix();
}

void puntos(float ix, float iy, float w, float h, float dx, float dy, float tam) {
  for (float y = iy; y < iy+h; y+=dy) {
    for (float x = ix; x < ix+w; x+=dx) {
      ellipse(x, y, tam, tam);
    }
  }
}

void cuadricula(float ix, float iy, float w, float h, float dx, float dy, float tam) {
  strokeWeight(tam);
  for (float y = iy; y < iy+h; y+=dy) {
    line(0, y, width, y);
  }
  for (float x = ix; x < ix+w; x+=dx) {
    line(x, 0, x, height);
  }
}
