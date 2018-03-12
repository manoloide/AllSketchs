int num;
PFont font;
void setup() {
  size(960, 960);
  font = createFont("Helvetica Neue Bold", 40, true);
  textFont(font);
}


void draw() {
  background(40);
  int aux = num;
  for (int i = 0; i < 8; i++) {
    int x = width/2-200+i*50;
    int y = height/2-20;
    stroke(50);
    fill(35);
    rect(x, y, 40, 40, 4);
    noStroke();
    fill(255, 160, 0, 240);
    if (aux%2 == 1) ellipse(x+20, y+20, 20, 20);
    aux /= 2;
  }

  fill(255, 240);
  textAlign(CENTER, CENTER);
  text(num, width/2, height/2-80);
}

void keyPressed() {
  num = int(random(pow(2, 8)));
}