void newForms() {
  forms = new ArrayList<Form>();

  boolean useGrid[][] = new boolean[grid.cw][grid.cw];
  int emptys = grid.cw*grid.cw;
  while (emptys > 0) {
    float t = grid.t;
    int w = int(random(1, grid.cw));
    int h = w;//int(random(1, grid.ch));
    int x = int(random(grid.cw-w+1));
    int y = int(random(grid.ch-h+1));
    boolean colision = true; 
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        if (useGrid[x+i][y+j]) { 
          colision = false; 
          break;
        }
      }
    }
    if (colision) {
      for (int j = 0; j < h; j++) {
        for (int i = 0; i < w; i++) {
          useGrid[x+i][y+j] = true;
        }
      }
      forms.add(new Form(grid.x+x*t, grid.y+y*t, w*t, h*t));
      emptys -= w*h;
    }
  }
}

class Form {
  color col;
  float x, y, w, h;
  Form(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y; 
    this.w = w;
    this.h = h;

    col = color(random(80, 256), random(80, 256), random(80, 256));
  }
  void show() {
    noStroke();
    fill(col, 50);
    rect(x, y, w, h);
    ellipse(x+w/2, y+h/2, w, h);
    ellipse(x+w/2, y+h/2, w*0.1, h*0.1);
  }
}

class Grid {
  int cw, ch;
  float x, y, w, h, t;
  Grid(float x, float y, float w, float h, float t) {
    this.x = x; 
    this.y = y; 
    this.w = w;
    this.h = h;
    this.t = t;
    cw = int(w/t);
    ch = int(h/t);
  }  
  void show() {
    noStroke();
    fill(255, 40);
    for (float j = y; j <= y+h; j+=t) {  
      for (float i = x; i <= x+w; i+=t) {
        ellipse(i, j, 3, 3);
      }
    }
  }
}
