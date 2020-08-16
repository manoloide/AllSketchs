ArrayList<PVector> arboles;

void arboles() {
  arboles = new ArrayList<PVector>();
  int cc = int(random(300, 800)*0.1);
  for (int i = 0; i < cc; i++) {
    float x = random(-width, width);
    float y = random(-height, height); 
    float s = width*random(0.06, 0.08);

    boolean add = true;
    float sca = 0.42;
    if (x >= -width*sca && x <= width*sca && y >= -height*sca && y <= height*sca) {
      add = false;
    }
    if (add) {
      for (int j = 0; j < arboles.size(); j++) {
        PVector o = arboles.get(j);
        if (dist(x, y, o.x, o.y) < (o.z+s)*0.5) {
          add = false;
          break;
        }
      }
    }
    if (add) {
      for (int j = 0; j < barcos.size(); j++) {
        PVector o = barcos.get(j);
        if (dist(x, y, o.x, o.y) < (o.z+s)*0.5) {
          add = false;
          break;
        }
      }
    }
    if (add) {
      arboles.add(new PVector(x, y, s));

      int col = rcol();

      noFill();
      stroke(255, 230);
      pushMatrix();
      translate(x, y);
      //fill(col, 80);
      ellipse(0, 0, s, s);


      fill(col);
      for (int l = 0; l < 8; l++) {
        float ss = s*random(0.15, 0.2)*0.6;
        pushMatrix();
        translate(0, 0, ss*0.5);
        rotate(random(TAU));
        noStroke();
        float mr = random(0.18, 0.22);
        for (int k = 0; k < 1000; k++) {
          box(ss*0.4, ss*0.4, ss);
          ss *= random(0.95, 0.98);
          translate(0, 0, ss*0.6);
          rotate(random(-0.1, 0.1));
          float amp = 1;
          if (random(1) < 0.03) amp = random(3);
          rotateX(random(-mr, mr)*amp);
          rotateY(random(-mr, mr)*amp);
          rotateZ(random(-mr, mr)*amp);
        }
        popMatrix();
      }
      for (int l = 0; l < 16; l++) {
        float ss = s*random(0.15, 0.2)*0.4;
        pushMatrix();
        translate(0, 0, ss*0.5);
        rotate(random(TAU));
        noStroke();
        float mr = random(0.18, 0.22)*2.2;
        for (int k = 0; k < 1000; k++) {
          box(ss*0.4, ss*0.4, ss);
          ss *= random(0.95, 0.97)*0.99;
          translate(0, 0, -ss*0.6);
          rotateX(random(-mr, mr));
          rotateY(random(-mr, mr));
          rotateZ(random(-mr, mr));
        }
        popMatrix();
      }
      popMatrix();
    }
  }
}
