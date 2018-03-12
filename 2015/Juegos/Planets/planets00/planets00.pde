void setup() {
  size(560, 960);
}

void draw() {
  background(240);
  float xx = width/2; 
  float yy = height/2;
  float ss = 300;

  stroke(0, 30);
  fill(#DBF5FC, 20);
  ellipse(xx, yy, ss, ss);

  float a = PI*0.5;
  float h = cos(frameCount*0.08)*PI*0.05+PI*0.5;
  noStroke();
  fill(0, 255, 80);
  arc(xx, yy, ss, ss, a-h, a+h, CHORD);

  stroke(0, 255, 80);
  noFill();
  ellipse(xx, yy, ss+50, ss+50);
}

