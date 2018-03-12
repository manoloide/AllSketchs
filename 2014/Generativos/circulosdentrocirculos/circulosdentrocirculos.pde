void setup() {
  size(600, 600);
  smooth(8);
  background(80);
  circulo1(width/2, height/2, 400, 40, 0, 50, 0);
  circulo2(width/2, height/2, 340, 20, 0, 4);
  circulo3(width/2, height/2, 290, 30, 0, 29, 0, 3);
  circulo4(width/2, height/2, 240, 20, 0, 72);
  circulo3(width/2, height/2, 210, 10, 0, 36, 0, 5);
  circulo5(width/2, height/2, 195, 20, 0, 6, 40);
  generar();
}

void draw() {
}

void keyPressed( ){
   if(key == 's'){
      saveFrame("####");
      return;
   } 
   thread("generar");
}

void generar() {
  background(0);
  int cant = 0;
  float tam = dist(0, 0, width, height);
  while (tam > 0) {
    float x = width/2; 
    float y = height/2;
    float t = int(random(10)+1)*10;
    float dim = tam; 
    float ang = random(TWO_PI);
    int r = int(random(5))+1;
    switch(r) {
    case 1:
      circulo1(x, y, dim, ang, t, int(random(3, 72)), int(random(8)));
      break;
    case 2:
      circulo2(x, y, dim, ang, t, int(random(72)));
      break;
    case 3:
      circulo3(x, y, dim, ang, t, int(random(8)), random(TWO_PI), int(random(3, 8)));
      break;
    case 4:
      circulo4(x, y, dim, ang, t, int(random(4,73)));
      break;
    case 5:
      circulo5(x, y, dim, ang, t, int(random(72)), int(random(8)));
      break;
    }
    tam -= t;
    cant++;
  }
}

void circulo1(float x, float y, float dim, float anc, float ang, int cant, int cant2) {
  strokeWeight(anc);
  stroke(255); 
  noFill();
  ellipse(x, y, dim, dim);
  float da = TWO_PI/cant;
  strokeWeight(1);
  stroke(0);
  for (int i = 1; i < cant2; i++) {
    float dd = (anc*2/cant2)*i;
    ellipse(x, y, dim-anc+dd, dim-anc+dd);
  }
  for (int i = 0; i < cant; i++) {
    float xx = cos(ang+da*i)*dim/2;
    float yy = sin(ang+da*i)*dim/2;
    float dx = cos(ang+da*i)*anc/2;
    float dy = sin(ang+da*i)*anc/2;
    line(x+xx+dx, y+yy+dy, x+xx-dx, y+yy-dy);
  }
}
void circulo2(float x, float y, float dim, float anc, float ang, int cant) {
  strokeWeight(anc);
  stroke(0); 
  noFill();
  ellipse(x, y, dim, dim);
  float da = TWO_PI/cant;
  strokeWeight(1);
  noStroke();
  fill(255);
  for (int i = 0; i < cant; i++) {
    float xx = cos(ang+da*i)*dim/2;
    float yy = sin(ang+da*i)*dim/2;
    ellipse(x+xx, y+yy, anc, anc);
  }
}

void circulo3(float x, float y, float dim, float anc, float ang, int cant, float ang2, int cant2) {
  float tam = anc*0.6;
  strokeWeight(anc);
  stroke(255); 
  noFill();
  ellipse(x, y, dim, dim);
  float da = TWO_PI/cant;
  strokeWeight(1);
  noStroke();
  fill(0);
  for (int i = 0; i < cant; i++) {
    float xx = cos(ang+da*i)*dim/2;
    float yy = sin(ang+da*i)*dim/2;
    figura(x+xx, y+yy, tam, ang2+da*i, cant2);
  }
}

void circulo4(float x, float y, float dim, float anc, float ang, int cant) {
  strokeWeight(anc/2);
  stroke(0); 
  noFill();
  ellipse(x, y, dim+anc/2, dim+anc/2);
  stroke(255);
  ellipse(x, y, dim-anc/2, dim-anc/2);
  float da = TWO_PI/cant*2;
  float da2 = da/2;
  strokeWeight(1);
  noStroke();
  fill(255);
  for (int i = 0; i < cant; i++) {
    float x1 = x+cos(ang+da*i)*(dim/2+anc/2);
    float y1 = y+sin(ang+da*i)*(dim/2+anc/2);
    float x2 = x+cos(ang+da*(i+1))*(dim/2+anc/2);
    float y2 = y+sin(ang+da*(i+1))*(dim/2+anc/2);
    float x3 = x+cos(ang+da*i+da2)*(dim/2-anc/2);
    float y3 = y+sin(ang+da*i+da2)*(dim/2-anc/2);
    float x4 = x+cos(ang+da*(i+1)+da2)*(dim/2-anc/2);
    float y4 = y+sin(ang+da*(i+1)+da2)*(dim/2-anc/2);
    fill(0);
    beginShape();
    vertex(x1, y1);
    vertex(x2, y2);
    vertex(x3, y3);
    endShape(CLOSE);
    fill(255);
    beginShape();
    vertex(x2, y2);
    vertex(x3, y3);
    vertex(x4, y4);
    endShape(CLOSE);
  }
}

void circulo5(float x, float y, float dim, float anc, float ang, int cant, int tam) {
  strokeWeight(anc);
  stroke(0); 
  noFill();
  ellipse(x, y, dim-anc/2, dim-anc/2);
  float da = TWO_PI/cant;
  strokeWeight(1);
  noStroke();
  fill(255);
  for (int i = 0; i < cant; i++) {
    float xx = x+cos(ang+da*i)*(dim/2);
    float yy = y+sin(ang+da*i)*(dim/2);
    for (int t = tam; t > 0; t-=5) {
      if (t%(10) == 0) fill(0); 
      else fill(255);
      ellipse(xx, yy, t, t);
    }
  }
}

void figura(float x, float y, float dim, float ang, int cant) {
  float da = TWO_PI/cant;
  float rad = dim/2;
  beginShape();
  for (int i = 0; i < cant; i++) {
    vertex(x+cos(ang+da*i)*rad, y+sin(ang+da*i)*rad);
  }
  endShape(CLOSE);
}
