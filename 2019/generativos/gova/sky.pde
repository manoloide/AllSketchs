void sky() {
  int sky[] = {#D9D0D1, #C2BAD0, #AAA1CA, #8B8FC6, #7687BD, #D2CBB3, #E0D1A5, #FFFFFF};

  float det = random( 0.004, 0.008);
  float des = random(10000);

  rectMode(CORNER);
  noStroke();
  stroke(0, 20);
  for (int i = 0; i < 9000; i++) {
    float x = random(-80, width);
    float y = random(-40, height);
    float w = width*random(0.04, 0.12);
    float h = height*random(0.04, 0.08)*0.4;
    if(random(1) < 0.2){
      w *= 0.1;
      h *= 0.1;
    }
    fill(getColor(sky, noise(des+x*det, des+y*det)*4+random(0.4))); 
    pushMatrix();
    translate(x, y);
    rotate(random(HALF_PI)*random(-1, 1)*random(1));
    rect(0, 0, w, h);
    popMatrix();
  }
  
  int cc = int(random(-2, 12));
  noStroke();
  for(int i = 0; i < cc; i++){
    float x = random(width);
    float y = random(height*0.75);
    float s = 3;
    fill(0);
    ellipse(x, y, s, s);
  }
  
  rectMode(CENTER);
}
