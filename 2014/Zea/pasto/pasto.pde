void setup() {
  size(400, 400);
}

void draw() {
  background(0);
  noStroke();
  fill(255);
  pasto(width/2, height/2, dist(mouseX,mouseY,width/2,height/2), map(mouseX, 0, width, PI/2*3-PI/4, PI/2*3+PI/4));
}

void pasto(float x, float y, float tam, float ang) {
  beginShape();
  //bezier(pelota_x, pelota_y, pelota_x+cos(a1)*(largo/2)*d, pelota_y+sin(a1)*(largo/2)*d, centro_x, centro_y, centro_x, centro_y);
  float cx = x+cos(ang)*tam;
  float cy = y+sin(ang)*tam;
  float ang2 = atan2(cy-y, cx-x);
  float x1 = x-cos(PI)*tam/14;
  float y1 = y-sin(PI)*tam/14;
  bezier(x1,y1,x1,y1,cx-cos(ang2)*tam/2,cy-sin(ang2)*tam/2,cx,cy);
  //vertex(x1, y1);
  vertex(cx, cy);
  float x2 = x+cos(PI)*tam/14;
  float y2 = y+sin(PI)*tam/14;
  bezier(cx,cy,cx-cos(ang2)*tam/2,cy-sin(ang2)*tam/2,x2,y2,x2,y2);
  //vertex(x2, y2);
  endShape(CLOSE);
}

