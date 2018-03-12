int cant = 10;
int num[] = new int[cant];
float t;
int v = -1;

void setup() {
  size(400, 400);
  frameRate(1);
  t = width/10;
  for (int i = 0; i < cant; i++){
    rect(i*t,height/2-t/2,t,t);
  }
  fill(0);
}

void draw() {
  v++;
  rect(v*t,height/2-t/2,t,t);
}

