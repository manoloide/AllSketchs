class Field {
  boolean blocked;
  float x, y, s;
  Plant plant;
  Field(float x, float y, float s) {
    this.x = x; 
    this.y = y;
    this.s = s;
  }
  void update() {
    show();
  }
  void show() {
    rectMode(CENTER);
    stroke(0, 5);
    noFill();
    for(int k = 6; k > 0; k-=2){
      strokeWeight(k);
      rect(x, y, s, s);
    }
    fill(#f2f2f4);
    rect(x, y, s, s);
    if (plant != null) {
      fill(plant.col);
      loader(x, y, s*0.8, (frameCount/300.)%1);
    }
  }
}

void loader(float x, float y, float s, float c) {
  color cl = g.fillColor;
  pushStyle();
  noStroke();
  fill(226);
  ellipse(x, y, s, s);
  fill(cl);
  arc(x, y, s, s, PI*1.5, PI*(1.5+c*2));
  fill(0, 18);
  ellipse(x, y, s*0.69, s*0.69);
  fill(#373846);
  ellipse(x, y, s*0.6, s*0.6);
  popStyle();
}

