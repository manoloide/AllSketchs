int cmx, cmy;

void setup() {
  size(800, 600);
}

void draw() {
  background(70);

  if (mousePressed) {
    stroke(100);
    strokeWeight(2);
    fill(40);
    ellipse(cmx, cmy, 8, 8);
    ellipse(mouseX, mouseY, 8, 8);
    float dx = (mouseX-cmx)*0.5;
    float dy = (mouseY-cmy)*0.5;
    /*
    if (abs(dx) > abs(dy)) {
     dy = 0;
     } else {
     dx = 0;
     }*/
    dx = 0;
    noFill();
    stroke(0, 40);
    bezier(cmx, cmy, cmx+dx, cmy+dy, mouseX-dx, mouseY-dy, mouseX, mouseY);
    stroke(255, 128, 0);
    bezier(cmx, cmy, cmx+dx, cmy+dy, mouseX-dx, mouseY-dy, mouseX, mouseY);
  }

  fill(90);
  stroke(80);
  rect(width/2-50, height/2-50, 100, 100, 5);
  fill(0, 255, 128);
  ellipse(width/2, height/2, 60, 60);
}


void mousePressed() {
  cmx = mouseX;
  cmy = mouseY;
}

