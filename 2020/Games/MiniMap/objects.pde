ArrayList<Object> objects = new ArrayList<Object>();

class Object {
  boolean remove;
  float x, y, w, h;
  Object(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y; 
    this.w = w; 
    this.h = h;
    remove = false;
  }
  void update() {
  }
  void show() {
  }
}

class Coin extends Object {
  float desTime;
  Coin(float x, float y, float w, float h) {
    super(x, y, w, h); 
    desTime = HALF_PI*int(random(4));
  }
  void update() {
    if (rectCollision(x, y, w, h, player.position.x, player.position.y, player.w, player.h)) {
      stats.coins++;
      remove = true;
    }
  }
  void show() {
    float xx = x;
    float yy = y+cos(global.time+desTime);
    float osc = (1+cos(global.time+desTime)*0.1);
    float rot = abs(cos(global.time*3+desTime));
    fill(getColor(global.time*0.1+desTime*colors.length-rot*0.2));
    ellipse(xx, yy, w*(0.5*rot+0.2)*osc, h*osc);
  }
}

class Portal extends Object {
  boolean on;
  float scale = 1;
  Portal(float x, float y, float w, float h) {
    super(x, y, w, h);
  }

  void update() {
    if (rectCollision(x, y, w, h, player.position.x, player.position.y, player.w, player.h)) {
      on = true;
    }

    if (on) {
      player.position.lerp(new PVector(x, y), 0.9);
      scale *= 1.1;
      if (scale > width*4./tileSize) {
        nextLevel();
      }
    }
  }

  void show() {
    int cc = 8;
    for (int i = 1; i <= cc; i++) {
      float s = (1-i*1./cc)*(1+cos(global.time)*0.2)*scale*2;
      fill(getColor(i*0.5+global.time*3));
      ellipse(x, y, w*s, h*s);
    }
  }
}

class Springboard extends Object {
  Springboard(float x, float y, float w, float h) {
    super(x, y, w, h);
  }
  void update() {
    if (rectCollision(x, y, w-2, h, player.position.x, player.position.y, player.w, player.h)) {
      player.velocity.y = -player.jump*1.3;
    }
  }
  void show() {
    rectMode(CENTER);
    fill(colors[1]);
    rect(x, y, w, h);
  }
}
