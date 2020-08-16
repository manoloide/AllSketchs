void skys() {

  background(4, 0, 9);

  noStroke();
  fill(255, 240);
  for (int i = 0; i < 500; i++) {
    float x = random(width);
    float y = random(height);
    float s = random(1, random(1, 2.4));
    ellipse(x, y, s, s);
  }


  beginShape(); 
  fill(#F5C3C1, 250);
  vertex(0, 0);
  vertex(width, 0); 
  fill(#D0CDF5, 220);
  vertex(width, height*0.5); 
  vertex(0, height*0.5); 
  endShape();

  for (int i = 0; i < 0; i++) {
    float x = random(width); 
    float y = random(height);
    float s = random(200)*random(0.2, 1)*1.8;
    int col = color(190, 210);
    fill(col);
    ellipse(x, y, s, s);
    arc2(x, y, s, s*0.2, 0, TAU, color(120), 60, 0);
    arc2(x, y, s, s*0.6, 0, TAU, col, 30, 0);
    //arc2(x, y, s, s*random(0.2, 0.4), 0, TAU, rcol(), 80, 0);
    arc2(x, y, s, s*1.5, 0, TAU, color(255), 20, 0);
    //fill(250);
    //ellipse(x, y, s*0.1, s*0.1);
  }

  beginShape(); 
  fill(#050020, 20);
  vertex(0, height*0.5); 
  vertex(width, height*0.5); 
  fill(#050020, 50);
  vertex(width, height*1.0); 
  vertex(0, height*1.0); 
  endShape();




  beginShape(); 
  fill(#F5C3C1, 210);
  vertex(0, 0);
  vertex(width, 0); 
  fill(#D0CDF5, 80);
  vertex(width, height*0.5); 
  vertex(0, height*0.5); 
  endShape();
}
