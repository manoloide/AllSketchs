int cant = 10;
int num[][] = new int[cant][cant];
float th, tv;

void setup() {
  size(400, 400);
  th = width/10;
  tv = height/10;
  for (int j = 0; j < cant; j++) {
    for (int i = 0; i < cant; i++) {
      fill(255);
      rect(i*th, j*tv, th, tv);
      fill(0);
      text(num[i][j], i*th+th/2, j*tv+tv/2);
    }
  }
}

void draw() {
}

void mousePressed() {
  int x = int(mouseX/th);
  int y = int(mouseY/tv);
  num[x][y]++;
  fill(255);
  rect(x*th, y*tv, th, tv);
  fill(0);
  text(num[x][y], x*th+th/2, y*tv+tv/2);
}

