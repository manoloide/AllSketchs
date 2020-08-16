class Square {
  boolean on, select, active;
  float x, y, s;
  int ix, iy;
  int lastClick = 0;
  float amp;
  int col = 200;
  Square(float x, float y, int ix, int iy, float s) {
    this.x = x; 
    this.y = y; 
    this.s = s;
    this.ix = ix;
    this.iy = iy;
    amp = 1;
    active = (random(1) < 0.5);
    if (active) col = 200;
    else col = 30;
  }
  void update() {

    float ns = s*0.5*amp;
    on = (mouseX > x-ns && mouseX < x+ns && mouseY > y-ns && mouseY < y+ns);

    if (on) amp = lerp(amp, 1.06, 0.3); 
    else amp = lerp(amp, 1.0, 0.3);
  }
  void show() {
    noStroke();
    fill(col);
    if (select) fill(col+5);
    if (on) fill(col+10);
    rect(x, y, s*amp, s*amp);
    textAlign(CENTER, CENTER);
    fill(255, 0, 0);
    text(lastClick, x, y-s*0.03);
  }

  void mouseClick(int click) {
    click(click);
    
    if (ix > 0)  grid[ix-1][iy].click(click);
    if (ix < grid.length-1)  grid[ix+1][iy].click(click);
    if (iy > 0)  grid[ix][iy-1].click(click);
    if (iy < grid[0].length-1)  grid[ix][iy+1].click(click);
    
    
    if (ix > 0 && iy > 0)  grid[ix-1][iy-1].click(click);
    if (ix > 0 && iy < grid[0].length-1)  grid[ix-1][iy+1].click(click);
    if (ix < grid.length-1 && iy > 0)  grid[ix+1][iy-1].click(click);
    if (ix < grid.length-1 && iy < grid[0].length-1)  grid[ix+1][iy+1].click(click);
  }  

  void click(int click) {
    lastClick = click;
    active = !active;
    if (active) col = 200;
    else col = 30;

    /*
    if (ix > 0 && grid[ix-1][iy].lastClick != lastClick) {
     if (grid[ix-1][iy].active != active)
     grid[ix-1][iy].click(click);
     }
     if (iy > 0 && grid[ix][iy-1].lastClick != lastClick) {
     if (grid[ix][iy-1].active != active)
     grid[ix][iy-1].click(click);
     }
     
     if (ix+1 < grid.length && grid[ix+1][iy].lastClick != lastClick) { 
     if (grid[ix+1][iy].active != active)
     grid[ix+1][iy].click(click);
     }
     if (iy+1 < grid[0].length && grid[ix][iy+1].lastClick != lastClick) {
     if (grid[ix][iy+1].active != active)
     grid[ix][iy+1].click(click);
     }
     */
  }
}
