import manoloide.ImageProcessor.*;

ImageProcessor ip;
void setup() {
  size(640, 360);
  ip = new ImageProcessor(this);
}

void draw() {
  background(240);

  hexData(width/2, height/2, width*0.4, "10%");

  ip.vignette(0.2);
}


void hexData(float x, float y, float d, String name) {
  float r = d*0.5;
  noStroke();
  fill(#FA5165);
  float da = PI/3;
  beginShape();
  for (int i = 0; i < 6; i++) {
    vertex(x+cos(da*i)*r, y+sin(da*i)*r);
  } 
  endShape(CLOSE);
  
  fill(10);
  rectMode(CENTER);
  rect(x, y, 4, 4);
  stroke(10);
  float s = r*0.8;
  line(x, y, x+s, y-s);
  line(x+s, y-s, x+s*1.2, y-s);
  
}

