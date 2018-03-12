int paleta[] = {
  #FCFCFF, 
  #E2E2E2, 
  #373846, 
  #FF655F, 
  #3CDEB4, 
  #2ED148
};

void setup() {
  size(270, 480);
}

void draw() {
  background(252);
  fill(paleta[3+(frameCount/300)%3]);
  loader(width/2, height/2, 180, (frameCount/300.)%1);
  bar(20, 20, 20+width-40, 20, 12, (frameCount/400.)%1);
  
  noStroke();
  fill(0, 20);
  ellipse(100, height-100, 60, 60);
}

void bar(float x1, float y1, float x2, float y2, float s, float c) {
  color cl = g.fillColor;
  pushStyle();
  strokeWeight(s);
  stroke(paleta[1]);
  line(x1, y1, x2, y2);
  stroke(cl);
  float dx = (x2-x1)*c;
  float dy = (y2-y1)*c;
  line(x1, y1, x1+dx, y1+dy);
  popStyle();
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

