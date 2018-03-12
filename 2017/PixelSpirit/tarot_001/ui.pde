Button savePNG, savePDF;
Label back1, back2, back3, back4, back5;
Label frame1, frame2, frame3, frame4, frame5;
Label forms1, forms2, forms3, forms4, forms5;
MultiLabel types, back, frame, forms;

//back1;
Slider circularAmount, circularDesxAmount, circularDesyAmount, circularAmplitud;
Slider circularSub, circularSubAmplitud, circularHaloAmplitud, circularHaloAlpha;
Toggle circularHalo;
Button circularRnd;

//back2
Slider hexSize, hexAmplitud, hexAmplitud2;
Toggle hexTriangles, hexSecond;
Button hexRnd;

//back3
Slider tramaAmount, tramaSeparation, tramaAngle, tramaMinStroke, tramaMaxStroke;
Slider tramaBorderWidth, tramaBorderHeight, tramaBorder, tramaPISub;
Button tramaRnd;

// forms1
Slider circularFormAmount, circularFormRadius, circularFormSize, circularFormSub, circularFormSeed;
Button circularFormRnd;

void createUI() {
  ui = new UI();

  types = new MultiLabel("TYPES", 0, 0, 300, 100, 0);
  ui.add(types);

  back = new MultiLabel("BACK", 0, 30, 300, 100, 0);
  types.add(back);
  frame = new MultiLabel("FRAME", 0, 30, 300, 100, 0);
  types.add(frame);
  forms = new MultiLabel("FORMS", 0, 30, 300, 100, 0);
  types.add(forms);

  Label theNull =  new Label("Ø", 0, 60, 300, 70); 

  back.add(theNull);
  back1 = new Label("I", 0, 60, 300, 70);
  back.add(back1);
  back2 = new Label("II", 0, 60, 300, 70);
  back.add(back2);
  back3 = new Label("III", 0, 60, 300, 70);
  back.add(back3);
  back4 = new Label("IV", 0, 60, 300, 70);
  back.add(back4);
  back5 = new Label("V", 0, 60, 300, 70);
  back.add(back5);


  frame.add(theNull);
  frame1 = new Label("I", 0, 60, 300, 70);
  frame.add(frame1);
  frame2 = new Label("II", 0, 60, 300, 70);
  frame.add(frame2);
  frame3 = new Label("III", 0, 60, 300, 70);
  frame.add(frame3);
  frame4 = new Label("IV", 0, 60, 300, 70);
  frame.add(frame4);
  frame5 = new Label("V", 0, 60, 300, 70);
  frame.add(frame5);

  forms.add(theNull);
  forms1 = new Label("I", 0, 60, 300, 70);
  forms.add(forms1);
  forms2 = new Label("II", 0, 60, 300, 70);
  forms.add(forms2);
  forms3 = new Label("III", 0, 60, 300, 70);
  forms.add(forms3);
  forms4 = new Label("IV", 0, 60, 300, 70);
  forms.add(forms4);
  forms5 = new Label("V", 0, 60, 300, 70);
  forms.add(forms5);


  {
    circularAmount = new Slider("Amount", 30, 40, 240, 10, 2, 80, 40);
    circularAmount.integer = true;
    back1.add(circularAmount);
    circularDesxAmount = new Slider("Des x", 30, 80, 240, 10, -0.6, 0.6, 0);
    back1.add(circularDesxAmount);
    circularDesyAmount = new Slider("Des y", 30, 120, 240, 10, -0.6, 0.6, 0);
    back1.add(circularDesyAmount);
    circularAmplitud = new Slider("Amplitud", 30, 160, 240, 10, 0, 1, 0.5);
    back1.add(circularAmplitud);

    circularSub = new Slider("Subdivisions", 30, 200, 240, 10, 1, 8, 1);
    circularSub.integer = true;
    back1.add(circularSub);
    circularSubAmplitud = new Slider("Sub Amplitud", 30, 240, 240, 10, 0.1, 1, 0.5);
    back1.add(circularSubAmplitud);

    circularHalo = new Toggle("HALO", 30, 290, 40, 20, false);
    back1.add(circularHalo);
    circularHaloAmplitud = new Slider("Halo Amplitud", 30, 340, 240, 10, 1, 1.6, 1.1);
    back1.add(circularHaloAmplitud);
    circularHaloAlpha = new Slider("Halo Alpha", 30, 380, 240, 10, 0, 255, 200);
    back1.add(circularHaloAlpha);

    circularRnd = new Button("RANDOM", 30, 420, 110, 30);
    back1.add(circularRnd);
  }

  {
    hexSize = new Slider("Size", 30, 40, 240, 10, 30, 400, 140);
    back2.add(hexSize);

    hexTriangles = new Toggle("TRIANGLES", 30, 90, 40, 20, false);
    back2.add(hexTriangles);
    hexSecond = new Toggle("SECOND", 150, 90, 40, 20, false);
    back2.add(hexSecond);

    hexAmplitud = new Slider("Amplitud 1", 30, 140, 240, 10, 0, 1, 0.5);
    back2.add(hexAmplitud);
    hexAmplitud2 = new Slider("Amplitud 2", 30, 180, 240, 10, 0, 1, 0.5);
    back2.add(hexAmplitud2);

    hexRnd = new Button("RANDOM", 30, 220, 110, 30);
    back2.add(hexRnd);
  }

  { 
    tramaAmount = new Slider("Amount", 30, 40, 240, 10, 1, 8, 2);
    tramaAmount.integer = true;
    back3.add(tramaAmount);
    tramaSeparation = new Slider("Separation", 30, 80, 240, 10, 1, 80, 5);
    back3.add(tramaSeparation);
    tramaAngle = new Slider("Angle", 30, 120, 240, 10, 0, TWO_PI, 0);
    back3.add(tramaAngle);
    tramaMinStroke = new Slider("Min Stroke", 30, 160, 240, 10, 0, 1, 0.5);
    back3.add(tramaMinStroke);
    tramaMaxStroke = new Slider("Max Stroke", 30, 200, 240, 10, 0, 1, 0.5);
    back3.add(tramaMaxStroke);

    tramaBorderWidth = new Slider("Border Width", 30, 240, 240, 10, -0.1, 0.5, 0.1);
    back3.add(tramaBorderWidth);
    tramaBorderHeight = new Slider("Border Height", 30, 280, 240, 10, -0.1, 0.5, 0.1);
    back3.add(tramaBorderHeight);
    tramaBorder = new Slider("Border", 30, 320, 240, 10, 0, 1, 0.5);
    back3.add(tramaBorder);

    tramaPISub = new Slider("PI Sub", 30, 360, 240, 10, 1, 7, 1);
    tramaPISub.integer = true;
    back3.add(tramaPISub);

    tramaRnd = new Button("RANDOM", 30, 400, 110, 30);
    back3.add(tramaRnd);
  }
  
  {
    circularFormAmount = new Slider("Amount", 30, 40, 240, 10, 1, 40, 12);
    circularFormAmount.integer = true;
    forms1.add(circularFormAmount);
    circularFormRadius = new Slider("Radius", 30, 80, 240, 10, 0, 0.5, 0.4);
    forms1.add(circularFormRadius);
    circularFormSize = new Slider("Size", 30, 120, 240, 10, 0, 1, 0.2);
    forms1.add(circularFormSize);
    circularFormSub = new Slider("Subdivisions", 30, 160, 240, 10, 3, 30, 6);
    circularFormSub.integer = true;
    forms1.add(circularFormSub);
    circularFormSeed = new Slider("Seed", 30, 200, 240, 10, 0, 9999999, 999);
    circularFormSeed.integer = true;
    forms1.add(circularFormSeed);
    
    circularFormRnd = new Button("RANDOM", 30, 240, 110, 30);
    forms1.add(circularFormRnd);
  }

  ui.add(savePDF = new Button("SAVE PDF", 30, 640, 110, 30));
  ui.add(savePNG = new Button("SAVE PNG", 160, 640, 110, 30));
}

