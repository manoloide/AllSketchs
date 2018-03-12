class Entity {
  boolean remove;
  float x, y;
  void update() {
  }

  void show() {
  }
}

class Building extends Entity {
}

class Factory extends Building {
}


class Unit extends Entity {
  boolean selected, move; 
  float dx, dy;

  void update() {
    if (move) {
      float a = atan2(dy-y, dx-x);
      x += cos(a);
      y += sin(a);
      if (abs(x-dx) < 0.5 && abs(y-dy) < 0.5) move = false;
    }
    if (click && mouseButton == LEFT) {
      if (dist(mouseX/2, mouseY/2, x, y) < 10) selected = true;
      else selected = false;
    }
  }

  void setDestination(float ax, float ay) {
    dx = ax; 
    dy = ay;
    if (abs(x-dx) > 0.5 || abs(y-dy) > 0.5) move = true;
  }
}

class Worker extends Unit {
  Worker(float x, float y) {
    this.x = x; 
    this.y = y;
    setDestination(x, y);
  }
  void update() {
    super.update();
    if (selected && click) {
      setDestination(mouseX/2, mouseY/2);
    }
    show();
  }
  void show() {
    render.pushStyle();
    render.imageMode(CENTER);
    render.image(tiles[2][1], x, y);
    if (selected) render.rect(x, y, 3, 3);
    render.popStyle();
  }
}

