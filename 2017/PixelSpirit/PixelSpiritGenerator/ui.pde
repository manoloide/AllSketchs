Button loadJSON, saveJSON, savePNG, savePDF, randomAll;
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
Slider hexSize, hexAmplitud, hexAmplitud2, hexStroke1, hexStroke2, hexStrokeTriangle;
Toggle hexTriangles, hexSecond;
Button hexRnd;

//back3
Slider tramaAmount, tramaSeparation, tramaAngle, tramaMinStroke, tramaMaxStroke;
Slider tramaBorderWidth, tramaBorderHeight, tramaBorder, tramaPISub;
Button tramaRnd;

//back4
Slider rhombusBackSizeWidth, rhombusBackSizeHeight, rhombusBackSubdivision1, rhombusBackSubdivision2;
Button rhombusBackRnd;

//back5
Slider randomBackMinSize, randomBackMaxSize, randomBackAmplitud1, randomBackAmplitud2;
Slider randomBackStroke, randomBackSeed;
Selector randomBackForm;
Button randomBackRnd;

//frame1
Slider simpleFrameAmount, simpleFrameSeparation, simpleFrameInternalBorder, simpleFrameStroke, simpleFrameCornes;
Selector simpleFrameType;
Button simpleFrameRnd;

//frame2
Slider doubleFrameInside, doubleFrameInternalBorder, doubleFrameStroke1, doubleFrameCornes1, doubleFrameStroke2, doubleFrameCornes2;
Selector doubleFrameType1, doubleFrameType2;
Button doubleFrameRnd;

//frame3
Slider guardaFrameInside, guardaFrameBorder, guardaFrameRound1, guardaFrameRound2;
Slider guardaFrameSize1, guardaFrameSize2, guardaFrameSeed;
Selector guardaFrameForm;
Toggle guardaFrameFill;
Button guardaFrameRnd;

//frame4
Slider rectFrameInternalBorder, rectFrameSize1, rectFrameSize2, rectFrameSub, rectFrameStroke1, rectFrameStroke2;
Button rectFrameRnd;

//frame5
Slider quadFrameSize, quadFrameStroke, quadFrameInternalBorder, quadFrameInside;
Toggle quadFrameRect, quadFrameDouble;
Button quadFrameRnd;