void updateUIValues() {
  ui.h = height;

  if (circularRnd.getValue()) {
    rndCircularBack(render);
  }
  if (hexRnd.getValue()) {
    rndHexBack(render);
  }
  if (tramaRnd.getValue()) {
    rndTramaBack(render);
  }
  
  if(circularFormRnd.getValue()){
     rndCircularForm(render); 
  }

  if (savePNG.getValue()) {
    saveImage();
  }
  if (savePDF.getValue()) {
    savePDF();
  }
}


class UI extends Label {
  Input input;
  int colors[] = {#e6e6e6, #d2d2d2, #7c7c7c, #f0f0f0, #505050};
  PFont font;

  UI() {
    super("UI", 0, 0, 300, height);
    ui = this;
    input = new Input();
    viewTitle = false;
    font = createFont("Chivo-Regular.otf", 18, false);
  }

  void update() {
    super.update();
    input.update();
  }

  void show() {
    super.show();
  }
}

class Input {
  boolean click, pressed;
  int cmouseX, cmouseY;
  Input() {
    click = pressed = false;
  }

  void update() {
    click = false;
  }

  void pressed() {
    click = pressed = true;
    cmouseX = mouseX;
    cmouseY = mouseY;
  }

  void released() {
    pressed = false;
  }
}

class UIComponent {
  boolean on, change;
  float x, y, w, h;
  Label parent;
  String name;
  PVector rp;
  UI ui;

