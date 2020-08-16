

void pelos() {

  noFill();

  float det = random(0.03)*random(0.2, 1);
  float des = random(1000);
  float det2 = random(0.03)*random(0.2, 1);
  float des2 = random(1000);


  float  res = 8;
  float a = random(TAU);
  float amp = random(20)*random(1);
  float vel = 4;

  float xx, yy, ang;
  for (int i = 0; i < 8000; i++) {
    xx = random(-50, width+50);
    yy = random(-50, height+50);
    stroke(rcol());
    beginShape();
    vertex(xx, yy);
    for (int j = 0; j < 120; j++) {
      res = noise(des2+xx*det2, des2+yy*det2)*amp-amp*0.5; 
      ang = a+noise(des+xx*det, des+yy*det)*TAU*res;
      xx += cos(ang)*vel;
      yy += sin(ang)*vel;
      vertex(xx, yy);
      //fill(getColor(ic+dc*j));
      //ellipse(xx, yy, ss, ss);
    }
    endShape();
  }
}