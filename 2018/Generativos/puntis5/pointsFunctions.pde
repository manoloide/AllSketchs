ArrayList<PVector> pointsCen(int cc){
  ArrayList<PVector> aux = new ArrayList<PVector>();
  float bb = 200;
  for (int i = 0; i < cc; i++) {
    float dd = width*random(1)*random(1);
    float aa = random(TAU);
    float xx = width*0.5+cos(aa)*dd;
    float yy = height*0.5+sin(aa)*dd;
    aux.add(new PVector(xx, yy));
  }
  return aux;
}

ArrayList<PVector> pointsUni(int cc){
  ArrayList<PVector> aux = new ArrayList<PVector>();
  float bb = 200;
  for (int i = 0; i < cc; i++) {
    float xx = random(-bb, width+bb);
    float yy = random(-bb, height+bb);
    aux.add(new PVector(xx, yy));
  }
  return aux;
}

ArrayList<PVector> pointsCir(int cc, float x, float y, float s){
  float r = s*0.5;
  ArrayList<PVector> aux = new ArrayList<PVector>();
  for (int i = 0; i < cc; i++) {
    float rr = r*sqrt(random(1));
    float aa = random(TAU);
    float xx = x+cos(aa)*rr;
    float yy = y+sin(aa)*rr;
    aux.add(new PVector(xx, yy));
  }
  return aux;
}