int valor = 1;
float maxDis = random(50,300);
color col;

void setup() {
  size(400, 400);
  background(0);
  colorMode(HSB);
  noStroke();
  col = color(random(256), random(100,256),random(100,256),random(20));
}
void draw() {
  fill(0, 10);
  rect(0, 0, width, height);
  fill(col);
  noiseSeed(valor);
  for (float i= 0;i < 2*PI;i+=0.01) {
    float dis = noise(i) * maxDis;
    ellipse(width/2+cos(i)*dis, height/2+sin(i)*dis, dis/2, dis/2);
  }
}

void mousePressed() {
  col = color(random(256), random(100,256),random(100,256),random(20));
  valor = int(random(30));
  maxDis = random(50,300);
}

