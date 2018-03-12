void setup() {
  size(640, 640, P3D);
  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void generate() {
  hint(DISABLE_DEPTH_TEST);
  beginShape();
  fill(240, 160, 0);
  vertex(0, 0); 
  vertex(width, 0);
  fill(220, 120, 0);
  vertex(width, height);
  vertex(0, height);
  endShape();
  hint(ENABLE_DEPTH_TEST);

  translate(width/2, height/2, -300);
  rotateX(-PI*random(0.1, 0.22));
  scale(0.2);

  for (int yy = -2000; yy <= 2000; yy+=200) {
    for (int xx = -2000; xx <= 2000; xx+=200) {
      pushMatrix();
      translate(xx, 0, yy);
      noStroke();
      lights();
      fill(220, 220, 80);
      pushMatrix();
      scale(1, 0.2, 1); 
      sphere(20);
      popMatrix();

      int cc = int(random(5, 9));
      int seg = 12; 
      float da = TWO_PI/cc;
      float separation = random(2, 10);
      float angleClose = random(-0.1, 0.3);
      for (int i = 0; i < cc; i++) {     
        rotateY(da); 
        pushMatrix(); 
        translate(0, 4+random(-0.5, 0.5), 0);
        float ang = PI;
        PVector line, aline;
        float sep = separation;
        float amp = random(16, 32);
        line = new PVector();
        stroke(0);
        for (int j = 0; j < seg; j++) {
          aline = new PVector(line.x, line.y, line.z);
          ang += random(angleClose);
          sep += random(1);
          random(PI/3);
          float c1 = map(j-1, 0, seg-1, 200, 255);
          float c2 = map(j, 0, seg-1, 200, 255);
          float ampAct = sin(map(j, -2, seg-1, 0, PI))*amp;
          float ampAnt = sin(map(j-1, -2, seg-1, 0, PI))*amp;
          line.x += cos(ang)*sep;
          line.y += sin(ang)*sep;
          /*
      line(line.x, line.y, aline.x, aline.y);
           point(line.x, line.y, -ampAct);
           point(line.x, line.y, ampAct);
           */
          noStroke();
          beginShape();
          fill(c2);
          vertex(line.x, line.y, 0);
          vertex(line.x, line.y, ampAct);
          fill(c1);
          vertex(aline.x, aline.y, ampAnt);
          vertex(aline.x, aline.y, 0);
          endShape();
          beginShape();
          fill(c2);
          vertex(line.x, line.y, -ampAct);

          vertex(line.x, line.y, 0);
          fill(c1);
          vertex(aline.x, aline.y, 0);
          vertex(aline.x, aline.y, -ampAnt);
          endShape();
        }
        popMatrix();
      }
      translate(0, 4, 0);
      fill(80, 220, 120);
      float amp = 2;
      float addAmp = random(0.01);
      PVector pos = new PVector();
      float daa = TWO_PI/8;
      for (int i = 0; i < 50; i++) {
        for (int j = 1; j < 8; j++) {
          amp += addAmp;
          beginShape();
          vertex(cos(daa*(j+1))*amp, i*5, sin(daa*(j+1))*amp);
          vertex(cos(daa*(j+1))*amp, (i-1)*5, sin(daa*(j+1))*amp);
          vertex(cos(daa*j)*amp, (i-1)*5, sin(daa*j)*amp);
          vertex(cos(daa*j)*amp, i*5, sin(daa*j)*amp);
          endShape();
        }
      }
      popMatrix();
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

