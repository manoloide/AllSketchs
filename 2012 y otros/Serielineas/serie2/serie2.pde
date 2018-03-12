float xoff = 0.0;
float yoff = 1.0;

float ang,x1,y1, lar = 160;

void setup() {
  size(400,400);
  background(0);
}

void draw() {
  xoff += random(0.03);
  yoff += random(0.03);
  ang  += 0.03;
  
  stroke(255,20);
  
  x1 = noise(xoff+10) * width;
  y1 = noise(yoff+10) * height;
  
  line(x1 + cos(ang) * lar, y1 + sin(ang) * lar,x1 - cos(ang) * lar, y1 - sin(ang) * lar);
  
  stroke(0,20);
  
  x1 = noise(xoff) * width;
  y1 = noise(yoff) * height;
  
  line(x1 + cos(ang) * lar, y1 + sin(ang) * lar,x1 - cos(ang) * lar, y1 - sin(ang) * lar);
}

