class Map {
  boolean activeMap;
  float time;
  PImage frame;
  Map() {
    frame = get();
    frame.filter(GRAY);

    activeMap = false;
  }

  void update() {
    if (activeMap) {
      time = lerp(time, 1, 0.1);
    } else {
      time = lerp(time, 0, 0.2);
    }
  }

  void show() {
    if (time*255 < 2) return;
    tint(255, time*255);
    //image(frame, width*0.5, height*0.5);
    noTint();
    noStroke();
    //fill(0, 180);
    //rect(width*0.5, height*0.5, width-10, height-10);


    int tt = 5;
    float ss = height*1./21;
    hint(DISABLE_DEPTH_TEST);

    pushMatrix();
    translate(width*0.5, height*0.5);
    rotateX(PI*0.2);
    rotateY(globalTime*0.1);
    stroke(240);
    strokeWeight(2);
    beginShape(POINTS);
    for (int k = -tt; k <= tt; k++) {
      for (int j = -tt; j <= tt; j++) {
        for (int i = -tt; i <= tt; i++) {
          vertex(i*ss, j*ss, k*ss);
        }
      }
    }
    endShape();

    randomSeed(world.seed);
    noiseSeed(world.seed);

    ArrayList<PVector> points = new ArrayList<PVector>();

    noStroke();
    for (int k = -tt; k <= tt; k++) {
      for (int j = -tt; j <= tt; j++) {
        for (int i = -tt; i <= tt; i++) {
          if (random(1) > 0.03) continue;
          PVector p = new PVector(i*ss, j*ss, k*ss);
          pushMatrix();
          translate(p.x, p.y, p.z);
          fill(rcol());
          box(ss*0.2);
          popMatrix();
        }
      }
    }
    popMatrix();

    ArrayList<Triangle> triangles = new ArrayList<Triangle>();
    beginShape(TRIANGLES);
    for (int i = 0; i < triangles.size(); i++) {
      Triangle t = triangles.get(i);
      vertex(t.p1.x, t.p1.y, t.p1.z);
      vertex(t.p2.x, t.p2.y, t.p2.z);
      vertex(t.p3.x, t.p3.y, t.p3.z);
    }
    endShape();

    hint(ENABLE_DEPTH_TEST);
  }

  void active() {
    activeMap = !activeMap;
    if (activeMap) {
      frame = get();
      frame.filter(GRAY);
      changeScene("MAP");
    } else {
      changeScene("GAME");
    }
  }
}
