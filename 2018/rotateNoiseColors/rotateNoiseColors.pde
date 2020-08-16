int seed = int(random(999999));

void setup() {
  size(720, 720, P2D);
  smooth(8);
  pixelDensity(2);
}

void draw() {
  background(40);


  float bb = 20;

  float csx = width/2; 
  float csy = height/2; 

  noStroke();
  fill(0, 40);
  float ss = csx-bb*1.5;
  rect(bb, bb, ss, ss, 2);
  rect(csx+bb, bb, ss, ss, 2);
  rect(csx+bb, csy+bb, ss, ss, 2);
  rect(bb, csy+bb, csx-bb*2, csy-bb*2.0, 2);
}