  UIComponent(String name, float x, float y, float w, float h) {
    this.name = name;
    this.x = x;
    this.y = y;
    this.w = w; 
    this.h = h;
    parent = null;
  }

  void updatePos() {
    rp = getRealPos();
    on = (mouseX >= rp.x && mouseX < rp.x+w && mouseY >= rp.y && mouseY < rp.y+h);
  }

  void update() {
    change = false;
    updatePos();
  };

  void show() {
  };

  PVector getRealPos(PVector pos) {
    pos.add(new PVector(x, y));
    if (parent == null) return pos;
    return parent.getRealPos(pos);
  }

  PVector getRealPos() {
    return getRealPos(new PVector());
  }

  void setParent(Label parent) {
    this.parent = parent;
  }
  void setUI(UI ui) {
    this.ui = ui;
  }

  void change() {
    change = true;
    if (parent != null) parent.change();
  }
}

class Label extends UIComponent {
  ArrayList<UIComponent> components; 
  boolean viewTitle = true;

  Label(String name, float x, float y, float w, float h) {
    super(name, x, y, w, h);
    components = new ArrayList<UIComponent>();
  }

  void update() {
    super.update();
    for (int i = 0; i < components.size(); i++) {
      components.get(i).update();
    }
  }

  void show() {

    pushMatrix();
    translate(x, y);
    noStroke();
    fill(ui.colors[0]);
    rect(0, 0, w, h);
    if (viewTitle) {
      fill(ui.colors[4]);
      rect(0, 0, w, 30);
      fill(ui.colors[3]);
      textFont(ui.font);
      textAlign(LEFT, TOP);
      text(name, 30, 10);
    }

    for (int i = 0; i < components.size(); i++) {
      components.get(i).show();
    }

    popMatrix();
  }

  void add(UIComponent component) {
    component.setUI(ui);
    component.setParent(this);
    components.add(component);
  }


  UIComponent getComponent(String name) {
    for (int i = 0; i < components.size(); i++) {
      UIComponent component = components.get(i);
      if (component.name.equals(name)) {
        return component;
      }
    }
    return null;
  }
}


class MultiLabel extends Label {
  int select;
  MultiLabel(String name, float x, float y, float w, float h, int select) {
    super(name, x, y, w, h);
    this.select = select;
  }

  void update() {
    updatePos();
    if (on && ui.input.click) {
      if (mouseY >= rp.y+30 && mouseY < rp.y+60) {
        select = int((mouseX-rp.x)/(w/components.size()));
        change();
      }
    }

    if (components.size() > 0) components.get(select).update();
  }

