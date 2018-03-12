class Windows extends Scene {
  boolean view;
  int time, timeView, timeSleep;

  ArrayList<Cosa> cosas;
  ArrayList<Cosa> aparecer;
  boolean order;
  int wait;
  int count = 5;
  int palet = 8; 
  int paleta[][] = {
    {
      #0A1A3D, 
      #FF2B67, 
      #FB7A63, 
      #F7C95E
    }
    , 
    {
      #6FE7DD, 
      #3490DE, 
      #6639A6, 
      #521262
    }
    , 
    {
      #303841, 
      #3A4750, 
      #F6C90E, 
      #EEEEEE
    }
    , 
    {
      #FF6138, 
      #FFFF9D, 
      #BEEB9F, 
      #79BD8F
    }
    , 
    {
      #26252C, 
      #E54861, 
      #F2A379, 
      #EFD5B7
    }
    , 
    {
      #08D9D6, 
      #252A34, 
      #FF2E63, 
      #EAEAEA
    }
    , 
    {
      #2C2D34, 
      #E94822, 
      #F2910A, 
      #EFD510
    }
    , 
    {
      #364F6B, 
      #3FC1C9, 
      #F5F5F5, 
      #FC5185
    }
    , 
    {
      #3EC1D3, 
      #F6F7D7, 
      #FF9A00, 
      #FF165D
    }
    , 
    {
      #EFF2DD, 
      #FCDA05, 
      #EE4848, 
      #5C3551
    }
  };

  Windows() {
    super();
    //bug = new Bug();
    cosas = new ArrayList<Cosa>();
    aparecer = new ArrayList<Cosa>();

    //create();
  }

  void update() {
    super.update();
    if (view) {
      time--;
      if (time <= 0) {
        view = false;
        timeSleep = int(random(20, 300))*60;
        time = timeSleep;
        removeAll();
      }
    } else {
      time--;
      if (time <= 0) {
        view = true;
        timeView = int(random(12, 40))*60;
        time = timeView;
        create();
      }
    }
    if (!view) return;
    wait--;
    if (aparecer.size() >= 1) {
      int v = int(random(aparecer.size()));
      if (order) v = 0;
      cosas.add(aparecer.get(v));
      aparecer.remove(v);

      wait = int(random(120, 240));
    } else if (wait < 0) {
      int v = int(random(cosas.size()));
      cosas.remove(v);
      if (cosas.size() > 0) {
        v = int(random(cosas.size()));
        cosas.remove(v);
      }
      if (cosas.size() == 0) {
        count--;
        create();
      }
    }
    background(20);
    hint(DISABLE_DEPTH_TEST);
    int lll = 8;
    float dd = (frameCount/10)%(lll*2);
    stroke(30);
    strokeWeight(lll*0.5);
    for (float i = -dd; i < width+height; i+=lll*2) {
      line(i, -2, -2, i);
    }

    hint(ENABLE_DEPTH_TEST);
    for (int i = 0; i < cosas.size (); i++) {
      Cosa c = cosas.get(i); 
      c.update();
      if (c.remove) cosas.remove(i--);
    }

    //float glit = noise(millis()*0.0002+100)*1.4-0.4;
    float glit = pow(map(time, 0, timeView, 1.45, -1.8), 1.5);
    glit += noise(millis()*0.0002+100)*1.4-0.6;
    glitch.set("glitch", glit);
    if (glit > 0) 
      filter(glitch);
    strokeWeight(1);
  }

  void create() {
    palet = int(random(paleta.length));
    order = (random(1) < 0.5);
    int tam = int(random(40, 100));
    int bor = int(random(tam*0.1, tam*0.25)); 
    int cw = (width-bor*2)/(tam+bor);
    int ch = (height-bor*2)/(tam+bor);
    int dx = (width-(tam*cw+bor*(cw-1)))/2;
    int dy = dx;
    if ((dy+(ch-1)*(tam+bor)+tam) > height-bor) ch--;
    for (int j = 0; j < ch; j++) {
      for (int i = 0; i < cw; i++) {
        aparecer.add(new Ventana(dx+i*(tam+bor), dy+j*(tam+bor), dx+i*(tam+bor)+tam, dy+j*(tam+bor)+tam));
      }
    }
  }

  void removeAll() {

    cosas = new ArrayList<Cosa>();
    aparecer = new ArrayList<Cosa>();
  }


  int rcol() {
    return paleta[palet][int(random(paleta[0].length))];
  }

  class Cosa {
    boolean remove;
    void update() {
    }
    void show() {
    }
  }

  class Ventana extends Cosa {
    boolean on;
    color col;
    int x, y, w, h;
    int time;
    Visual visual;
    Ventana(int x1, int y1, int x2, int y2) {
      x = min(x1, x2);
      y = min(y1, y2);
      x2 = max(x1, x2);
      y2 = max(y1, y2);
      x1 = x;
      y1 = y;
      w = x2-x1;
      h = y2-y1;
      col = rcol();
      if (random(1) < 0.8) visual = new Visual1(x+4, y+4, w-8, h-8);
      else visual = new Visual2(x+4, y+4, w-8, h-8);
    }
    void update() {
      time++;
      if (mouseX >= x && mouseX < x+w && mouseY >= y && mouseY < y+h) on = true;
      else on = false;
      visual.update();
      if (!remove) show();
    }

    void show() {
      float w = this.w;
      float h = this.h;
      int timeAparece = 20;
      int timeCarga = 30;
      if (time < timeAparece) {
        float tt = sin((time*1./timeAparece)*PI/2);
        w = this.w * tt;
        h = this.h * tt;
      }
      noStroke();
      fill(#F2F2F2);
      rect(x, y, w, h);
      if (time > timeAparece) {
        float bb = 4;
        if (time < timeAparece+timeCarga) w = this.w * (time-timeAparece)*1./timeCarga;
        else if (time < timeAparece+timeCarga*1.3) bb *= map(time, timeAparece+timeCarga, timeAparece+timeCarga*1.3, 1, 0);
        else bb = 0;
        fill(col);
        rect(x, y+h-bb, w, bb);
      }
      if (time > timeAparece+timeCarga*1.3) {
        float alp = map(time, timeAparece+timeCarga*1.3, timeAparece+timeCarga*1.5, 90, 255);
        if (alp < 255) {
          tint(255, alp);
        }
        visual.show();
        noTint();
      }
      fill(50);
      triangle(x, y, x+12, y, x, y+12);
    }
  }

  class Visual {
    int time;
    int x, y, w, h;
    PGraphics gra;
    void update() {
      time++;
    }
    void show() {
    }
  }

  class Visual1 extends Visual {
    int bac, li, dir, tt, l;
    Visual1(int x, int y, int w, int h) {
      this.x = x; 
      this.y = y;
      this.w = w;
      this.h = h;
      l = (random(1) < 0.5)? -1 : 1;
      bac = rcol();
      li = rcol();
      dir = int(random(4));
      if (dir == 3) dir += int(random(2));
      while (li == bac) li = rcol();
      tt = int(random(2, 10));
      gra = createGraphics(w, h);
      gra.beginDraw();
      gra.background(bac);
      gra.endDraw();
    }
    void show() {
      gra.beginDraw();
      gra.background(bac);
      gra.stroke(li);
      gra.strokeWeight(tt);
      for (int i = -tt+ (frameCount*l)%(tt*2); i < w+h+tt; i+=tt*2) {
        if (dir == 0) gra.line(i, -2, -2, i);  
        if (dir == 1) gra.line(i, -2, i, h+2);
        if (dir == 2) gra.line(-2, i, w+2, i);
        if (dir == 3) gra.line(i-w, -2, w+2, i);
        if (dir == 4) gra.line(-2, i-h, i, h);
      }
      gra.endDraw();
      image(gra, x, y);
    }
  }

  class Visual2 extends Visual {
    int bac;
    int cant;
    float ttt;
    Visual2(int x, int y, int w, int h) {
      this.x = x; 
      this.y = y;
      this.w = w;
      this.h = h;
      bac = rcol();
      ttt = random(0.1, 5);
      cant = int(random(1, 5));
      gra = createGraphics(w, h);
      gra.beginDraw();
      gra.background(bac);
      gra.endDraw();
    }
    void show() {
      gra.beginDraw();
      //gra.background(bac);
      float xx = random(w);
      float yy = random(h);
      float tt = random(0.05, 0.2)*w/cant;
      float ang = random(TWO_PI);
      int count = int(random(3, 10));
      float da = TWO_PI/count;
      for (int j = cant; j >= 1; j--) {
        gra.beginShape();
        gra.noStroke();
        gra.fill(rcol());
        for (int i = 0; i < count; i++) {
          gra.vertex(xx+cos(ang+da*i)*tt*j*ttt, yy+sin(ang+da*i)*tt*j*ttt);
        }
        gra.endShape(CLOSE);
        gra.endDraw();
      }
      image(gra, x, y);
    }
  }
}