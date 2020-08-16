import android.view.MotionEvent;

ArrayList<Touch> touchs = new ArrayList<Touch>();

class Controller {

  boolean viewTouchs = true;

  ControllerStick stick;
  ControllerButton button1, button2;

  float x = 780;

  Controller() {
    stick = new ControllerStick(126, x, 160);
    button1 = new ControllerButton(338, x+32, 100);
    button2 = new ControllerButton(444, x-30, 100);
  }

  void update() {

    for (int i = 0; i < touchs.size(); i++) {
      Touch t = touchs.get(i);
      if (t.clicked) {
        stick.press(t);
        button1.press(t);
        button2.press(t);
      }

      if (viewTouchs) {
        infoCircle(touchs.get(i));
      }
    }

    stick.update();
    button1.update();
    button2.update();
  }
}



void infoCircle(Touch touch) {
  float diameter = 512 * touch.size;
  noFill();
  ellipse(touch.x, touch.y, diameter, diameter);
  fill(0, 255, 0);
  ellipse(touch.x, touch.y, 8, 8);
  text( ("ID:"+ touch.id + " " + int(touch.x) + ", " + int(touch.y) ), touch.x-128, touch.y-64);
}


class ControllerStick {

  boolean clicked, pressed, released;
  float x, y, size;
  float tx, ty, cx, cy, vx, vy; 
  float stickSize = 44;
  float sensitivity = 0.2;
  Touch touch;

  ControllerStick(float x, float y, float size) {
    this.x = x; 
    this.y = y; 
    this.size = size;
  }

  void update() {

    float maxDist = (size-stickSize)*0.5-2;
    if (touch != null) {
      float dis = min(dist(x, y, touch.x, touch.y), maxDist);
      float ang = atan2(touch.y-y, touch.x-x);

      tx = cos(ang)*dis;
      ty = sin(ang)*dis;

      if (touch.released) {
        tx = ty = 0;
        pressed = false;
        released = true;
        touch = null;
      }
    }

    cx += (tx-cx)*sensitivity;
    cy += (ty-cy)*sensitivity;

    vx = cx/maxDist;
    vy = cy/maxDist;

    clicked = false;
  }

  void show() {
    stroke(255, 154);
    strokeWeight(4);
    noFill();
    ellipse(x, y, size, size);

    noStroke();
    fill(255, 154);
    ellipse(x+tx, y+ty, stickSize-14, stickSize-14);
    ellipse(x+tx, y+ty, stickSize, stickSize);
  }

  void press(Touch t) {
    if (touch != null) return;

    if (dist(t.x, t.y, x, y) < size*0.5) {
      clicked = pressed = true;
      touch = t;
    }
  }
}

class ControllerButton {
  boolean clicked, pressed, released;
  float x, y, size;
  Touch touch;

  ControllerButton(float x, float y, float size) {
    this.x = x; 
    this.y = y; 
    this.size = size;
  }

  void update() {

    if (touch != null) {
      if (touch.released) {
        pressed = false;
        released = true;
        touch = null;
      }
    }
    
    clicked = false;
  }

  void show() {

    noStroke();
    fill(255, 154);
    ellipse(x, y, size-14, size-14);
    ellipse(x, y, size, size);
  }

  void press(Touch t) {
    if (touch != null) return;

    if (dist(t.x, t.y, x, y) < size*0.5) {
      clicked = pressed = true;
      touch = t;
    }
  }
}


class Touch {
  boolean clicked, pressed, released;
  int id; 
  float x, y, size;
  Touch(float x, float y, float size, int id) {
    this.x = x;
    this.y = y; 
    this.size = size;
    this.id = id;
    clicked = pressed = true;
    released = false;
  }

  void set(float x, float y, float size) {
    this.x = x;
    this.y = y; 
    this.size = size;
  }
}

public boolean surfaceTouchEvent(MotionEvent me) {

  int amount = me.getPointerCount();
  for (int i=0; i < amount; i++) {
    float x = me.getX(i);
    float y = me.getY(i);
    float size = me.getSize(i);
    int id = me.getPointerId(i);

    boolean exist = false;
    for (int j = 0; j < touchs.size(); j++) {
      Touch t = touchs.get(j);
      if (t.id == id) {
        exist = true;
        t.set(x, y, size);
        t.clicked = false;
      }
    }

    if (!exist) {
      touchs.add(new Touch(x, y, size, id));
    }
  }

  int actionId = me.getPointerId(me.getActionIndex());

  if (me.getActionMasked() == MotionEvent.ACTION_UP || me.getActionMasked() == MotionEvent.ACTION_POINTER_UP) {
    for (int j = 0; j < touchs.size(); j++) {
      Touch t = touchs.get(j);
      if (t.id == actionId) {
        t.pressed = false;
        t.released = true;  
        touchs.remove(j--);
      }
    }
  }

  return super.surfaceTouchEvent(me);
}