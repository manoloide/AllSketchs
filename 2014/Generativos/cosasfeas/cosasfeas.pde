color paleta[];

void setup() {
  size(600, 800); 
  generar();
}

void draw() {
}

void keyPressed() {
  if(key == 's') saveFrame("######.png");
  else generar();
}

void generar() {
  coloresRand();
  background(180);
  for (int i = 0; i < 20; i++) {
    figura1();
  }
  nnoise();
}

void figura1() {
  color col1 = colrad();
  color col2 = colrad();
  int cant = int(random(3, 20));
  float ang = random(TWO_PI);
  float x = random(width);//width/2;
  float y = random(height);//height/2;
  float da = TWO_PI/cant;
  float tt = random(2, 8);
  float lar = width * random(0.15, 0.8);
  int des = int(random(1, cant));
  strokeWeight(random(10));
  int cc = int(random(1, 50));
  float ang2 = random(TWO_PI);
  for (int j = 0; j < cc; j++) {
    color col = lerpColor(col1,col2,map(j, 0, cc, 0, 1));
    float desx = cos(ang2)*j;
    float desy = sin(ang2)*j;
    stroke(col);
    for (int i = 0; i < cant; i++) {
      line(x+cos(ang+da*i)*lar+desx, y+sin(ang+da*i)*lar+desy, x+cos(ang+da*(i+des))*lar+desx, y+sin(ang+da*(i+des))*lar+desy);
    }
    //noStroke();
    fill(col);
    for (int i = 0; i < cant; i++) {
      ellipse(x+cos(ang+da*i)*lar+desx, y+sin(ang+da*i)*lar+desy, tt, tt);
    }
  }
}

void nnoise() {
  for (int j = 0; j < height; j++) {
    for (int i = 0; i < width; i++) {
      color col =get(i, j);// hueCam(get(i,j), map(i, 0, width, 0, 360));
      set(i, j, oscure(col, random(brightness(col)/10)));
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
