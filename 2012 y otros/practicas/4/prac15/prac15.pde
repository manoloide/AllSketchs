float vel, dir, x, y, dim;
int clicks;
PFont font;

void setup() {
  size(600, 600);
  smooth();
  //texto
  font = loadFont("font.vlw");
  textFont(font, 12);
  //cosas
  vel = 1;
  dir = int(random(4));
  clicks = 0;
  dim = 120;
  x = width/2;
  y = height/2;
}

void draw() {
  background(0);
  ellipse(x, y, dim, dim); 
  if (dir == 0) {
    x -= vel;
  }
  else if (dir == 1) {
    x += vel;
  }
  else if (dir == 2) {
    y -= vel;
  }
  else if (dir == 3) {
    y += vel;
  }
  if (x > width-dim/2 || x < dim/2 || y > height-dim/2 || y < dim/2){
     println("PERDISTE");
   }
  text("clicks: "+clicks, 10, 20);
}

void mousePressed() {
  if (dist(mouseX, mouseY, x, y) < dim/2) {
    clicks++;
    dir = int(random(4));
    if (clicks%10 == 0){
       vel += 5; 
    }
  }
}

