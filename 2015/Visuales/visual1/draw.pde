void poly(float x, float y, float d, int c, float a) {
  float r = d*0.5;
  float da = TWO_PI/c;
  beginShape();
  for(int i = 0; i < c; i++){
     vertex(x+cos(da*i+a)*r, y+sin(da*i+a)*r); 
  }
  endShape(CLOSE);
}

void star(float x, float y, float d, float id, int c, float a) {
  float r = d*0.5;
  float da = TWO_PI/c;
  beginShape();
  for(int i = 0; i < c; i++){
     vertex(x+cos(da*i+a)*r, y+sin(da*i+a)*r); 
     vertex(x+cos(da*i+a+da/2)*r*id, y+sin(da*i+a+da/2)*r*id); 
  }
  endShape(CLOSE);
}

void cross(float x, float y, float d, float g, float a){
  float r = d*0.5;
  float da = TWO_PI/4;
  beginShape();
  for(int i = 0; i < 4; i++){
    float ang = da*i+a;
    float xx = cos(ang)*r;
    float yy = sin(ang)*r; 
    float dd = dist(0, 0, r*g, r*g);
    vertex(x+cos(ang-da/2)*dd, y+sin(ang-da/2)*dd);
    vertex(x+xx+cos(ang-da)*r*g, y+yy+sin(ang-da)*r*g);
    vertex(x+xx+cos(ang+da)*r*g, y+yy+sin(ang+da)*r*g);
  }
  endShape(CLOSE);
}
