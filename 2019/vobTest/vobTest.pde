PShape linee;

void setup() {
  size(1920, 1080, P2D);



  float det = random(0.001);
  float x = 0; 
  float y = 0;

  linee = createShape();
  linee.beginShape();
  linee.stroke(0, 100);
  linee.noFill();
  for (int i = 0; i < 40; i++) {
    linee.vertex(x, y);
    float a = noise(x*det, y*det)*TAU*2;
    x += cos(a);
    y += sin(a);
  }
  linee.endShape();
}


void draw() {

  float time = millis()*0.001;

  background(255);

  float x = 0; 
  float y = 0; 
  float det = 0.1;
  for (int i = 0; i < 40; i++) {
    float a = noise(x*det, y*det, time)*TAU*2;
    x += cos(a)*6;
    y += sin(a)*6;
    linee.setVertex(i, x, y);
  }

  int step = 10;
  for (int j = 0; j < height; j+=step) {
    for (int i = 0; i < width; i+=step) {
      shape(linee, i, j);
    }
  }

  if (frameCount%40 == 0) {
    println(frameRate);
  }
}
