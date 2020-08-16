class UI {
  ArrayList<Component> components;
  boolean view;
  int x, y, w, h;
  JSONObject json;
  String name;
  UI(String name, int x, int y, int w, int h) {
    this.name = name;
    this.x = x; 
    this.y = y; 
    this.w = w; 
    this.h = h;
    load();
  }

  void createUI() {
    add(new Slider(10, 30, w-20, 20, 0, 100, 30, "Val1"));
  }

  void updateValues() {
  }

  void update() {
    if (!view) return;
    for (int i = 0; i < components.size (); i++) {
      Component c = components.get(i);
      c.update(x, y);
    }
    updateValues();
    show();
  }

  void show() {
    textFont(fontMedium);
    fill(0, 160);
    rect(x, y, w, h, 2);
    for (int i = 0; i < components.size (); i++) {
      Component c = components.get(i);
      c.show(x, y);
    }
  }

  void add(Component c) {
    components.add(c);
  }

  void load() {
    components = new ArrayList<Component>();
    File f = new File(sketchPath("data/config.json"));
    if (f.exists()) {
      json = loadJSONObject("data/config.json");
    } else {
      json = new JSONObject();
    }
    createUI();
  }

  void save() {
    for (int i = 0; i < components.size (); i++) {
      Component c = components.get(i);
      json.setFloat(c.name, c.val);
    }
    saveJSONObject(json, "data/config.json");
  }

  void hidden() {
    view = !view;
  }
}

class Component {
  boolean on;
  int x, y, w, h;
  float val;
  String name;
  Component(int x, int y, int w, int h, String name) {
    this.x = x; 
    this.y = y; 
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
  void show(int x, int y) {
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
    if (on && touchManager.click) {
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
  void show(int px, int py) {
    int x = this.x+px;
    int y = this.y+py;
    int alp = (on)? 120 : 100;
    noStroke();
    fill(255, 200);
    text(name+" "+String.format("%.2f", val), x, y-4);
    fill(255, alp);
    rect(x, y, w, h, 2);
    fill((move)? #00ff00 : 0, alp);
    float pos = map(val, min, max, 0, w-h);
    rect(x+pos, y, h, h, 2);
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
    if (on && touchManager.click) {
      val = !val;
    }
  }
  void show(int px, int py) {
    int x = this.x+px;
    int y = this.y+py;
    pushStyle();
    int alp = (on)? 120 : 100;
    fill(255, alp);
    if (val) {
      noStroke();
      fill(0, alp);
      rect(x, y, w, h, 2);
      fill(255, alp);
      ellipse(x+w*0.5, y+h*0.5, w*0.5, h*0.5);
    } else {
      noStroke();
      fill(0, alp);
      rect(x, y, w, h, 2);
    }
    textAlign(RIGHT, TOP);
    fill(255, 200);
    text(name, x+w-10, y+2);
    popStyle();
  }
}

