/*
 - edit name
 */

class Timeline {
  ArrayList<Value> values;
  int selectedFrame;
  Value selected;

  boolean click, press;
  int cmouseX, cmouseY;
  boolean on, scrollTime;

  String message;
  int timeMessage;

  boolean hide;
  int x, y, w, h;
  int titleHeight, elementWidth, elementHeight;
  int buttonSize, borderButton;
  //playing and time
  boolean playing = false;
  boolean loop = true;
  float currentTime = 0;
  float sceneTime = 20;
  int currentFrame = 0;

  //json
  String jsonName = "data.json";

  Timeline() {
    values = new ArrayList<Value>();

    values.add(new BooleanValue("view", true));
    values.add(new FloatValue("x", width/2));
    values.add(new FloatValue("y", height/2));
    values.add(new FloatValue("dim", 20));
    values.add(new FloatValue("ang"));
    values.add(new IntegerValue("amount", 3));

    w = width;
    h = 200;
    x = 0;
    y = height-h;

    titleHeight = 36;
    borderButton = 2;
    elementWidth = 300;
    elementHeight = 24;

    buttonSize = 28;
    borderButton = 2;
  }

  void update() {
    if (scrollTime) {
      currentTime = map(mouseX-x, elementWidth, w, 0, sceneTime); 
      currentTime = constrain(currentTime, 0, sceneTime);
      currentFrame = int(currentTime*60);
    }

    if (playing) {
      currentTime += 1./60;
      if (currentTime > sceneTime) {
        currentTime = 0;
        if (!loop) {
          playing = false;
          currentTime = 0;
        }
      }
      currentFrame = int(currentTime*60);
    }

    int mx = int(mouseX-x);
    int my = int(mouseY-y);
    on = mx >= 0 || mx < w || my >= 0 || my < h;

    if (!hide && on) {
      for (int j = 0; j < values.size (); j++) {
        float desy = y+titleHeight+elementHeight*j;
        if (press && cmouseX >= x+elementWidth-80 && cmouseX < x+elementWidth-3 && cmouseY >= desy && cmouseY < desy+elementHeight) {
          Value v = values.get(j);
          if (v instanceof BooleanValue) {
            BooleanValue bt = (BooleanValue) v;
            boolean val = bt.getValue(currentFrame);
            if (mouseX != pmouseX) val = mouseX > pmouseX;
            bt.add(currentFrame, val);
          }
          if (v instanceof FloatValue) {
            FloatValue ft = (FloatValue) v;
            float val = ft.getValue(currentFrame)+(mouseX-pmouseX);
            ft.add(currentFrame, val);
          }
          if (v instanceof IntegerValue) {
            IntegerValue it = (IntegerValue) v;
            int val = it.getValue(currentFrame)+(mouseX-pmouseX);
            it.add(currentFrame, val);
          }
        }
        if (selected == null) {
          for (int k = 0; k < values.get (j).size(); k++) {
            Value t = values.get(j);
            int pf = t.keys.get(k);
            float pos = getPosition(pf/60.);
            if (click && dist(mouseX, mouseY, pos, desy+elementHeight/2) <= 8) {
              selected = t;
              selectedFrame = pf;
              break;
              //t.moveKey(pf, pf+2);
              //values.get(j).keys.get(k)
            }
            fill(255, 0, 0);
            ellipse(pos, desy+elementHeight/2, 8, 8);
          }
        } else {
          selected.moveKey(selectedFrame, currentFrame);
          selectedFrame = currentFrame;
          if (!press) {
            selected = null;
          }
        }
      }
    }

    //if (!hide) show();

    click = false;
  }

