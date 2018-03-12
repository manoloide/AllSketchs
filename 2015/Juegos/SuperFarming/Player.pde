class Player {
  ArrayList<Selectable> selected;
  boolean click, press, release;
  float x, y;
  int tx, ty;
  PVector posClick, posRelease;
  Player() {
    selected = new ArrayList<Selectable>();
  }
  void update() {
    x = mouseX-camera.x;
    y = mouseY-camera.y;
    if (click && mouseButton == RIGHT) {
      actuate();
    }
    if (release && mouseButton == LEFT) {
      deselect();
      select();
    }
    click = false;
    release = false;
  }

  void show() {
    int ts = map.tileSize;
    tx = int(x+ts/2)/ts;
    ty = int(y+ts/2)/ts;
    noFill();
    stroke(0, 20);
    rect(tx*ts, ty*ts, ts, ts);
    if (press) {
      stroke(40, 255, 40);
      fill(40, 255, 40, 60);
      rectMode(CORNERS);
      rect(x, y, posClick.x, posClick.y);
      rectMode(CENTER);
    }
  }

  void clicked() {
    posClick = new PVector(x, y);
    click = true;
    if (mouseButton == LEFT) {
      press = true;
    }
  }

  void released() {
    posRelease = new PVector(x, y);
    press = false;
    release = true;
  }

  void select() {
    for (int i = 0; i < map.entities.size (); i++) {
      Entity e = map.entities.get(i);
      if (e.isSelected()) {
        selected.add(e);
        if (dist(posClick.x, posClick.y, posRelease.x, posRelease.y) < 5) {
          break;
        }
      }
    }
    for (int i = 0; i < selected.size (); i++) {
      Selectable s = selected.get(i);
      s.select();
    }
  }

  void deselect() {
    for (int i = 0; i < selected.size (); i++) {
      Selectable s = selected.get(i);
      s.deselect();
    }
    selected = new ArrayList<Selectable>();
  }

  void actuate() {
    for (int i = 0; i < selected.size (); i++) {
      Selectable s = selected.get(i);
      s.action();
    }
  }
}
