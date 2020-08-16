class TouchManager {
  ArrayList<Touch> touchs;
  boolean click;
  int cantTouchs;
  TouchManager() {
    touchs = new ArrayList<Touch>();
    cantTouchs = 0;
  }

  void update() {
    click = false;
    if (cantTouchs != touchs.size()) {
      cantTouchs = touchs.size();
      click = true;
    }
    for (int i = 0; i < touchs.size (); i++) {
      Touch t = touchs.get(i);
      t.update();
      if (t.remove) touchs.remove(i--);
    }
  }

  void show() {
    for (int i = 0; i < touchs.size (); i++) {
      Touch t = touchs.get(i);
      t.show();
    }
  }

  Touch click(float x, float y, float r) {
    if (!click) return null;
    for (int i = 0; i < touchs.size (); i++) {
      Touch t = touchs.get(i);
      if (t.click && !t.used) {
        float dist = dist(t.x, t.y, x, y);
        if (dist < r+t.s*0.5) {
          t.used = true;
          return t;
        }
      }
    }
    return null;
  }

  void addTouch(int id, float x, float y) {
    touchs.add(new Touch(id, x, y));
  }

  void updateTouch(int id, float x, float y) {
    for (int i = 0; i < touchs.size (); i++) {
      Touch t = touchs.get(i);
      if (t.id == id) {
        t.set(x, y);
        break;
      }
    }
  }

  void removeTouch(int id) {
    for (int i = 0; i < touchs.size (); i++) {
      Touch t = touchs.get(i);
      if (t.id == id) {
        t.released();
        break;
      }
    }
  }
}  

class Touch {
  boolean remove, used;
  boolean click, press, release;
  int id;
  float x, y, s, nx, ny, px, py;
  Touch(int id, float x, float y) {
    this.id = id;
    this.x = px = nx = x; 
    this.y = py = ny = y; 
    s = 26;
    click = press = true;
    release = used = false;
  }
  void update() {
    px = x; 
    py = y;
    x += (nx-x)*0.9;
    y += (ny-y)*0.9;
    if (release) remove = true;
  }

  void show() {
    noStroke();
    fill(255, 0, 0, 60);
    ellipse(x, y, s*1.5, s*1.5);
    fill(255, 0, 0, 160);
    ellipse(x, y, s, s);
    fill(0);
    text(id, x, y);
  }

  void set(float x, float y) {    
    click = false;
    nx = x; 
    ny = y;
  }

  void released() {
    used = false;
    press = false;
    release = true;
  }
}  

