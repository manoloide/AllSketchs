class TextView {
  boolean hide, drag, sound;
  int x, y, w, h;
  int time, timeAni, timeHide;
  PImage imgTitle[], imgText[];
  Trend select, newSelect;
  Touch touch;
  TextView() {
    w = 348;
    h = 600;
    x = width-w-60;
    y = 120;
    timeHide = int(60*ui.tiempoTexto);
    timeAni = int(60*ui.tiempoAniTexto);
  } 

  void update() {

    timeHide = int(60*ui.tiempoTexto);
    timeAni = int(60*ui.tiempoAniTexto);

    if (select != null) {
      if (touch == null) {
        touch = touchManager.click(x-camera.rx, y-camera.ry, w, (imgText[select.id].height+51+30));
        if (touch != null) {
          drag = true;
        }
      } else {
        if (touch.release) {
          drag = false;
          touch = null;
          time = timeAni;
        }
      }  
      if (drag) {
        x += touch.x-touch.px;
        y += touch.y-touch.py;
      }
    }

    if (newSelect != null || hide) {
      if (!drag) time-=2;
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

    if (sound && !hide && time < timeAni/3 && newSelect == null) {
      sound = false;
      soundManager.openText.trigger();
    }
  }

  void show() {
    if (select == null) return;
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
      hh = (imgText[select.id].height+52+30)*tt;
    }
    if (time > timeAni/3 && time < timeAni && !(newSelect != null || hide)) {
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
      int margenIzq = 29;
      //fill(colorWhite, sin(PI/2*constrain(map(t, timeAni*0.5, timeAni*0.8, 0, 1), 0, 1))*255);
      tint(255, sin(PI/2*constrain(map(t, timeAni*0.5, timeAni*0.8, 0, 1), 0, 1))*255);
      image(imgTitle[select.id], xx+margenIzq, yy+25);
      noTint();
      /*
      textAlign(LEFT, TOP);
       textFont(fontMedium);
       text(select.name, xx+26, yy+26);
       */
      //fill(colorWhite, sin(PI/2*map(t, timeAni*0.7, timeAni, 0, 1))*255);
      //textFont(fontText);
      //text(select.text, x+26, y+51, w-26*2, w);
      tint(255, sin(PI/2*map(t, timeAni*0.7, timeAni, 0, 1))*255);
      image(imgText[select.id], xx+margenIzq, yy+52);
      noTint();
    }
  }

  void setTrend(Trend nt) {
    if (select == null) {
      select = nt;
    } else {
      time = timeAni;
      newSelect = nt;
    }
    sound = true;
  }

  void createImages(Cell c) {
    int ww = w-29-44;
    PGraphics aux = createGraphics(ww, h);
    PGraphics aux2 = createGraphics(ww, 18);

    imgText = new PImage[c.nodes.size ()];
    imgTitle = new PImage[c.nodes.size ()];
    for (int i = 0; i < c.nodes.size (); i++) {
      Node n = c.nodes.get(i);
      n.id = i;
      aux.beginDraw();
      aux.clear();
      aux.fill(255);
      aux.textAlign(LEFT, TOP);
      aux.textFont(fontText);
      aux.text(n.text, 0, 0, ww, h);
      aux.textLeading(19); 
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

      aux2.beginDraw();
      aux2.clear();
      aux2.fill(255);
      aux2.textAlign(LEFT, TOP);
      aux2.textFont(fontTitleText);
      aux2.text(n.name, 0, 0);
      aux2.endDraw();
      aux2.updatePixels();

      imgTitle[i] = createImage(ww, aux2.height, ARGB);
      imgTitle[i] = aux2.get();
    }
  }
}

