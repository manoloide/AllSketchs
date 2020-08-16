class Gui { //<>//
  ArrayList<Element> elements; 
  boolean sobre, mover;
  int x, y, w, h;
  int border;
  String name;
  Gui(String name) {
    this.name = name;
    w = 150;
    h = 580;
    x = width-w-10; 
    y = 10;
    border = 5;

    elements = new ArrayList<Element>();
  }
  void update() {
    sobre = false;
    if (mouseX >= x && mouseX < x+w && mouseY >= y && mouseY < y+h) {
      sobre = true;
    }
    if (sobre && Click && mouseY < y+20) {
      mover = true;
    }
    if (!mousePressed) {
      mover = false;
    }
    if (mover) {
      x -= pmouseX-mouseX;
      y -= pmouseY-mouseY;
    }

    for (int i = 0; i < elements.size (); i++) {
      Element e = elements.get(i);
      e.update(x, y);
    }
    show();
  }

  void show() {
    noStroke();
    fill(60);
    rect(x, y+20, w, h-20, 2);
    fill(200);
    rect(x, y, w, 20, 2, 2, 0, 0);
    fill(0);
    textAlign(LEFT, TOP);
    text(name, x+4, y+2);

    for (int i = 0; i < elements.size (); i++) {
      Element e = elements.get(i);
      e.show(x, y);
    }
  }

  void addElement(Element e) {
    elements.add(e);
  }
}

class Element {
  void update(float nx, float ny) {
  }

  void show(float nx, float ny) {
  }  

  void rnd() {
  }
}

class Boton extends Element {
  boolean sobre, press, click;
  float x, y, w, h;
  String name;
  Boton(String name, float x, float y, float w, float h) {
    this.name = name;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  void update(float nx, float ny) {
    float x = this.x+nx;
    float y = this.y+ny;
    sobre = false;
    if (mouseX >= x && mouseX < x+w && mouseY >= y && mouseY < y+h) {
      sobre = true;
    }
    click = false;
    if (sobre && Click && !press) {
      press = true;
      click = true;
    }
    if (!mousePressed) press = false;
  }
  void show(float nx, float ny) {
    float x = this.x+nx;
    float y = this.y+ny;
    fill(160);
    if (sobre) fill(170);
    rect(x, y, w, h, 2);
    textAlign(CENTER, CENTER);
    fill(0);
    text(name, x+w/2, y+8);
  }
}

class Toggle extends Element {
  boolean val, sobre, press, click;
  float x, y, w, h;
  String name;
  Toggle(String name, float x, float y, float w, float h, boolean val) {
    this.name = name;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.val = val;
  }
  void update(float nx, float ny) {
    float x = this.x+nx;
    float y = this.y+ny;
    sobre = false;
    if (mouseX >= x && mouseX < x+w && mouseY >= y && mouseY < y+h) {
      sobre = true;
    }
    click = false;
    if (sobre && Click && !press) {
      press = true;
      click = true;
      val = !val;
    }
    if (!mousePressed) press = false;
  }
  void show(float nx, float ny) {
    float x = this.x+nx;
    float y = this.y+ny;
    fill(120);
    if (sobre) fill(130);
    if (val) fill(180);
    rect(x, y, w, h, 2);
    textAlign(LEFT, CENTER);
    fill(250);
    text(name, x+w+4, y+8);
  }

  void rnd() {
    val = (random(10) < 5)? true : false;
  }
}


class Slider extends Element {
  boolean sobre, press, click, mover;
  float x, y, w, h, max, min, val;
  String name;
  Slider(String n, float nx, float ny, float nw, float nh, float nmin, float nmax, float nvar) {
    x = nx;
    y = ny;
    w = nw;
    h = nh;
    max = nmax;
    min = nmin;
    val = nvar;
    name = n;
  }

  void update(float nx, float ny) {
    float x = this.x+nx;
    float y = this.y+ny;

    sobre = false;
    if ( mouseX >= x+h/2 && mouseX < x+w-h/2 && mouseY >= y  && mouseY < y+h ) {
      sobre = true;
    }
    if (Click && sobre) {
      mover = true;
    }
    if (!mousePressed) {
      mover = false;
    }
    if (mover) {
      val = min + (max-min) * ((mouseX- h/2 - x )/(w - h));
      if (val < min) {
        val = min;
      } else if (val > max) {
        val = max;
      }
    }
  }

  void show(float nx, float ny) {
    float x = this.x+nx;
    float y = this.y+ny;

    fill(120);
    rect(x, y, w, h, 2);

    fill(150);
    float pos = x + ((w-h) * (val-min)/(max-min));
    rect(pos, y, h, h, 2);
    fill(255);
    textAlign(LEFT, CENTER);
    text(name+" "+int(val), x+2, y+8);
  }

  void rnd() {
    val = random(min, max);
  }
}
