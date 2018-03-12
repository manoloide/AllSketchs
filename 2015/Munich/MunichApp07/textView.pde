class TextView {
  boolean hide;
  int x, y, w, h;
  int time, timeAni, timeHide;
  PImage imgText[];
  Trend select, newSelect;
  TextView() {
    w = 348;
    h = 456;
    x = width-w-60;
    y = 60;
    timeAni = 60;
    timeHide = int(60*ui.tiempoTexto);
  } 

  void update() {

    timeHide = int(60*ui.tiempoTexto);

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
    strokeWeight(1);
    
    float xx = x-camera.rx;
    float yy = y-camera.ry;

    int t = constrain(time, 0, timeAni);
    float ldx = xx;
    float ldy = y+2;
    if (time < timeAni/4) {
      float tt  = cos(PI/2*map(t, 0, timeAni/4, 0, 1));
      ldx -= (xx-select.x)*tt;
      ldy -= (yy+2-select.y)*tt;
    }
    line(select.x, select.y, ldx, ldy);

    float hh = 0;
    if (time > timeAni/4) {
      float tt  = sin(PI/2*map(t, timeAni/4, timeAni, 0, 1));
      hh = (imgText[select.id].height+51+30)*tt;
    }
    if (time > timeAni/3 && time < timeAni*2 && !hide) {
      pushMatrix();
      translate(xx+2+loading.width/2, yy-loading.height/2-8);
      rotate(frameCount*0.1);
      image(loading, -loading.width/2, -loading.height/2);
      popMatrix();
    }
    noStroke();
    fill(0);
    rectMode(CORNER);
    rect(xx, yy, w, hh);
    if (time > timeAni/2) {
      fill(colorWhite, sin(PI/2*constrain(map(t, timeAni*0.5, timeAni*0.8, 0, 1), 0, 1))*255);
      textAlign(LEFT, TOP);
      textFont(fontMedium);
      text(select.name, xx+26, yy+26);
      //fill(colorWhite, sin(PI/2*map(t, timeAni*0.7, timeAni, 0, 1))*255);
      //textFont(fontText);
      //text(select.text, x+26, y+51, w-26*2, w);
      tint(255, sin(PI/2*map(t, timeAni*0.7, timeAni, 0, 1))*255);
      image(imgText[select.id], xx+26, yy+51);
      noTint();
    }
  }

  void setTrend(Trend nt) {
    if (select == null) {
      select = nt;
    } else {
      newSelect = nt;
    }
  }

  void createImages(Cell c) {
    int ww = w-26*2;
    PGraphics aux = createGraphics(ww, h);
    imgText = new PImage[c.nodes.size ()];
    for (int i = 0; i < c.nodes.size (); i++) {
      Node n = c.nodes.get(i);
      n.id = i;
      aux.beginDraw();
      aux.clear();
      aux.fill(255);
      aux.textAlign(LEFT, TOP);
      aux.textFont(fontText);
      aux.text(n.text, 0, 0, w-26*2, w);
      aux.endDraw(); 
      aux.updatePixels();
      int pp = 0;
      for (int j = aux.pixels.length-1; j >= 0; j--) {  
        color col = aux.pixels[j];
        if (alpha(col) > 0) {
          break;
        } else {
          pp++;
        }
      }
      imgText[i] = createImage(ww, aux.height-pp/ww, ARGB);
      imgText[i].copy(aux.get(), 0, 0, ww, imgText[i].height, 0, 0, ww, imgText[i].height);
    }
  }
}

