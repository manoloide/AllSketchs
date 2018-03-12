float l1, l2;
int estado = 1;

void setup() {
  size(400, 400);
  smooth();
  background(255);
}

void draw() {
}

void mousePressed() {
  if (estado == 1) {
    //background(255);
    l1 = mouseX;
    line(l1, 0, l1, height);
    estado++;
  } 
  else if (estado == 2) {
    float pro =  mouseX;
    line(pro, 0, pro, height);
    if (l1 > pro) {
      l2 = l1;
      l1 = pro;
    }
    else {
      l2 = pro;
    }
    estado++;
  }
  else if (estado == 3) {
    if ( mouseX > l1 && mouseX < l2) {
      fill(random(255), random(255), random(255), random(255));
      rect(l1, 0, l2-l1, height);
      estado = 1;
    }
  }
}

