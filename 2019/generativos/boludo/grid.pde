void grid(float grid) {
  int back = rcol();
  background(back);


  float hor = grid*5;

  noStroke();
  fill(rcol());
  rectMode(CORNER);
  rect(0, hor, width, height-hor);

  ArrayList<PVector> points = new ArrayList<PVector>(); 

  blendMode(ADD);
  noFill();
  for (int i = 0; i < 60; i++) {
    float x = random(width);
    float y = random(height);
    float s = grid*int(random(12));
    x -= x%grid;
    y -= y%grid;
    stroke(rcol(), 60);
    noFill();
    rect(x, y, s, s);
    noStroke();
    noFill();
    if (random(1) < 0.3) fill(rcol(), 10);
    rect(x, y, s, s);
    fill(rcol(), 180);
    if (random(1) < 0.1) rect(x, y, s*0.01, s*0.01);

    float ss = s*0.04;
    float cx = x+(s)*0.5;
    float cy = y+(s)*0.5;
    rect(cx-ss*0.5, cy-ss*0.5, ss, ss);

    points.add(new PVector(cx, cy));
  }

  ArrayList<Triangle> triangles = Triangulate.triangulate(points);
  beginShape(TRIANGLE);
  noFill();
  stroke(255, 40);
  for (int i = 0; i < triangles.size(); i++) {
    if(random(1) < 0.8) continue;
    Triangle t = triangles.get(i);
    vertex(t.p1.x, t.p1.y);
    vertex(t.p2.x, t.p2.y);
    vertex(t.p3.x, t.p3.y);
  }
  endShape(CLOSE);

  noStroke();
  blendMode(NORMAL);



  noStroke();
  beginShape();
  fill(rcol(), 80);
  vertex(0, 0);
  vertex(width, 0);
  fill(rcol(), 0);
  vertex(width, +hor);
  vertex(0, +hor);
  endShape(CLOSE);



  beginShape();
  fill(255, 20);
  vertex(width, hor);
  vertex(0, hor);
  fill(255, 0);
  vertex(0, height);
  vertex(width, height);
  endShape(CLOSE);


  for (int i = 0; i < height; i+=grid*2) {
    float y1 = i;
    float y2 = i+grid*random(1);
    beginShape();
    fill(255, random(12)*random(1));
    vertex(width, y1);
    vertex(0, y1);
    fill(255, 0);
    vertex(0, y2);
    vertex(width, y2);
    endShape(CLOSE);
  }


  int col = rcol();
  rectMode(CENTER);
  fill(col, 90);
  while (back == col) col = rcol();
  for (int j = 10; j <= height; j+=10) {
    for (int i = 10; i <= width; i+=10) {
      rect(i, j, 1, 1);
    }
  }

  for (int i = 0; i < 1000; i++) {
    float x = random(width);
    float y = random(height);
    x -= x%(grid*0.5);
    y -= y%(grid*0.5);
    noStroke();
    fill(255, random(20, 70));
    rect(x, y, 2, 2);

    if (random(1) < 0.01) {
      noStroke();
      fill(255, 40);
      ellipse(x, y, grid*0.2, grid*0.2);

      noFill();
      fill(rcol(), 40);
      //stroke(255, 90);
      ellipse(x, y, grid, grid);
      noFill();
      ellipse(x, y, grid+4, grid+4);
      for (float k = 0; k < 5; k++) {
        float yy = (grid+4)*0.5+k*10;
        stroke(255, 60-10*k);
        line(x, y+k, x, y+k+6);
      }
    }
  }
}
