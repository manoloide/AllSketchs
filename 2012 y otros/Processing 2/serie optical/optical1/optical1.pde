int iv = 9;

void setup() {
  size(600, 800);
  background(255);
  noStroke(); 
  op1(width/2, height/2, height, 500, 100);
  saveFrame("image8.png");
  //exit();
}
void draw(){
  
}
void mousePressed() {
  saveFrame("image"+iv+".png");
  iv++;
}

void mouseReleased() {
  op1(width/2, height/2, height, int(random(3,800)), int(random(2,400))*2);
}

void op1(float x, float y, float dim, int cant, float divi) {
  float dang = TWO_PI/divi;
  float dis = dim/cant;
  for (int i = 1; i <= cant; i++) {
    float dis1 = dis*(i-1);
    float dis2 = dis*i;
    for (int j = 1; j <=divi; j++) {
      if ((i+j)%2==0) {
        fill(0);
      }
      else {
        fill(255);
      }
      float ang1 = dang*(j-1);
      float ang2 = dang*j;
      beginShape();
      vertex(x+cos(ang1)*dis1, y+sin(ang1)*dis1);
      vertex(x+cos(ang2)*dis1, y+sin(ang2)*dis1);
      vertex(x+cos(ang2)*dis2, y+sin(ang2)*dis2);
      vertex(x+cos(ang1)*dis2, y+sin(ang1)*dis2);
      endShape(CLOSE);
    }
  }
}

