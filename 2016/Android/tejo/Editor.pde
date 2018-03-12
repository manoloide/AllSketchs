class Editor {
  boolean moved;
  float scrollTime;
  int cx, cy;
  int w, h;
  int tileSelect = 0;
  int colors[] = {
    #292329, #807E7E, #FF8013, #00EA35
  };
  int tiles[][];
  Editor() {    
    w = width/tileSize+1;
    h = height/tileSize+1;
    tiles = new int[w][h];
    scrollTime = 0;
  }
  void update() {    
    if (tileSelect < 0) tileSelect += colors.length;
    tileSelect %= colors.length;

    if (moved) {
      cx += mouseX-pmouseX;
      cy += mouseY-pmouseY;
    }

    if (mousePressed && mouseButton == CENTER) {
      moved = true;
    } else {
      moved = false;
    }

    if (mousePressed && mouseButton == LEFT) {
      int mx = (mouseX-cx)/tileSize;
      int my = (mouseY-cy)/tileSize;
      if (mx >= 0 && mx < w && my >= 0 && my < h) {
        tiles[mx][my] = tileSelect;
      }
    }

    pushStyle();
    show();
    popStyle();
  }
  void show() {
    background(#292329);

    pushMatrix();
    translate(cx, cy);
    noStroke();
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        image(tilesImages[tiles[i][j]], i*tileSize, j*tileSize);
      }
    }
    stroke(0, 80);
    for (int i = 0; i < w+1; i++) {
      line(i*tileSize, 0, i*tileSize, h*tileSize);
    }
    for (int i = 0; i < h+1; i++) {
      line(0, i*tileSize, w*tileSize, i*tileSize);
    }
    popMatrix();

    rectMode(CENTER);
    stroke(240);
    strokeWeight(3);
    scrollTime *= 0.8;
    for (int i = -3; i <= 3; i++) {
      float tt = 80-20*pow(abs(i+scrollTime), 1.5);
      if (tt < 0) continue;
      fill(colors[(i+colors.length+tileSelect)%colors.length]);
      rect(width/2+80*(i+scrollTime), height-60, tt, tt, 3);
    }

    float x = width/2;
    float y = height/2;

    noStroke();
    for (int i = 0; i < 4; i++) {
      fill((i%2==0)? 0 : 255, 2.55*2);
      arc(x, y, 260, 260, HALF_PI*i, HALF_PI*(i+1));
    }
    stroke(255, 2.55*40);
    noFill();
    ellipse(x, y, 260, 260);
    noStroke();
    fill(255, 2.55*5);
    ellipse(x, y, 180, 180);
    fill(255, 2.55*50);
    ellipse(x, y, 16, 16);
  }
}

