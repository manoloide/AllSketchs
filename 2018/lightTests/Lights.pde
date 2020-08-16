class Ligths {
  ArrayList<Ligth> ligths;
  Ligths() {
    ligths = new ArrayList<Ligth>();
  }
  int getColor(PVector pos) {
    color aux = color(0);
    for (int i = 0; i < ligths.size(); i++) {
      Ligth l = ligths.get(i);
      int act = l.calculate(pos);
      aux = color(red(aux)+red(act), green(aux)+green(act), blue(aux)+blue(act));
    }
    return aux;
  }
  void add(Ligth ligth) {
    ligths.add(ligth);
  }
}

class Ligth {
  int col;
  PVector position;
  Ligth(int col) {
    this.col = col;
  }
  int calculate(PVector pos) {
    return col;
  }
  void show(){
     pushMatrix();
     translate(position.x, position.y, position.z);
     fill(col);
     sphereDetail(20);
     sphere(4);
     popMatrix();
  }
}

class PointLigth extends Ligth {
  float size;
  PointLigth(PVector position, float size, int col) {
    super(col);
    this.size = size;
    this.position = position.copy();
  }
  int calculate(PVector pos) {
    float dis = pos.dist(position);
    float val = constrain(map(dis, 0, size, 1, 0), 0, 1);
    return color(red(col)*val, green(col)*val, blue(col)*val);
  }
}
