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
    image(frame, width*0.5, height*0.5);
    noTint();
    noStroke();
    fill(0, 180);
    rect(width*0.5, height*0.5, width-10, height-10);


    int tt = 20;
    float ss = 10;
    hint(DISABLE_DEPTH_TEST);

    pushMatrix();
    translate(width*0.5, height*0.5);
    rotateX(PI*0.2);
    rotateY(time*0.05);
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
    popMatrix();

    hint(ENABLE_DEPTH_TEST);
  }

  void active() {
    activeMap = !activeMap;
    if (activeMap) {
      frame = get();
      frame.filter(GRAY);
    }
  }
}
