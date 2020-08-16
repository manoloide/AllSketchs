class Gui {
  ArrayList<Window> windows;
  PFont font;
  Gui() {
    font = createFont("Moon Bold", 14, true);
    windows = new ArrayList<Window>();
    windows.add(new Settings(this, 10, 10));
  }
  void update() {
    for (int i = 0; i < windows.size (); i++) {
      Window w = windows.get(i);
      w.update();
    }
  }
}

class Window {
  ArrayList<Component> components;
  boolean on, view, move, select;
  Gui gui;
  int x, y, w, h;
  PFont font; 
  PGraphics render;
  String name;
  Window(Gui gui, int x, int y, String name) {
    this.gui = gui;
    this.x = x;
    this.y = y;
    this.name = name;
    font = gui.font;
    on = move = select = false;
    components = new ArrayList<Component>();
    w = 160;
    h = 320;
    render = createGraphics(w, h);
    render();
  }

  void update() {
    if (!mousePressed) {
      move = false;
      select = false;
    }
    if (move) {
      x += mouseX-pmouseX;
      y += mouseY-pmouseY;
    }
    on = false;
    if (mouseX >= x && mouseX < x+w && mouseY >= y && mouseY < y+h) {
      on = true;
    }
    if (on && click) {
      if (mouseY-y < 20) move = true;
      select = true;
    }

    if (on || select) {
      for (int i = 0; i < components.size (); i++) {
        Component c = components.get(i);
        c.update(x, y);
      }
      render();
    }

    show();
    click = false;
  }

  void render() {
    render.beginDraw();
    render.clear();
    render.textFont(font);
    render.textAlign(LEFT, TOP);
    render.noStroke();
    render.fill(#73816B);
    render.rect(0, 0, w, h, 4);
    render.fill(#495045);
    render.rect(0, 0, w, 20, 4, 4, 0, 0);
    render.fill(250);
    render.text(name, 5, 2);
    render.strokeWeight(2);
    render.stroke(255);
    render.line(w-6, 6, w-14, 14);
    render.line(w-6, 14, w-14, 6);

    for (int i = 0; i < components.size (); i++) {
      Component c = components.get(i);
      c.show(render);
    }
    render.endDraw();
  }

  void show() {
    if (!on && !select) tint(255, 230);
    image(render, x, y);
    noTint();
  }

  void add(Component c) {
    components.add(c);
  }
}

class Settings extends Window {
  Slider sminSize, smaxSize, ssmoothing, staperTips, sjitter, sjitterVelocity;
  Settings(Gui gui, int x, int y) {
    super(gui, x, y, "Settings");
    add(sminSize = new Slider(10, 50, w-20, 10, 0, 10, minSize, "Min Size"));
    add(smaxSize = new Slider(10, 90, w-20, 10, 0, 10, maxSize, "Max Size"));
    add(ssmoothing = new Slider(10, 130, w-20, 10, 0, 100, smoothing, "Smoothing"));
    add(staperTips = new Slider(10, 170, w-20, 10, 0, 100, taperTips, "Taper Tips"));
    add(sjitter = new Slider(10, 210, w-20, 10, 0, 4, jitter, "Jitter"));
    add(sjitterVelocity = new Slider(10, 250, w-20, 10, 0, 2, jitterVelocity, "Jitter Velocity"));
    add(new Toggle(w-30, 280, 20, 20, true, "size to zoom"));
    render();
  }
  void update() {
    super.update();
    minSize = sminSize.val;
    maxSize = smaxSize.val;
    smoothing = ssmoothing.val;
    taperTips = staperTips.val;
    jitter = sjitter.val;
    jitterVelocity = sjitterVelocity.val;
  }
  void show() {
    super.show();
  }
}

class Component {
  boolean on;
  String name;
  int x, y, w, h;
  Component(int x, int y, int w, int h, String name) {
    this.x = x; 
    this. y = y; 
    this.w = w; 
    this.h = h;
    this.name = name;
  }
  void update(int px, int py) {
    int x = this.x+px;
    int y = this.y+py;
    on = false;
    if (mouseX >= x && mouseX < x+w && mouseY >= y && mouseY < y+h) {
      on = true;
    }
  }
  void show(int px, int px) {
  }
}

class Slider extends Component {
  boolean move;
  float min, max, val;
  Slider(int x, int y, int w, int h, float min, float max, float val, String name) {
    super(x, y, w, h, name);
    this.min = min;
    this.max = max;
    this.val = val;
    move = false;
  }
  void update(int px, int py) {
    super.update(px, py);    
    if (on && click) {
      move = true;
    }
    if (!mousePressed) {
      move = false;
    }

    if (move) {
      float pos = constrain(mouseX, x+px, x+w+px);
      val = constrain((min+(max - min))*(pos-h-x)/(w-h), min, max);
    }
  }
  void show(PGraphics gra) {
    int alp = (on)? 120 : 100;
    gra.noStroke();
    gra.fill(255, 200);
    gra.text(name+" "+String.format("%.2f", val), x, y-18);
    gra.fill(255, alp);
    gra.rect(x, y, w, h, 2);
    gra.fill(0, alp);
    float pos = map(val, min, max, 0, w-h);
    gra.rect(x+pos, y, h, h, 2);
  }
}

class Toggle extends Component {
  boolean val;
  Toggle(int x, int y, int w, int h, boolean val, String name) {
    super(x, y, w, h, name);
    this.val = val;
  }
  void update(int px, int py) {
    super.update(px, py);    
    if (on && click) {
      val = !val;
    }
  }
  void show(PGraphics gra) {
    gra.pushStyle();
    int alp = (on)? 120 : 100;
    gra.fill(255, alp);
    if (val) {
      gra.noStroke();
      gra.fill(0, alp);
      gra.rect(x, y, w, h, 2);
      gra.fill(255, alp);
      gra.ellipse(x+w*0.5, y+h*0.5, w*0.5, h*0.5);
    } else {
      gra.noStroke();
      gra.fill(0, alp);
      gra.rect(x, y, w, h, 2);
    }
    gra.textAlign(RIGHT, TOP);
    gra.fill(255, 200);
    gra.text(name, x+w-25, y+2);
    gra.popStyle();
  }
}

