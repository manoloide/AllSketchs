void sky(float hor) {

  noStroke();

  beginShape();
  fill(0);
  vertex(0, hor);
  vertex(width, hor);
  fill(#83A4A1, 0);
  vertex(width, 0);
  vertex(0, 0);
  endShape(CLOSE); 


  beginShape();
  fill(0);
  vertex(0, hor);
  vertex(width, hor);
  fill(0, 0);
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);

  for (int i = 0; i < 1000; i++) {
    stroke(255, random(200)*random(1));
    strokeWeight(random(2)*random(0.2, 1));
    point(random(width), random(height)*random(1));
  }


  noStroke();
  for (int i = 0; i < 1000; i++) {
    float v = random(1);
    float x = random(width);
    float y = height*lerp(0.5, 1, v);

    fill(rcol());
    rect(x, y, 5*v, 5*v);
  }
}