// forms1
Slider circularFormAmount, circularFormRadius, circularFormSize, circularFormStr, circularFormSub, circularFormSeed;
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

    hexStroke1 = new Slider("Stroke 1", 30, 220, 240, 10, 0, 1, 0.4);
    back2.add(hexStroke1);
    hexStroke2 = new Slider("Stroke 2", 30, 260, 240, 10, 0, 1, 0.6);
    back2.add(hexStroke2);
    hexStrokeTriangle = new Slider("Stroke Triangles", 30, 300, 240, 10, 0, 1, 0.1);
    back2.add(hexStrokeTriangle);

    hexRnd = new Button("RANDOM", 30, 340, 110, 30);
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
    rhombusBackSizeWidth = new Slider("Size Width", 30, 40, 240, 10, 20, 800, 200);
    back4.add(rhombusBackSizeWidth);
    rhombusBackSizeHeight = new Slider("Size Height", 30, 80, 240, 10, 20, 800, 200);
    back4.add(rhombusBackSizeHeight);
    rhombusBackSubdivision1 = new Slider("Subdivisions 1", 30, 120, 240, 10, 1, 28, 2);
    rhombusBackSubdivision1.integer = true;
    back4.add(rhombusBackSubdivision1);
    rhombusBackSubdivision2 = new Slider("Subdivisions 2", 30, 160, 240, 10, 1, 28, 8);
    rhombusBackSubdivision1.integer = true;
    back4.add(rhombusBackSubdivision2);
    rhombusBackRnd = new Button("RANDOM", 30, 200, 110, 30);
    back4.add(rhombusBackRnd);
  }

  {
    randomBackMinSize = new Slider("Min Size", 30, 40, 240, 10, 0, 1, 0.1);
    back5.add(randomBackMinSize);
    randomBackMaxSize = new Slider("Max Size", 30, 80, 240, 10, 0, 600, 200);
    back5.add(randomBackMaxSize);
    randomBackAmplitud1 = new Slider("Amplitud 1", 30, 120, 240, 10, 0, 1, 0.8);
    back5.add(randomBackAmplitud1);
    randomBackAmplitud2 = new Slider("Amplitud 2", 30, 160, 240, 10, 0, 1, 0.2);
    back5.add(randomBackAmplitud2);
    randomBackStroke = new Slider("Stroke", 30, 200, 240, 10, 0, 16, 4);
    back5.add(randomBackStroke);
    randomBackSeed = new Slider("Seed", 30, 240, 240, 10, 0, 9999999, 999);
    randomBackSeed.integer = true;
    back5.add(randomBackSeed);
    randomBackForm = new Selector("Form", 30, 280, 240, 15, 3, 0);
    back5.add(randomBackForm);
    randomBackRnd = new Button("RANDOM", 30, 320, 110, 30);
    back5.add(randomBackRnd);
  }

  {
    simpleFrameAmount = new Slider("Amount", 30, 40, 240, 10, 1, 10, 1);
    simpleFrameAmount.integer = true;
    frame1.add(simpleFrameAmount);
    simpleFrameSeparation = new Slider("Separation", 30, 80, 240, 10, 0, 200, 4);
    frame1.add(simpleFrameSeparation);
    simpleFrameInternalBorder = new Slider("Internal Border", 30, 120, 240, 10, 0, 40, 10);
    frame1.add(simpleFrameInternalBorder);
    simpleFrameStroke = new Slider("Stroke", 30, 160, 240, 10, 0, 40, 4);
    frame1.add(simpleFrameStroke);
    simpleFrameCornes = new Slider("Corners", 30, 200, 240, 10, 0, 300, 60);
    frame1.add(simpleFrameCornes);
    simpleFrameType = new Selector("Type", 30, 240, 240, 15, 5, 0);
    frame1.add(simpleFrameType);

    simpleFrameRnd = new Button("RANDOM", 30, 280, 110, 30);
    frame1.add(simpleFrameRnd);
  }

  {
    doubleFrameInside = new Slider("Inside", 30, 40, 240, 10, 1, 120, 10);
    frame2.add(doubleFrameInside);
    doubleFrameInternalBorder = new Slider("Internal Border", 30, 80, 240, 10, 0, 40, 10);
    frame2.add(doubleFrameInternalBorder);
    doubleFrameStroke1 = new Slider("Stroke 1", 30, 120, 240, 10, 0, 40, 4);
    frame2.add(doubleFrameStroke1);
    doubleFrameCornes1 = new Slider("Corners 1", 30, 160, 240, 10, 0, 40, 4);
    frame2.add(doubleFrameCornes1);
    doubleFrameType1 = new Selector("Type 1", 30, 200, 240, 0, 300, 60);
    frame2.add(doubleFrameType1);
    doubleFrameStroke2 = new Slider("Stroke 2", 30, 240, 240, 10, 0, 40, 4);
    frame2.add(doubleFrameStroke2);
    doubleFrameCornes2 = new Slider("Corners 2", 30, 280, 240, 10, 0, 300, 60);
    frame2.add(doubleFrameCornes2);
    doubleFrameType2 = new Selector("Type 2", 30, 320, 240, 15, 5, 0);
    frame2.add(doubleFrameType2);

    doubleFrameRnd = new Button("RANDOM", 30, 360, 110, 30);
    frame2.add(doubleFrameRnd);
  }

  {
    guardaFrameInside = new Slider("Inside", 30, 40, 240, 10, 1, 240, 40);
    frame3.add(guardaFrameInside);
    guardaFrameBorder = new Slider("Border", 30, 80, 240, 10, 0, 1, 0.5);
    frame3.add(guardaFrameBorder);
    guardaFrameRound1 = new Slider("Round 1", 30, 120, 240, 10, 0, 0.5, 0.1);
    frame3.add(guardaFrameRound1);
    guardaFrameRound2 = new Slider("Round 2", 30, 160, 240, 10, 0, 0.5, 0.2);
    frame3.add(guardaFrameRound2);
    guardaFrameSize1 = new Slider("Size 1", 30, 200, 240, 10, 0, 1, 0.5);
    frame3.add(guardaFrameSize1);
    guardaFrameSize2 = new Slider("Size 2", 30, 240, 240, 10, 0, 1, 0.5);
    frame3.add(guardaFrameSize2);
    guardaFrameForm = new Selector("Type", 30, 280, 240, 15, 3, 0);
    frame3.add(guardaFrameForm);
    guardaFrameSeed = new Slider("Seed", 30, 320, 240, 10, 0, 9999999, 999);
    guardaFrameSeed.integer = true;
    frame3.add(guardaFrameSeed);
    guardaFrameFill = new Toggle("Fill", 30, 360, 40, 20, false);
    frame3.add(guardaFrameFill);
    guardaFrameRnd = new Button("RANDOM", 30, 410, 110, 30);
    frame3.add(guardaFrameRnd);
  }

  {
    rectFrameInternalBorder = new Slider("Internal Border", 30, 40, 240, 10, 0, 40, 10);
    frame4.add(rectFrameInternalBorder); 
    rectFrameSize1 = new Slider("Size 1", 30, 80, 240, 10, 10, 160, 20);
    frame4.add(rectFrameSize1); 
    rectFrameSize2 = new Slider("Size 2", 30, 120, 240, 10, 10, 160, 40);
    frame4.add(rectFrameSize2); 
    rectFrameSub = new Slider("Subdivisions", 30, 160, 240, 10, 1, 9, 4);
    rectFrameSub.integer = true;
    frame4.add(rectFrameSub); 
    rectFrameStroke1 = new Slider("Stroke 1", 30, 200, 240, 10, 0, 0.5, 0.2);
    frame4.add(rectFrameStroke1);
    rectFrameStroke2 = new Slider("Stroke 2", 30, 240, 240, 10, 0, 0.5, 0.05);
    frame4.add(rectFrameStroke2);
    rectFrameRnd = new Button("RANDOM", 30, 280, 110, 30);
    frame4.add(rectFrameRnd);
  }

  {

    quadFrameSize = new Slider("Size", 30, 40, 240, 10, 0, 120, 40);
    frame5.add(quadFrameSize);
    quadFrameStroke = new Slider("Stroke", 30, 80, 240, 10, 0, 40, 4);
    frame5.add(quadFrameStroke);
    quadFrameInternalBorder = new Slider("Internal Border", 30, 120, 240, 10, 0, 40, 10);
    frame5.add(quadFrameInternalBorder);
    quadFrameRect = new Toggle("Rectangle", 30, 160, 40, 20, false);
    frame5.add(quadFrameRect);
    quadFrameInside = new Slider("Inside", 30, 210, 240, 10, 0, 2, 0.5);
    frame5.add(quadFrameInside);
    quadFrameDouble  = new Toggle("Double", 30, 250, 40, 20, false);
    frame5.add(quadFrameDouble);

    quadFrameRnd = new Button("RANDOM", 30, 300, 110, 30);
    frame5.add(quadFrameRnd);
  }

  {
    circularFormAmount = new Slider("Amount", 30, 40, 240, 10, 1, 40, 12);
    circularFormAmount.integer = true;
    forms1.add(circularFormAmount);
    circularFormRadius = new Slider("Radius", 30, 80, 240, 10, 0, 0.5, 0.4);
    forms1.add(circularFormRadius);
    circularFormSize = new Slider("Size", 30, 120, 240, 10, 0, 1, 0.2);
    forms1.add(circularFormSize);
    circularFormStr = new Slider("Stroke", 30, 160, 240, 10, 0, 1, 0.2);
    forms1.add(circularFormStr);
    circularFormSub = new Slider("Subdivisions", 30, 200, 240, 10, 3, 30, 6);
    circularFormSub.integer = true;
    forms1.add(circularFormSub);
    circularFormSeed = new Slider("Seed", 30, 240, 240, 10, 0, 9999999, 999);
    circularFormSeed.integer = true;
    forms1.add(circularFormSeed);

    circularFormRnd = new Button("RANDOM", 30, 280, 110, 30);
    forms1.add(circularFormRnd);
  }

  ui.add(randomAll = new Button("KAOS", 30, 580, 240, 30));
  ui.add(savePDF = new Button("SAVE PDF", 30, 620, 115, 30));
  ui.add(savePNG = new Button("SAVE PNG", 155, 620, 115, 30));
  ui.add(loadJSON = new Button("LOAD JSON", 30, 660, 115, 30));
  ui.add(saveJSON = new Button("SAVE JSON", 155, 660, 115, 30));
}

