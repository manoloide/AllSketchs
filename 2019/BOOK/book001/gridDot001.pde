void gridDot001() {

  background(255);

  int cc = int(random(2, random(10, 30)));
  float des = width*1./(cc+1);
  float bb = (width-des*cc)*0.5;

  noStroke();
  fill(0);
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float ss = des;
      if (random(1) < 0.04) ss = des*0.08;
      ellipse(bb+(i+0.5)*des, bb+(j+0.5)*des, ss, ss);
    }
  }
}
