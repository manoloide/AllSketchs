import java.util.Random; 
import processing.pdf.*;

int DPI = 300;
int WIDTH = 897;
int HEIGHT = 1497;
float BLEEDING_WIDTH_IN = 2.99;
float BLEEDING_HEIGHT_IN = 4.99;
float CUT_WIDTH_IN = 2.75;
float CUT_HEIGHT_IN = 4.75;
float SAFE_WIDTH_IN = 2.51;
float SAFE_HEIGHT_IN = 4.51;

int colors[] = {#000000, #b49f55, #ffffff};

JSONObject settings;
PGraphics render;
UI ui;

boolean movedCamera;
int dx, dy;
int scale = 0;

float kappa = (4./3.)*(sqrt(2.)-1);

void setup() {
  size(1280, 720);
  surface.setResizable(true);
  loadSettings();
  render = createGraphics(WIDTH, HEIGHT);
  pixelDensity(2);
  smooth(8);
  createUI();
  randomAll();
  generate(render);
}

void loadSettings() {
  settings = loadJSONObject("data/settings.json");

  DPI = settings.getInt("DPI");
  WIDTH = settings.getInt("BLEEDING_WIDTH");
  HEIGHT = settings.getInt("BLEEDING_HEIGHT");
  BLEEDING_WIDTH_IN = settings.getFloat("BLEEDING_WIDTH_IN");
  BLEEDING_HEIGHT_IN = settings.getFloat("BLEEDING_HEIGHT_IN");
  CUT_WIDTH_IN = settings.getFloat("CUT_WIDTH_IN");
  CUT_HEIGHT_IN = settings.getFloat("CUT_HEIGHT_IN");
  SAFE_WIDTH_IN = settings.getFloat("SAFE_WIDTH_IN");
  SAFE_HEIGHT_IN = settings.getFloat("SAFE_HEIGHT_IN");
}

void draw() {
  background(100);

  ui.update();
  updateUIValues();
  if (ui.change) generate(render);

  pushMatrix();
  imageMode(CENTER);
  translate((width+ui.w)/2+dx, height/2+dy);
  scale(pow(2, scale));
  image(render, 0, 0);
  popMatrix();
  ui.show();
}

void keyPressed() {
  if (key == 's') saveImage();
  if (key == 'p') savePDF();
  if (key == 'g') randomAll();
  if (key == '+') zoom(1);
  if (key == '-') zoom(-1);
  if (key == 'c') {
    dx = 0; 
    dy = 0;
  }
}

void mousePressed() {
  ui.input.pressed();
  if (mouseX > ui.w) {
    movedCamera = true;
  }
}

void mouseDragged() {
  if (movedCamera) {
    dx += mouseX-pmouseX;
    dy += mouseY-pmouseY;
  }
}

void mouseReleased() {
  movedCamera = false;
  ui.input.released();
}

void mouseWheel(MouseEvent event) {
  int m = (int)constrain(event.getCount(), -1, 1);
  zoom(-m);
}

void zoom(int m) {
  scale += m;
  scale = constrain(scale, -5, 5);
}

/*
void resized() {
 ui.h = height;
 }
 */

void loadJSON(File selection) {
  if (selection != null) {
    JSONObject json = loadJSONObject(selection.getAbsolutePath());

    JSONObject aback = json.getJSONObject("back");
    JSONObject aframe = json.getJSONObject("frame");
    JSONObject aform = json.getJSONObject("forms");

    JSONObject jsons[] = {aback, aframe, aform};
    MultiLabel labels[] = {back, frame, forms};
    String names[] = {"Ø", "I", "II", "III", "IV", "V"};

    for (int j = 0; j < 3; j++) {
      int select = jsons[j].getInt("select");
      labels[j].select = select;
      Label l = (Label)((MultiLabel) labels[j]).getLabel(names[select]);
      JSONArray list = jsons[j].getJSONArray("components");
      for (int i = 0; i < list.size(); i++) {
        JSONObject aux = list.getJSONObject(i);
        String name = aux.getString("name");
        UIComponent c = l.getComponent(name);
        if (c instanceof Toggle) {
          Toggle t = (Toggle) c;
          t.setValue(aux.getBoolean("value"));
        }
        if (c instanceof Slider) {
          Slider s = (Slider) c;
          s.setValue(aux.getFloat("value"));
        }
        if (c instanceof Selector) {
          Selector s = (Selector) c;
          s.setValue((int)aux.getFloat("value"));
        }
      }
    }
  }

  generate(render);
}

void saveJSON() {
  JSONObject json = new JSONObject();

  JSONObject aback = new JSONObject();
  JSONObject aframe = new JSONObject();
  JSONObject aform = new JSONObject();

  JSONObject jsons[] = {aback, aframe, aform};
  MultiLabel labels[] = {back, frame, forms};
  String names[] = {"Ø", "I", "II", "III", "IV", "V"};
  for (int j = 0; j < 3; j++) {
    JSONArray list = new JSONArray();
    Label l = (Label)((MultiLabel) labels[j]).getLabel(names[labels[j].select]); 
    jsons[j].setInt("select", labels[j].select);
    for (int i = 0; i < l.components.size(); i++) {
      UIComponent a = l.components.get(i);
      if (a instanceof Toggle) {
        Toggle t = (Toggle) a;
        JSONObject jt = new JSONObject();
        jt.setString("name", t.name);
        jt.setBoolean("value", t.value);
        list.append(jt);
      }
      if (a instanceof Slider) {
        Slider s = (Slider) a;
        JSONObject jt = new JSONObject();
        jt.setString("name", s.name);
        jt.setFloat("value", s.value);
        list.append(jt);
      }
      if (a instanceof Selector) {
        Selector s = (Selector) a;
        JSONObject jt = new JSONObject();
        jt.setString("name", s.name);
        jt.setFloat("value", s.value);
        list.append(jt);
      }
    }
    jsons[j].setJSONArray("components", list);
  }

  json.setJSONObject("back", aback);
  json.setJSONObject("frame", aframe);
  json.setJSONObject("forms", aform);

  saveJSONObject(json, "exports/"+getTimestamp()+".json");
}

void saveImage() {
  render.save("exports/"+getTimestamp()+".png");
}

void savePDF() {
  PGraphics pdf = createGraphics (WIDTH, HEIGHT, PDF, "exports/"+getTimestamp()+".pdf");
  generate(pdf);
  render = createGraphics(WIDTH, HEIGHT);
  generate(render);
}

String getTimestamp() {
  return year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
}

void randomAll() {

  back.select = int(random(0.5, 6));
  frame.select = int(random(6));
  forms.select = int(random(6));

  rndCircularBack();
  rndHexBack();
  rndTramaBack();
  rndRhombusBack();
  rndRandomBack();

  rndSimpleFrame();
  rndDoubleFrame();


  rndCircularForm();

  generate(render);
}

void generate(PGraphics render) {
  render.beginDraw();
  render.smooth(8);
  render.background(colors[0]);
  back(render);
  forms(render);
  frame(render);
  render.dispose ();
  render.endDraw();
}

void back(PGraphics render) {
  if (back.select == 1) circularBack(render);
  if (back.select == 2) hexBack(render);
  if (back.select == 3) tramaBack(render);
  if (back.select == 4) rhombusBack(render);
  if (back.select == 5) randomBack(render);
}

void forms(PGraphics render) {
  if (forms.select == 1) circularForm(render);
}

void frame(PGraphics render) {

  if (frame.select == 1) simpleFrame(render);
  if (frame.select == 2) doubleBorder(render);
  if (frame.select == 3) guardaFrame(render);
  if (frame.select == 4) rectFrame(render);
  if (frame.select == 5) quadFrame(render);
  //linearBorder(render);
}