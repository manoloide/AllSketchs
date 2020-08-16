class Entity extends Selectable {
  boolean remove;
  float x, y;
  void update() {
  };
  void show() {
  };
}

class Unit extends Entity {
  boolean moved;
  float dx, dy, vel = 10;
  void action() {
    moved = true;
    dx = player.tx*map.tileSize;//player.x;
    dy = player.ty*map.tileSize;//player.y;
  }
  boolean isSelected() {
    selected = false;
    /*
    if(dist(x, y, player.x, player.y) < 30){
     selected = true;
     }*/
    PVector cl = player.posClick;
    if (min(cl.x, player.x) < x && max(cl.x, player.x) > x && min(cl.y, player.y) < y && max(cl.y, player.y) > y) {
      selected = true;
    } 
    if(dist(x, y, cl.x, cl.y) < 15){
       selected = true; 
    }
    return selected;
  }
}

class Villager extends Unit {
  Villager(float x, float y) {
    this.x = x;
    this.y = y;
  }
  void update() {
    if (moved) {
      float a = atan2(dy-y, dx-x);
      x += cos(a) * vel;
      y += sin(a) * vel;
      if (dist(dx, dy, x, y) < vel) {
        moved = false;
        x = dx;
        y = dy;
      }
    }
  }
  void show() {
    int tt = 30;
    noStroke();
    if (selected) {
      stroke(#FA5B70);
    }
    fill(#F73950);
    ellipse(x, y, tt, tt);
  }
}

class Selectable {
  boolean selected; 
  boolean isSelected() {
    selected = true;
    return selected;
  }
  void select() {
    selected = true;
  }
  void deselect() {
    selected = false;
  }
  void action() {
  }
}