  void show() {

    pushMatrix();
    translate(x, y);
    noStroke();
    fill(ui.colors[0]);
    rect(0, 30, w, h-30);
    if (viewTitle) {
      fill(ui.colors[4]);
      rect(0, 0, w, 30);
      fill(ui.colors[3]);
      textFont(ui.font);
      textAlign(LEFT, TOP);
      text(name, 30, 10);
    }
    fill(ui.colors[1]);
    rect(0, 30, w, 30);
    float ww = w/components.size();
    for (int i = 0; i < components.size(); i++) {
      fill(ui.colors[2]);
      if (i == select) {
        fill(ui.colors[0]);
        rect(ww*i, 30, ww, 30, 2, 2, 0, 0);
        fill(ui.colors[4]);
      }
      textFont(ui.font);
      textAlign(CENTER, CENTER);
      text(components.get(i).name, ww*(i+0.5), 45);
    }

    if (components.size() > 0) components.get(select).show();

    popMatrix();
  }

  void add(UIComponent component) {
    println("only label");
  }

  void add(Label label) {
    label.setUI(ui);
    label.setParent(this);
    label.viewTitle = false;
    components.add(label);
  }

  UIComponent getLabel(String name) {
    for (int i = 0; i < components.size(); i++) {
      UIComponent component = components.get(i);
      if (component.name.equals(name)) {
        return component;
      }
    }
    return null;
  }
}


class Button extends UIComponent {
  boolean value;
  Button(String name, float x, float y, float w, float h) {
    super(name, x, y, w, h);
    value = false;
  }

  void update() {
    super.update();
    if (on && ui.input.click) {
      value = true;
      change();
    } else {
      value = false;
    }
  }

  void show() {
    strokeWeight(1);
    stroke(ui.colors[1]);
    fill(ui.colors[0]);
    if (on) fill(ui.colors[1]);
    rect(x, y, w, h, 2);
    fill(ui.colors[2]);
    textAlign(CENTER, CENTER);
    text(name, x+w/2, y+h/2);
  }

  boolean getValue() {
    return value;
  }

  void setValue(boolean nv) {
    value = nv;
    change();
  }
}

class Toggle extends UIComponent {
  boolean value;
  float nv, av;
  Toggle(String name, float x, float y, float w, float h, boolean value) {
    super(name, x, y, w, h);
    this.value = value;

    nv = av = 0;
    if (value) nv = av = 1;
  }

  void update() {
    super.update();
    if (on && ui.input.click) {
      setValue(!value);
      change();
    }

    av += (nv-av)*0.3;
  }

  void show() {
    noStroke();
    fill(lerpColor(ui.colors[1], ui.colors[2], av));
    textAlign(LEFT, TOP);
    text(name, x, y-20);
    rect(x, y, w, h, w/2);
    fill(ui.colors[0]);
    float d = h/2+(w-h)*av;
    ellipse(x+d, y+h/2, h-4, h-4);
  }

  boolean getValue() {
    return value;
  }

  void setValue(boolean newValue) {
    value = newValue;
    nv = 0;
    if (value) nv = 1;
    change();
  }
}



class Slider extends UIComponent {
  boolean moved;
  boolean integer;
  float min, max, value;
  Slider(String name, float x, float y, float w, float h, float min, float max, float value) {
    super(name, x, y, w, h);
    this.min = min;
    this.max = max;
    this.value = value;
    integer = false;
  }

  void update() {
    super.update();
    if (on && ui.input.click) {
      moved = true;
    }
    if (!ui.input.pressed) {
      moved = false;
    }

    if (moved) {
      float pos = constrain(mouseX, rp.x, rp.x+w);
      value = constrain(map(pos, rp.x, rp.x+w, min, max), min, max);
      if (integer) value = round(value);
      change();
    }
  }

  void show() {
    float ww = map(value, min, max, 0, w);


    noStroke();
    fill(ui.colors[2]);
    textAlign(LEFT, TOP);
    String sv = str(int(value));
    if (!integer) sv = String.format("%.2f", value).replace(",", ".");

    text(name+": "+sv, x, y-20);
    fill(ui.colors[1]);
    rect(x, y, ww, h, 2, 0, 0, 2);
    fill(ui.colors[2]);
    rect(x+ww, y, w-ww, h, 0, 2, 2, 0);
  }

  float getValue() {
    return value;
  }

  void setValue(float nv) {
    value = constrain(nv, min, max);
    change();
  }
}