Nodo n[];

void setup() {
  size(600, 600);
  n = new Nodo[4];
  for (int i = 0; i < n.length; i++) {
    n[i] = new Nodo(10);
  }
}

void draw() {
  background(240);
  //noStroke();
  //fill(240, 100);
  //rect(300,300,width,height);

  for (int i = 0; i < n.length; i++) {
    n[i].update();
  }

  if (frameCount%60 == 0) {
    for (int i = 0; i < n.length; i++) {
      n[i].changeVal(random(20, 180));
    }
  }
  /*
  ellipse(width/2, height/2, n.view, n.view);
   */
  noStroke();
  fill(#3DFC7E);

  float t[] = {
    n[0].view, n[1].view, n[2].view, n[3].view
  };
  float x[] = new float[4];
  float y[] = new float[4];
  color c[] = {
    #3DFC7E, #FC3D64, #3DC1FC, #FCED3D
  };

  float tt = n[0].view;
  x[0] = width/2-tt/2;
  y[0] = height/2-tt/2;
  tt = n[1].view;
  x[1] = width/2+tt/2;
  y[1] = height/2-tt/2;
  tt = n[2].view;
  x[2] = width/2+tt/2;
  y[2] = height/2+tt/2;
  tt = n[3].view;
  x[3] = width/2-tt/2;
  y[3] = height/2+tt/2;

  rectMode(CENTER);
  for (int i = 0; i < 4; i++) {
    fill(c[i]);
    rect(x[i], y[i], t[i], t[i]);
  }

  for (int i = 0; i < 4; i++) {
    fill(10);
    //strokeWeight(1.5);
    stroke(10);
    line(x[i], y[i], x[(i+1)%4], y[(i+1)%4]);
    noStroke();
    rect(x[i], y[i], 4, 4);
  }
  /*
  t = n[1].view;
   fill(c[1]);
   rect(width/2, height/2-t, t, t);
   t = n[2].view;
   fill(c[2]);
   rect(width/2, height/2, t, t);
   t = n[3].view;
   fill(c[3]);
   rect(width/2-t, height/2, t, t);
   
   fill(10);
   rect(x, y, 4, 4);
   */
}

class Nodo {
  float val, view;
  Nodo(float val) {
    this.val = val;
    view = 0;
  }
  void update() {
    view += (val-view)/4;
  }
  void changeVal(float val) {
    this.val = val;
  }
}

