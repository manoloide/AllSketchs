int iv = 3;

void setup() {
  size(600, 800);
  background(255);
  noStroke(); 
  op2(10);
  //exit();
}
void draw() {
}
void mousePressed() {
  saveFrame("image"+iv+".png");
  iv++;
}

void mouseReleased() {
  op2(10);
}

void op2(float tam) {
  float an = width/tam;
  float al = height/tam;
  float dis, ang; 
  for (int j = 0; j < al; j++) {
    for (int i = 0; i < an; i++) {
      if ((i+j)%2==0) {
        fill(0);
      }
      else {
        fill(255);
      }
      float x1 = i*tam;
      dis = width/2-x1;
      x1 = (dis>-100 && dis<100)?x1 + map(dis, -100, 100, -10, 10):x1;
      float x2 = (i+1)*tam;
      dis = width/2-x2;
      x2 = (dis>-100 && dis<100)?x2 + map(dis, -100, 100, -10, 10):x2;
      float y1 = j*tam;
      dis = height/2-y1;
      y1 = (dis>-100 && dis<100)?y1 + map(dis, -100, 100, -10, 10):y1;
      float y2 = (j+1)*tam;
      dis = height/2-y2;
      y2 = (dis>-100 && dis<100)? y2 + map(dis, -100, 100, -10, 10):y2;
      beginShape();
      vertex(x1, y1);
      vertex(x2, y1);
      vertex(x2, y2);
      vertex(x1, y2);
      endShape(CLOSE);
    }
  }
}

