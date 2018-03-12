class TextView {
  boolean hide;
  int x, y, w, h;
  int time, timeAni, timeHide;
  Trend select, newSelect;
  TextView() {
    w = 348;
    h = 456;
    x = width-w-22;
    y = 59;
    timeAni = 80;
    timeHide = 60*2;
  } 

  void update() {
    if (select != null)
      show();

    if (newSelect != null || hide) {
      time-=2;
      if (time <= 0) {
        if (hide) select = null;
        else select = newSelect;
        newSelect = null;
        hide = false;
      }
    } else {
      if (select != null) time++;
      if (time > timeHide+timeAni) {
        time = timeAni;
        hide = true;
      }
    }
  }

  void show() {
    stroke(0);
    strokeWeight(3);

    int t = constrain(time, 0, timeAni);
    float ldx = x;
    float ldy = y+2;
    if (time < timeAni/4) {
      float tt  = cos(PI/2*map(t, 0, timeAni/4, 0, 1));
      ldx -= (x-select.x)*tt;
      ldy -= (y+2-select.y)*tt;
    }
    line(select.x, select.y, ldx, ldy);

    float hh = 0;
    if (time > timeAni/4) {
      float tt  = sin(PI/2*map(t, timeAni/4, timeAni, 0, 1));
      hh = h*tt;
    }
    noStroke();
    fill(0);
    rectMode(CORNER);
    rect(x, y, w, hh);
    if (time > timeAni/2) {
      fill(255, sin(PI/2*constrain(map(t, timeAni*0.5, timeAni*0.8, 0, 1), 0, 1))*255);
      textFont(fontMedium);
      text(select.name, x+13, y+32);
      fill(255, sin(PI/2*map(t, timeAni*0.7, timeAni, 0, 1))*255);
      textFont(fontText);
      text(select.text, x+13, y+58, w-13*2, w);
    }
  }

  void setTrend(Trend nt) {
    if (select == null) {
      select = nt;
    } else {
      newSelect = nt;
    }
  }
}

