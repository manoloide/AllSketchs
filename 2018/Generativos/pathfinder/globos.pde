void globos() {
  pushMatrix();
  translate(0, 0, 400);
  Icosahedron ico = new Icosahedron();
  ico.ICOSUBDIVISION = 0;
  ico.init();
  
  
  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < 6; i++) {
    pushMatrix();
    noStroke();
    fill(rcol());
    float x = random(-width, width);
    float y = random(-height, height);
    float z = random(-60, 400);
    points.add(new PVector(x, y, z));
    translate(x, y, z);
    rotate(random(TAU));
    scale(0.3);
    ico.show(36);
    
    float s = 9;

    translate(0, 0, -90);
    noStroke();
    fill(0);
    box(s);
    stroke(0);
    noFill();
    line(-s*0.5, -s*0.5, 6, -14, -14, 100);
    line(+s*0.5, -s*0.5, 6, +14, -14, 100);
    line(+s*0.5, +s*0.5, 6, +14, +14, 100);
    line(-s*0.5, +s*0.5, 6, -14, +14, 100);
    popMatrix();
  }
  popMatrix();
}
