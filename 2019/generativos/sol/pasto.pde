void pasto() {

  fill(#6B7451); 
  //rect(0, height*0.5, width, height*0.5);

  float det = random(0.005, 0.01); 
  float des = random(10000);

  float detCol = random(0.001, 0.0014);
  float desCol = random(1000);

  for (int i = 0; i < 800000; i++) {
    float v = random(1)*random(0.1, 1)*random(0.5, 1);
    float x = random(width); 
    float y = height*(0.5+v*0.5)-1;

    int cols[] = {#869356, #58671B, #817038, #624720, #38502B};
    float noiCol = noise(desCol+x*detCol, desCol+y*detCol*v)*cols.length*2;

    noFill();
    stroke(getColor(cols, noiCol+random(0.2)), 80);
    strokeWeight(random(0.5, 1.5));
    beginShape();
    for (int j = 0; j < 2+(v*5); j++) {
      float ang = (float) (SimplexNoise.noise(des+x*det, des+y*det*v)*2-1)*HALF_PI+PI*1.5;
      //ang -= ia;
      x += cos(ang);
      y += sin(ang);
      vertex(x, y);
    }
    endShape();
  }
}
