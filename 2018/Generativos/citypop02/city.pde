void city(float x, float y) {
  float w = 160;
  float h = 60;
  int cc = 8; 
  int cols[] = {#EDE9EE, #EDE9EE, #EDE9EE, #EDE9EE, #C6E3EF, #FBE1DF};
  for (int j = 0; j < cc; j++) {
    float hh = h*random(0.4, random(0.4, 1));    
    float ww = w*random(0.2, 0.3);
    float xx = random(x, x+w-ww);
    fill(cols[int(random(cols.length))]);
    rect(xx, y-hh, ww, hh);
    fill(0, 80);
    rect(xx+ww, y-hh, random(1), hh);

    fill(#0086B9);
    for (int i = 8; i < hh-2; i+=5) {
      rect(xx+1, y-hh+i, ww-1, 2);
    }
    fill(0, 20);
    beginShape();
    vertex(xx+ww, y-hh);
    vertex(xx+ww, y);
    vertex(xx+ww*1.1, y);
    endShape(CLOSE);
  }

  float det = random(0.01);
  fill(0);
  beginShape();
  vertex(x-10, y);
  for (int i = -10; i < w+10; i++) {
    float hh = -noise(i*det)*4;
    vertex(x+i, y+hh);
  }
  vertex(x+w+20, y);
  endShape(CLOSE);
}
