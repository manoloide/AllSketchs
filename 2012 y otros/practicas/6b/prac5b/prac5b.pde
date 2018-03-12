int cant = 36;
int m = 12;

void setup() {
  size(400, 400, P3D);
  noStroke();
  fill(0);
}

void draw() {
  background(255);
  //
  translate(width/2,height/2,map(mouseY,0,height,-1000,0));
  rotateY((TWO_PI/ 200)*frameCount);
  rotateX((TWO_PI/ 173)*frameCount);
  //
  m = int(map(mouseX,0, width,2,10));
  cant = m * 5;
  int conta = 1;
  for (int i = 0; i < cant; i++) {
    arc(0, 0, (width/m)*conta, (height/m)*conta, (TWO_PI/cant)*i, (TWO_PI/cant)*(i+1));
    conta++;
    if (conta > m) {
      conta = 1;
    }
  }
}

