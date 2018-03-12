void setup() {
  size(800, 400); 
  generar();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveFrame("#####");
  else generar();
}

void generar() {
  background(20);
  for (int i = 0; i < 10; i++) {
    float x = random(width);
    float y = random(height);
    float gro = random(6, 20);
    float dim = random(gro*3, gro*50);
    float ang = PI/2;//random(TWO_PI);
    color c1 = color(#333B7C);
    color c2 = color(#D69A20);
    circulos(x, y, dim, gro, ang, c1, c2);
    stroke(255, 40);
    strokeWeight(1);
    line(x-gro/5, y, x+gro/5, y);
    line(x, y-gro/5, x, y+gro/5);
  }
}

void circulos(float x, float y, float dim, float gro, float ang, color c1, color c2) {
  strokeWeight(gro);
  strokeCap(SQUARE);
  stroke(c1);
  noFill();
  //ellipse(x, y, dim, dim);
  int cant = int(dim/2);
  float ar = PI/cant;
  for(int i = cant; i > 0; i--){
     stroke(lerpColor(c1, c2, i*1./cant)); 
     arc(x, y, dim, dim, ang-i*ar, ang+i*ar); 
    //arc(x, y, dim, dim, ang+(i+1)*ar, ang+i*ar);  
  }
}