void updateUIValues() {
  ui.h = height;

  if (circularRnd.getValue()) {
    rndCircularBack();
  }
  if (hexRnd.getValue()) {
    rndHexBack();
  }
  if (tramaRnd.getValue()) {
    rndTramaBack();
  }
  if (rhombusBackRnd.getValue()) {
    rndRhombusBack();
  }
  if (randomBackRnd.getValue()) {
    rndRandomBack();
  }

  if (simpleFrameRnd.getValue()) {
    rndSimpleFrame();
  }
  if (doubleFrameRnd.getValue()) {
    rndDoubleFrame();
  }
  if (guardaFrameRnd.getValue()) {
    rndGuardaFrame();
  }
  if (quadFrameRnd.getValue()) {
    rndQuadFrame();
  }
  if (rectFrameRnd.getValue()) {
    rndRectFrame();
  }

  if (circularFormRnd.getValue()) {
    rndCircularForm();
  }

  if (randomAll.getValue()) {
    randomAll();
  }
  if (savePNG.getValue()) {
    saveImage();
  }
  if (savePDF.getValue()) {
    savePDF();
  }

  if (loadJSON.getValue()) {
    selectInput("Load json...", "loadJSON");
  }

  if (saveJSON.getValue()) {
    saveJSON();
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

  JSONObject getJson() {
    return null;
  }

  void setJSON(JSONObject json) {
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

class Selector extends UIComponent {
  boolean moved;
  float ss;
  int cc, value;
  Selector(String name, float x, float y, float w, float h, int cc, int value) {
    super(name, x, y, w, h);
    this.cc = cc;
    ss = w/cc;
    setValue(value);
  }

  void update() {
    super.update();
    if (on && ui.input.click) {
      float pos = constrain(mouseX, rp.x, rp.x+w);
      value = (int) map(pos, rp.x, rp.x+w, 0, cc-0.001);
      setValue(value);
    }
  }

  void show() {
    noStroke();
    fill(ui.colors[2]);
    textAlign(LEFT, TOP);

    text(name+": "+value, x, y-20);
    fill(ui.colors[1]);
    rect(x, y, w, h);
    fill(ui.colors[2]);
    rect(x+ss*value, y, ss, h);
  }

  int getValue() {
    return value;
  }

  void setValue(int nv) {
    value = constrain(nv, 0, cc-1);
    change();
  }
}