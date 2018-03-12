class UI {

  float atraccionTouch = 0.4;
  float distanciaDragueo = 400;
  float tiempoCell = 20;
  float tiempoTrend = 4;
  float tiempoTexto = 15;

  ArrayList<Component> components;
  boolean view;
  int x, y, w, h;
  JSONObject json;
  Slider s1, s2, s3, s4, s5;
  String name;
  UI(String name, int x, int y, int w, int h) {
    this.name = name;
    this.x = x; 
    this.y = y; 
    this.w = w; 
    this.h = h;
    view = false;
    createUI();
    load();
  }

  void createUI() {
    components = new ArrayList<Component>();
    add(s1 = new Slider(10, 30, w-20, 20, 0, 0.4, atraccionTouch, "Atraccion Touch"));
    add(s2 = new Slider(10, 60, w-20, 20, 100, 1000, distanciaDragueo, "Distancia Dragueo"));
    add(s3 = new Slider(10, 90, w-20, 20, 1, 80, tiempoCell, "Tiempo Cell"));
    add(s4 = new Slider(10, 120, w-20, 20, 1, 60, tiempoTrend, "Tiempo Trend"));
    add(s5 = new Slider(10, 150, w-20, 20, 1, 60, tiempoTexto, "Tiempo Texto"));
  }

  void updateValues() {
    atraccionTouch = s1.val;
    distanciaDragueo = s2.val;
    tiempoCell = s3.val;
    tiempoTrend = s4.val;
    tiempoTexto = s5.val;
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
    pushStyle();
    textAlign(LEFT, TOP);
    textFont(fontMedium);
    fill(0);
    rect(x, y, w, 20, 2, 2, 0, 0);
    fill(255);
    text(name, x+4, y+4);
    fill(80);
    rect(x, y+20, w, h-20, 2);
    for (int i = 0; i < components.size (); i++) {
      Component c = components.get(i);
      c.show(x, y);
    }
    String txt = " l  - cargar configuracion\n";
    txt += " s - guardar configuracion\n";
    txt += " r - resetear la app";
    text(txt, x+10, y+200, w-20, 400);
    popStyle();
  }

  void add(Component c) {
    components.add(c);
  }

  void load() {
    File f = new File(sketchPath("data/config.json"));
    if (f.exists()) {
      json = loadJSONObject("data/config.json");
      s1.setValue(json.getFloat(s1.name));
      s2.setValue(json.getFloat(s2.name, distanciaDragueo));
      s3.setValue(json.getFloat(s3.name, tiempoCell));
      s4.setValue(json.getFloat(s4.name, tiempoTrend));
      s5.setValue(json.getFloat(s5.name, tiempoTexto));
    } else {
      json = new JSONObject();
    }
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
  void setValue(float val) {
    this.val =  val;
  }
}

class Slider extends Component {
  boolean move;
  float min, max;
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
    int alp = (on)? 220 : 200;
    noStroke();
    fill(40, alp);
    rect(x, y, w, h);
    fill((move)? 160 : 160, alp);
    float pos = map(val, min, max, 0, w);
    rect(x, y, pos, h);
    textAlign(LEFT, TOP);
    fill(255);
    text(name+" "+String.format("%.2f", val), x+4, y+4);
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
    int alp = (on)? 220 : 200;
    fill(0, alp);
    if (val) {
      noStroke();
      fill(120, alp);
      rect(x, y, w, h, 2);
    } else {
      noStroke();
      fill(120, alp);
      rect(x, y, w, h, 2);
    }
    textAlign(RIGHT, TOP);
    text(name, x+w-10, y+2);
    popStyle();
  }
}

