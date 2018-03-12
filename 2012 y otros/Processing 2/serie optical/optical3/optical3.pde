int iv = 6;

void setup() {
  size(600, 800);
  background(255);
  noStroke(); 
  op3(40);
  //exit();
}
void draw() {
}
void mousePressed() {
  saveFrame("image"+iv+".png");
  iv++;
}

void mouseReleased() {
  op3(10);
}

void op3(int tam) {
  int an = int(width/tam)+1;
  int al = int(height/tam)+1;

  Punto p[][] = new Punto[an][al];
  for (int j = 0; j < al; j++) {
    for (int i = 0; i < an; i++) {
      int x = i*tam;
      int y = j*tam;
      float dis = dist(x,y,width/2,height/2);
      float des = (dis > 300 || dis == 0)? 0: map(dis,0,300,tam/2,0);
      float ang = atan2(height/2-y,width/2-x)-map(des,tam/2,0,PI,0);
      p[i][j] = new Punto(x+cos(ang)*des,y+sin(ang)*des);
    }
  }
  for (int j = 0; j < al-1; j++) {
    for (int i = 0; i < an-1; i++) {
      if ((i+j)%2==0) {
        fill(0);
      }
      else {
        fill(255);
      }
      beginShape();
      vertex(p[i][j].x, p[i][j].y);
      vertex(p[i+1][j].x, p[i+1][j].y);
      vertex(p[i+1][j+1].x, p[i+1][j+1].y);
      vertex(p[i][j+1].x, p[i][j+1].y);
      endShape(CLOSE);
    }
  }
}

class Punto {
  float x, y;
  Punto(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

