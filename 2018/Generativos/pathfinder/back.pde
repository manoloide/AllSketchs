void back() {
  noStroke();
  for (int j = 0; j < 40; j++) {
    float ic = random(colors.length);
    float dc = random(0.1);

    float ss = random(200);
    float as = random(0.99, 1.01);
    pushMatrix();
    translate(random(width), random(height), 0);
    for (int i = 0; i < 200; i++) {
      ss *= as;
      fill(getColor(ic+dc*i));
      box(ss);
      translate(0, 0, -ss);
      rotateX(random(-0.1, 0.1));
      rotateY(random(-0.1, 0.1));
      rotateZ(random(-0.1, 0.1));
    }
    popMatrix();
  }
  
  float det = random(0.002, 0.005);
  float des = random(1000);
  
  for(int i = 0; i < 8000; i++){
     float x = random(width);
     float y = random(height);
     stroke(rcol(), random(20, 100));
     noFill();
     beginShape();
     for(int j = 0; j < 8; j++){
       vertex(x, y);
       float ang = noise(des+x*det, des+y*det)*TAU*4;
       x += cos(ang);
       y += sin(ang);
     }
     endShape();
  }
  
  blendMode(ADD);
  beginShape();
  fill(rcol(), random(40));
  vertex(0, 0);
  vertex(width, 0);
  fill(rcol(), random(40));
  vertex(width, height);
  vertex(0, height);
  endShape();
  blendMode(BLEND);
  
}
