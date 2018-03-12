int col, vec;
float dista, ang;
void setup() {
  size(600, 600); 
  colorMode(HSB);
  smooth();
  noStroke();
  iniciar();
  background((col+128)%256, 255, 255);

  vec = 10;
}

void draw() {
  dista = dist(mouseX, mouseY, width/2, height/2)*10;
  fill((col+128)%256, 255, 255, 5);
  rect(0, 0, width, height);
  for (int i = 0; i < vec; i++) {
    float dis = (dista/vec)*i;
    if (i%2 == 1) {
      fill(col, 255, 255);
    }
    else {
      fill((col+128)%256, 255, 255);
    }
    ellipse(width/2 + cos(ang)*dis, height/2 +sin(ang)*dis, dis, dis);
    ellipse(width/2 + cos(ang+2*PI/3)*dis, height/2 +sin(ang+2*PI/3)*dis, dis, dis);
    ellipse(width/2 + cos(ang+2*PI/3*2)*dis, height/2 +sin(ang+2*PI/3*2)*dis, dis, dis);
  }
  //cambio de color
  col += int(random(-1, 2));
  col = col%256;
  //angulo 
  ang += 0.02;
  ang = ang%(PI*2);
}

void keyPressed() {
  if (key == 'r') {
    iniciar();
  }
}

void iniciar() {
  col = int(random(256));
  background((col+128)%256, 215, 255);
}

