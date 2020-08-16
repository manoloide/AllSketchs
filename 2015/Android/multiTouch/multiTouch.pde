import android.view.MotionEvent;

ArrayList<Touch> touchs;
int circleBaseSize = 512; // change this to make the touche circles bigger\smaller.

void setup() {
  orientation(PORTRAIT);
  stroke(255);
  textAlign(LEFT);
  
  touchs = new ArrayList<Touch>();
}

void draw() {
  background(0);
  for(int i = 0; i < touchs.size(); i++){
     infoCircle(touchs.get(i)); 
  }
}

void infoCircle(Touch touch) {
  float diameter = circleBaseSize * touch.size;
  noFill();
  ellipse(touch.x, touch.y, diameter, diameter);
  fill(0,255,0);
  ellipse(touch.x, touch.y, 8, 8);
  text( ("ID:"+ touch.id + " " + int(touch.x) + ", " + int(touch.y) ), touch.x-128, touch.y-64);
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

    if (me.getActionMasked() == MotionEvent.ACTION_UP) {
      touchs.clear();
    }

    if (!exist) {
      touchs.add(new Touch(x, y, size, id));
    }
  }

  int actionId = me.getPointerId(me.getActionIndex());

  if (me.getActionMasked() == MotionEvent.ACTION_POINTER_UP) {
    for (int j = 0; j < touchs.size(); j++) {
      Touch t = touchs.get(j);
      if (t.id == actionId) {
        print(actionId);
        t.pressed = false;
        t.released = true;  
        touchs.remove(j--);
      }
    }
  }

  return super.surfaceTouchEvent(me);
}