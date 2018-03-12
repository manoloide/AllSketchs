color col; 
void setup() {
  size(600, 600);
  smooth();
  background(255);
}

void draw() {
  float dim = random(20, 100);
  if (mouseX + mouseY < 600) {
    if (mouseX > mouseY) {
      fill(225, 0, 0);
      ellipse(mouseX, mouseY, dim, dim);
    }
    else {
      fill(0, 255, 0);
      rect(mouseX-dim/2, mouseY-dim/2, dim, dim);
    }
  }
  else {
    if (mouseX > mouseY) {
      fill(0, 0, 255);
      triangle(mouseX-dim/2,mouseY+dim/2,mouseX,mouseY-dim/2,mouseX+dim/2,mouseY+dim/2); 
    }
    else {
      stroke(225, 255, 0);
      line(pmouseX,pmouseY,mouseX,mouseY);
      stroke(0);
    }
  }
  
  fill(col);
  //ellipse(mouseX, mouseY, dim, dim);
}

void mousePressed() {
}