  void show() {  
    if (hide) return;
    noStroke();
    fill(40);
    rect(x, y, width, titleHeight);
    fill(50);
    rect(x, y+titleHeight, 300, h-titleHeight);
    fill(30);
    rect(x+elementWidth, y+titleHeight, width-300, h-titleHeight);


    fill(180);
    textSize(24);
    text(currentTime, x, y+8);
    stroke(40);
    fill(60);
    textAlign(LEFT, TOP);
    textSize(14);


    for (int i = 0; i < sceneTime; i++) {
      float posX = getPosition(i);
      line(posX, y+titleHeight, posX, y+h);
      text(i, posX+2, y+36);
    }
    stroke(180);
    float posX = getPosition(currentTime);
    line(posX, y+titleHeight, posX, y+h);

    noStroke();
    for (int i = 0; i < 6; i++) {
      float xx = x+(i+4)*(buttonSize+borderButton*2)+borderButton*2;
      float yy = y+borderButton*2;
      fill(20);
      rect(xx, yy, buttonSize, buttonSize, buttonSize*0.1);
      fill(220);
      if (i == 0) {
        if (playing) {
          rect(xx+buttonSize*0.3, yy+buttonSize*0.25, buttonSize*0.13, buttonSize*0.5); 
          rect(xx+buttonSize*0.57, yy+buttonSize*0.25, buttonSize*0.13, buttonSize*0.5);
        } else triangle(xx+buttonSize*0.3, yy+buttonSize*0.25, xx+buttonSize*0.3, yy+buttonSize*0.7, xx+buttonSize*0.7, yy+buttonSize*0.5);
      } else if (i == 1) {
        rect(xx+buttonSize*0.3, yy+buttonSize*0.3, buttonSize*0.4, buttonSize*0.4);
      } else if (i == 2) {
        triangle(xx+buttonSize*0.7, yy+buttonSize*0.75, xx+buttonSize*0.7, yy+buttonSize*0.3, xx+buttonSize*0.4, yy+buttonSize*0.5);
        xx -= buttonSize*0.2;
        triangle(xx+buttonSize*0.7, yy+buttonSize*0.75, xx+buttonSize*0.7, yy+buttonSize*0.3, xx+buttonSize*0.4, yy+buttonSize*0.5);
      } else if (i == 3) {
        triangle(xx+buttonSize*0.3, yy+buttonSize*0.25, xx+buttonSize*0.3, yy+buttonSize*0.7, xx+buttonSize*0.6, yy+buttonSize*0.5);
        xx += buttonSize*0.2;
        triangle(xx+buttonSize*0.3, yy+buttonSize*0.25, xx+buttonSize*0.3, yy+buttonSize*0.7, xx+buttonSize*0.6, yy+buttonSize*0.5);
      } else if (i == 4) {
        pushStyle();
        noFill();
        strokeWeight(buttonSize*0.07);
        stroke(220);
        if (!loop) stroke(90);
        ellipse(xx+buttonSize*0.37, yy+buttonSize*0.5, buttonSize*0.4, buttonSize*0.4); 
        ellipse(xx+buttonSize*0.63, yy+buttonSize*0.5, buttonSize*0.4, buttonSize*0.4);
        popStyle();
      } else if (i == 5) {
        pushStyle();
        textSize(20);
        textAlign(CENTER, CENTER);
        text("m", xx+buttonSize*0.5, yy+buttonSize*0.4);
        popStyle();
      }
    }

    for (int j = 0; j < values.size (); j++) {
      float desy = y+titleHeight+elementHeight*j;
      for (int k = 0; k < values.get (j).size(); k++) {
        int pf = values.get(j).keys.get(k);
        float pos = getPosition(pf/60.);
        noStroke();
        fill(#FBE360);
        if (dist(mouseX, mouseY, pos, desy+elementHeight/2) <= 6) stroke(#F1E497);
        ellipse(pos, desy+elementHeight/2, 6, 6);
      }
      noStroke();
      fill(54);
      if (j != 0) rect(x, desy, elementWidth, 1);
      fill(46);
      rect(x, desy+elementHeight, elementWidth, -1);
      fill(240);
      text(values.get(j).name, x+20, desy+6);
      pushStyle();
      textAlign(RIGHT, TOP);
      fill(#FBE360);
      String value = values.get(j).getStringValue(int(currentTime*60));
      text(value, x+elementWidth-16, desy+6);
      popStyle();
    }

    if (timeMessage > 0) {
      timeMessage--;
      float a = map(constrain(timeMessage, 0, 10), 0, 10, 0, 1);
      pushStyle();
      fill(0, 100*a);
      strokeWeight(3);
      stroke(0, 100*a); 
      rect(width/2-100, height/2-60, 200, 120, 6);
      fill(250, 255*a);
      textSize(28);
      textAlign(CENTER, CENTER);
      text(message, width/2, height/2);
      popStyle();
    }
  }

  boolean getBoolean(String name) {
    for (int i = 0; i < values.size (); i++) {
      Value aux = values.get(i);
      if (aux.name.equals(name) && aux instanceof BooleanValue) {
        return ((BooleanValue)aux).getValue(currentFrame);
      }
    }
    return false;
  }

  float getFloat(String name) {
    for (int i = 0; i < values.size (); i++) {
      Value aux = values.get(i);
      if (aux.name.equals(name) && aux instanceof FloatValue) {
        return ((FloatValue)aux).getValue(currentFrame);
      }
    }
    return 0;
  }

  float getInteger(String name) {
    for (int i = 0; i < values.size (); i++) {
      Value aux = values.get(i);
      if (aux.name.equals(name) && aux instanceof IntegerValue) {
        return ((IntegerValue)aux).getValue(currentFrame);
      }
    }
    return 0;
  }

  float getPosition(float f) {
    return map(f, 0, sceneTime, x+elementWidth, x+w);
  }

  void setMessage(String m, int t) {
    message =  m;
    timeMessage = t;
  }

  void prevFrame() {
    currentTime -= 1./60;
    if (currentTime < 0) currentTime = 0;
    currentFrame = int(currentTime*60);
  }
  void nextFrame() {
    currentTime += 1./60;
    if (currentTime > sceneTime) currentTime = sceneTime;
    currentFrame = int(currentTime*60);
  }

  void keyPressed() {
    if (key == ' ') playing = !playing;
    if (key == 'r') currentTime = 0;
    //if (key == 'l') loop = !loop;
    if (key == 'h') hide = !hide;
    if (key == 's') saveJson();
    if (key == 'l') loadJson();
    if (keyCode == LEFT) {
      prevFrame();
    }
    if (keyCode == RIGHT) {
      nextFrame();
    }
  }

  void keyReleased() {
  }

  void mousePressed() {
    int mx = int(mouseX-x);
    int my = int(mouseY-y);

    if (!on || hide)  return;
    cmouseX = mouseX;
    cmouseY = mouseY;

    click = true;
    press = true;
    if (my < titleHeight) {
      int btn = mx/(buttonSize+borderButton*2)-4;
      if (btn == 0) playing = !playing;
      if (btn == 1) {
        playing = false;
        currentTime = 0;
      } 
      if (btn == 2) {
        prevFrame();
      }
      if (btn == 3) {
        nextFrame();
      }
      if (btn == 4) loop = !loop;
    } else if (mx >= elementWidth) {
      scrollTime = true;
    }
  }

  void mouseDragged() {
    int mx = int(mouseX-x);
    int my = int(mouseY-y);
    if (!on || hide)  return;
  }

  void mouseReleased() {
    press = false;
    scrollTime = false;
  }

  void mouseWheel(MouseEvent event) {
    float e = event.getCount();
  }

  void loadJson() {
    JSONObject json = loadJSONObject(jsonName);
    values = new ArrayList<Value>();

    JSONArray jvalues = json.getJSONArray("values");
    for (int i = 0; i < jvalues.size (); i++) {
      JSONObject v = jvalues.getJSONObject(i);

      String type = v.getString("type");

      if (type.equals("boolean")) {
        values.add(new BooleanValue(v));
      } else if (type.equals("float")) {
        values.add(new FloatValue(v));
      } else if (type.equals("integer")) {
        values.add(new IntegerValue(v));
      }
    }

    setMessage("LOAD", 60);
  }

  void saveJson() {
    JSONObject json = new JSONObject();
    JSONArray jvalues = new JSONArray();

    for (int i = 0; i < values.size (); i++) {
      Value v = values.get(i);
      jvalues.append(v.getJson());
    }
    json.setJSONArray("values", jvalues);
    saveJSONObject(json, jsonName);

    setMessage("SAVE", 60);
  }
}

//VALUES

class Value {
  IntList keys;
  String name;
  int size() {
    return keys.size();
  }
  int getPosInd(int ind) {
    for (int i = 0; i < keys.size (); i++) {
      if (ind ==  keys.get(i)) {
        return i;
      }
    }
    return -1;
  }
  String getStringValue(int frame) {
    return "nonee";
  }
  void remove(int ind) {
  }
  void moveKey(int ind, int nind) {
  }
  JSONObject getJson() {
    return null;
  }
  void setJson(JSONObject jo) {
  }
};

class BooleanValue extends Value {
  HashMap<Integer, Boolean> values;
  BooleanValue(String name) {
    this.name = name;
    values = new HashMap<Integer, Boolean>();
    keys = new IntList();
    add(0, true);
  }
  BooleanValue(String name, boolean value) {
    this.name = name;
    values = new HashMap<Integer, Boolean>();
    keys = new IntList();
    add(0, value);
  }
  BooleanValue(JSONObject json) {
    setJson(json);
  }
  void add(int ind, boolean value) {
    remove(ind);
    values.put(ind, value);
    keys.append(ind);
    keys.sort();
  }
  void remove(int ind) {
    values.remove(ind);
    int ri = getPosInd(ind);
    if (ri != -1)keys.remove(ri);
  }
  void moveKey(int ind, int nind) {
    boolean value = values.get(ind);
    remove(ind);
    add(nind, value);
  }
  boolean getValue(int frame) {
    boolean value = false;
    if (keys.get(0) > frame) {
      value = values.get(keys.get(0));
    } else if (keys.get(keys.size()-1) < frame) {
      value = values.get((keys.get(keys.size()-1)));
    } else if (values.containsKey(frame)) {
      value = values.get(frame);
    } else {
      int prev = keys.get(0); 
      for (int i = 1; i < keys.size (); i++) {
        if (keys.get(i) > frame) {
          break;
        }
        prev = keys.get(i);
      }
      value = values.get(prev);
    }
    return value;
  }

  String getStringValue(int frame) {
    return str(getValue(frame));
  }
  JSONObject getJson() {
    JSONObject aux = new JSONObject();
    aux.setString("name", name);
    aux.setString("type", "boolean");
    JSONArray jkeys = new JSONArray();
    for (int i = 0; i < keys.size (); i++) {
      JSONObject key = new JSONObject();
      int frame = keys.get(i);
      key.setInt("time", frame);
      key.setBoolean("value", getValue(frame));
      jkeys.setJSONObject(i, key);
    }
    aux.setJSONArray("keys", jkeys);
    return aux;
  }
  void setJson(JSONObject jo) {
    name = jo.getString("name");
    values = new HashMap<Integer, Boolean>();
    keys = new IntList();
    JSONArray jkeys = jo.getJSONArray("keys");
    for (int i = 0; i < jkeys.size (); i++) {
      JSONObject o = jkeys.getJSONObject(i);
      add(o.getInt("time"), o.getBoolean("value"));
    }
  }
};

class FloatValue extends Value {
  Float min, max;
  HashMap<Integer, Float> values;
  FloatValue(String name) {
    this.name = name;
    values = new HashMap<Integer, Float>();
    keys = new IntList();
    add(0, 0);
  }
  FloatValue(String name, float value) {
    this.name = name;
    values = new HashMap<Integer, Float>();
    keys = new IntList();
    add(0, value);
  }
  FloatValue(JSONObject json) {
    setJson(json);
  }
  void add(int ind, float value) {
    if (min != null && value < min) value = min;
    if (max != null && value > max) value = max;
    remove(ind);
    values.put(ind, value);
    keys.append(ind);
    keys.sort();
  }
  void remove(int ind) {
    values.remove(ind);
    int ri = getPosInd(ind);
    if (ri != -1)keys.remove(ri);
  }
  void moveKey(int ind, int nind) {
    float value = values.get(ind);
    remove(ind);
    add(nind, value);
  }
  float getValue(int frame) {
    float value = 0;
    if (keys.get(0) > frame) {
      value = values.get(keys.get(0));
    } else if (keys.get(keys.size()-1) < frame) {
      value = values.get((keys.get(keys.size()-1)));
    } else if (values.containsKey(frame)) {
      value = values.get(frame);
    } else {
      int prev = keys.get(0); 
      int next = prev;
      for (int i = 1; i < keys.size (); i++) {
        next = keys.get(i);
        if (next > frame) {
          break;
        }
        prev = next;
      }
      value = map(frame, prev, next, values.get(prev), values.get(next));
    }
    return value;
  }
  String getStringValue(int frame) {
    return str(getValue(frame));
  }
  void setMin(float min) {
    this.min = min;
  }
  void setMax(float max) {
    this.max = max;
  }
  JSONObject getJson() {
    JSONObject aux = new JSONObject();
    aux.setString("name", name);
    aux.setString("type", "float");
    JSONArray jkeys = new JSONArray();
    for (int i = 0; i < keys.size (); i++) {
      JSONObject key = new JSONObject();
      int frame = keys.get(i);
      key.setInt("time", frame);
      key.setFloat("value", getValue(frame));
      jkeys.setJSONObject(i, key);
    }
    aux.setJSONArray("keys", jkeys);
    return aux;
  }
  void setJson(JSONObject jo) {
    name = jo.getString("name");
    values = new HashMap<Integer, Float>();
    keys = new IntList();
    JSONArray jkeys = jo.getJSONArray("keys");
    for (int i = 0; i < jkeys.size (); i++) {
      JSONObject o = jkeys.getJSONObject(i);
      add(o.getInt("time"), o.getFloat("value"));
    }
  }
};

class IntegerValue extends Value {
  Integer min, max;
  HashMap<Integer, Integer> values;
  IntegerValue(String name) {
    this.name = name;
    values = new HashMap<Integer, Integer>();
    keys = new IntList();
    add(0, 0);
  }
  IntegerValue(String name, int value) {
    this.name = name;
    values = new HashMap<Integer, Integer>();
    keys = new IntList();
    add(0, value);
  }
  IntegerValue(JSONObject json) {
    setJson(json);
  }
  void add(int ind, int value) {
    if (min != null && value < min) value = min;
    if (max != null && value > max) value = max;
    remove(ind);
    values.put(ind, value);
    keys.append(ind);
    keys.sort();
  }

  void remove(int ind) {
    values.remove(ind);
    int ri = getPosInd(ind);
    if (ri != -1)keys.remove(ri);
  }
  void moveKey(int ind, int nind) {
    int value = values.get(ind);
    remove(ind);
    add(nind, value);
  }
  int getValue(int frame) {
    int value = 20;
    if (keys.get(0) > frame) {
      value = values.get(keys.get(0));
    } else if (keys.get(keys.size()-1) < frame) {
      value = values.get((keys.get(keys.size()-1)));
    } else if (values.containsKey(frame)) {
      value = values.get(frame);
    } else {
      int prev = keys.get(0); 
      int next = prev;
      for (int i = 1; i < keys.size (); i++) {
        next = keys.get(i);
        if (next > frame) {
          break;
        }
        prev = next;
      }
      value = int(map(frame, prev, next, values.get(prev), values.get(next)));
    }
    return value;
  }
  String getStringValue(int frame) {
    return str(getValue(frame));
  }
  void setMin(int min) {
    this.min = min;
  }
  void setMax(int max) {
    this.max = max;
  }
  JSONObject getJson() {
    JSONObject aux = new JSONObject();
    aux.setString("name", name);
    aux.setString("type", "integer");
    JSONArray jkeys = new JSONArray();
    for (int i = 0; i < keys.size (); i++) {
      JSONObject key = new JSONObject();
      int frame = keys.get(i);
      key.setInt("time", frame);
      key.setInt("value", getValue(frame));
      jkeys.setJSONObject(i, key);
    }
    aux.setJSONArray("keys", jkeys);
    return aux;
  }
  void setJson(JSONObject jo) {
    name = jo.getString("name");
    values = new HashMap<Integer, Integer>();
    keys = new IntList();
    JSONArray jkeys = jo.getJSONArray("keys");
    for (int i = 0; i < jkeys.size (); i++) {
      JSONObject o = jkeys.getJSONObject(i);
      add(o.getInt("time"), o.getInt("value"));
    }
  }
}

