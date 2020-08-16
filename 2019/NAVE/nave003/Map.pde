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
      time += lerp(time, 1, 0.1);
    } else {
      time += lerp(time, 0, 0.2);
    }
  }

  void show() {
    cam.beginHUD();
    tint(255, time*255);
    image(frame, width*0.5, height*0.5);
    noTint();
    noStroke();
    fill(0, 120);
    rect(width*0.5, height*0.5, width, height);
    cam.endHUD();
  }

  void active() {
    activeMap = !activeMap;
    if (activeMap) {
      frame = get();
      frame.filter(GRAY);
    }
  }
}
