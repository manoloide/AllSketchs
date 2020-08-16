class Player {
  boolean right, down, left, up, punch;
  boolean walking;
  int x, y;
  int dir;
  int timePunch;
  PImage sprite[][];
  Player(int x, int y) {
    this.x = x;
    this.y = y;
    dir = 0;
    left = down = right = up = punch = false;
    sprite = new PImage[4][5];
    for (int j = 0; j < 5; j++) {
      for (int i = 0; i < 4; i++) {
        sprite[i][j] = createImage(20, 20, ARGB);
        sprite[i][j].copy(sprites, 20*i, 20+20*j, 20, 20, 0, 0, 20, 20);
      }
    }
  }
  void update() {
    if (punch && timePunch <= 0) {
      timePunch = 10;
    } else {
      timePunch--;
      if (timePunch <= 0) {
        punch = false;
        timePunch = 0;
      }
    }

    move();
  }
  void show() {
    int xx = (render.width/2)-int(camera.x)+x;
    int yy = (render.width/2)-int(camera.y)+y;
    render.beginDraw();
    render.imageMode(CENTER);
    render.rectMode(CENTER);
    render.noStroke();
    render.fill(255, 40+20*abs(cos(frameCount*0.1)));
    int frame = 0;
    if (walking) frame = (frameCount/8)%4;
    if (timePunch > 0) frame = 4;

    //render.ellipse(xx, yy, 40, 40);
    render.image(sprite[dir][frame], xx, yy-5);
    /*
     render.rect(xx, yy, 10, 10);
     render.stroke(138, 255, 0, 120);
     render.line(render.width/2, 0, render.width/2, render.height);
     render.line(0, render.height/2, render.width, render.height/2);
     */
    level.colision(x, y, 10, 10);

    render.endDraw();
  }
  void move() {
    int ax = x;
    int ay = y;
    if (right) {
      dir = 0;
      x += 1;
    } else if (down) {
      dir = 1;
      y += 1;
    } else if (left) {
      dir = 2;
      x -= 1;
    } else if (up) {
      dir = 3;
      y -= 1;
    }
    if (timePunch == 10) {
      if (dir == 0) {
        x += 2;
      } else if (dir == 1) {
        y += 2;
      } else if (dir == 2) {
        x -= 2;
      } else if (dir == 3) {
        y -= 2;
      }
    }
    walking = false; 
    if (ax != x || ay != y) {
      walking = true;
      if ((punch && timePunch != 10)|| level.colision(x, y, 10, 10)) {
        walking = false;
        x = ax;
        y = ay;
      }
    }
  }
  void press() {
    if (key == 'd' || keyCode == RIGHT) right = true;
    if (key == 's' || keyCode == DOWN) down = true;
    if (key == 'a' || keyCode == LEFT) left = true;
    if (key == 'w' || keyCode == UP) up = true;
    if (key == ' ') punch = true;
  }
  void release() {
    if (key == 'd' || keyCode == RIGHT) right = false;
    if (key == 's' || keyCode == DOWN) down = false;
    if (key == 'a' || keyCode == LEFT) left = false;
    if (key == 'w' || keyCode == UP) up = false;
    if (key == ' ') punch = false;
  }
}

