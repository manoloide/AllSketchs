public class ColorSchemes {
  boolean view = false;
  int selX, selY, selC;
  int colors[][] = {{#ff00ff, #000000, #ff0000, #ff00cc, #ffffff}, {#ff00ff, #000000, #ff0000, #ff00cc}};
  PApplet parent;
  public ColorSchemes(PApplet parent) {
    this.parent = parent;
    parent.registerMethod("keyEvent", this);
    parent.registerMethod("mouseEvent", this);
    parent.registerMethod("dispose", this);

    load();
  }
  void show() {
    if (!view) return;
    float hh = height*1./colors.length;
    for (int  j= 0; j < colors.length; j++) {
      float ww = width*1./colors[j].length;
      for (int i = 0; i < colors[j].length; i++) {
        float xx = i*ww;
        float yy = j*hh;
        int col = colors[j][i];
        boolean on = (selX == i && selY == j);
        stroke(col);
        if (on) stroke(0);
        fill(col);
        rect(i*ww, j*hh, ww-0.5, hh-3);
        noStroke();
        for (int k = 0; k < int(ww); k++) {
          fill(getColor(i+k/ww-0.5, j));
          rect(i*ww+k, (j+1)*hh-2, 1, 2);
        }

        if (on) {
          fill(invert(col));
          ellipse(xx+ww*0.5, yy+hh*0.25, ww*0.2, ww*0.2);

          stroke(0); 
          fill(255);
          float hhh = (hh-6)/6.;
          float vals[] = {red(col)/255., green(col)/255., blue(col)/255.};
          for (int k = 0; k < 3; k++) {
            rect(xx+vals[k]*(ww-4), yy+hh*0.5+hhh*k, 3, hhh);
          }
        }
      }
    }
  }

  public void keyEvent(KeyEvent event) {
    switch(event.getAction()) {
    case KeyEvent.PRESS:
      keyPressed();
      break;
    }
  }

  void keyPressed() {
    if (!view) return;
    if (key == 'l') load();
    if (key == 's') save();
    if (key == BACKSPACE) {
      int[] n = new int[colors[selY].length-1];
      arraycopy(colors[selY], 0, n, 0, selX );
      arraycopy(colors[selY], selX+1, n, selX, colors[selY].length - selX-1);
      colors[selY] = n;
    }
  }

  public void mouseEvent(MouseEvent event) {
    switch (event.getAction()) {
    case MouseEvent.PRESS:
      mousePressed();
      break;
    case MouseEvent.RELEASE:
      // do something for mouse released
      break;
    case MouseEvent.CLICK:
      mouseClicked(event);
      break;
    case MouseEvent.DRAG:
      mouseDragged();
      break;
    case MouseEvent.MOVE:
      // do something for mouse moved
      break;
    }
  }

  void mousePressed() {
    if (!view) return;
    selY = int(map(mouseY, 0, height+1, 0, colors.length));
    selX = int(map(mouseX, 0, width+1, 0, colors[selY].length));
    selC = int(map(mouseY, 0, height+1, 0, colors.length*6))%6-3;
  }

  void mouseClicked(MouseEvent evt) {
    if (evt.getCount() == 2) doubleClick();
  }

  void mouseDragged() {
    if (!view) return;
    float mx = mouseX-pmouseX;
    int col = colors[selY][selX];
    if (selC == 0) {
      colors[selY][selX] = color(red(col)+mx, green(col), blue(col));
    }
    if (selC == 1) {
      colors[selY][selX] = color(red(col), green(col)+mx, blue(col));
    }
    if (selC == 2) {
      colors[selY][selX] = color(red(col), green(col), blue(col)+mx);
    }
  }

  void doubleClick() {
    if (!view) return;
    float val = map(mouseX, 0, width+1, 0, colors[selY].length-1);
    color col = getColor(val-0.5);
    int sel = int(val+.5);
    if (sel < 0) sel = 0;
    colors[selY] = append(colors[selY], color(random(256), random(256), random(256)));
    for (int i = colors[selY].length-1; i > sel; i--) {
      colors[selY][i] = colors[selY][i-1];
    }
    colors[selY][sel] = color(random(256), random(256), random(256));
  }

  int rcol() {
    return colors[selY][int(random(colors.length))];
  }

  int getColor(float v) {
    return getColor(v, selY);
  }

  int getColor(float v, int sy) {
    int len = colors[sy].length;
    if (v < 0) v = len-abs(v%len);
    else v = v%len;
    int c1 = colors[sy][int(v%len)];
    int c2 = colors[sy][int((v+1)%len)];
    float m = v%1;
    return lerpColor(c1, c2, m);
  }

  int invert(int col) {
    return color(255-red(col), 255-green(col), 255-blue(col));
  }

  public void dispose() {
    save();
  }

  void save() {
    JSONArray schemes = new JSONArray();
    for (int j = 0; j < colors.length; j++) {
      JSONArray cols  = new JSONArray(); 
      for (int i = 0; i < colors[j].length; i++) {
        cols.append((int)colors[j][i]);
      }
      schemes.append(cols);
    }

    saveJSONArray(schemes, "data/schemes.json");
  }

  void load() {
    File f = new File(dataPath("schemes.json"));
    if (f.exists()) {
      JSONArray json = loadJSONArray("data/schemes.json");
      colors = new int[json.size()][];
      for (int i = 0; i < json.size(); i++) {
        JSONArray cols  = json.getJSONArray(i); 
        colors[i] = new int[cols.size()];
        for (int j = 0; j < cols.size(); j++) {
          colors[i][j] = cols.getInt(j);
        }
      }
    }
  }
}