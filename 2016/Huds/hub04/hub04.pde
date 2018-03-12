void setup() {
  size(640, 640, P3D);
  smooth(8);
  noCursor();
}

void draw() {
  background(10);


  translate(width/2, height/2, 460);
  rotateY(map(mouseX, 0, width, PI*0.2, -PI*0.2));
  rotateX(map(mouseY, 0, height, -PI*0.2, PI*0.2));
  translate(0, 0, -440);

  strokeCap(SQUARE);
  stroke(255, 20);
  strokeWeight(1);
  noFill();
  float v = frameCount*0.1;
  line(-8, 0, 8, 0); 
  line(0, -8, 0, 8);
  arc(0, 0, 60, 60, 0+v, PI*1.5+v);
  stroke(255);
  strokeWeight(1.2);
  rect(-15, -15, 30, 30);
  beginShape();
  vertex(-70, -50);
  vertex(-80, -50);
  vertex(-80, 50);
  vertex(-70, 50);
  endShape();
  beginShape();
  vertex(70, -50);
  vertex(80, -50);
  vertex(80, 50);
  vertex(70, 50);
  endShape();

  noStroke();
  for (int i = 0; i < 8; i++) {
    fill(255, (noise(frameCount*0.03) < i/10.)? 50 : 220); 
    rect(85+i*3, -50, 2, 7);
  }
}

