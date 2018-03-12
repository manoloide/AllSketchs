void setup() {
  size(920, 540);
}

void draw() {
  background(245);
  stroke(0, 8);
  strokeWeight(14);
  for(int i = frameCount%40; i < width+height; i+=40){
     line(i, -2, -2, i); 
  }

  noStroke();
  randomSeed(1);
  for (int j = 0; j < 20; j++) {
    for (int i = 0; i < 20; i++) {
      float x = ((j%2)*0.5+i)*80;
      float y = j*80;
      float d = 50+sin(frameCount*0.1)*10;
      stroke(0, 5);
      noFill();
      for(int k = 5; k > 0; k--){
        strokeWeight(k);
        hexa(x, y, d);
      }
      stroke(0, 8);
      fill(250);
      strokeWeight(2);
      hexa(x, y, d);
      float aa = random(TWO_PI);
      float da = random(PI, TWO_PI)*random(1);
      stroke(10, 220);
      fill(180, 160);
      arc(x, y, d*0.5, d*0.5, aa, aa+da);
      fill(100, 160);
      arc(x, y, d*0.5, d*0.5, aa+da, aa+da+(TWO_PI-da));
    }
  }
}

void hexa(float x, float y, float d) {
  float da = TWO_PI/6;
  float r = d*0.5;
  float a = TWO_PI/12;
  beginShape();
  for(int i = 0; i < 6; i++){
     vertex(x+cos(a+da*i)*r, y+sin(a+da*i)*r); 
  }
  endShape(CLOSE);
}

