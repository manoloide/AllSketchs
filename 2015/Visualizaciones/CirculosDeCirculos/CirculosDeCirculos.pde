ArrayList<Nodo> nodos;
PFont oslo;

void setup() {
  size(600, 600);

  oslo = createFont("Stockholm Mono", 16, true);
  textFont(oslo);

  nodos = new ArrayList<Nodo>();
  for (int i = 0; i < 8; i++) {
    float a = random(TWO_PI);
    float r = random(width*0.4);
    float x = width/2+cos(a)*r;
    float y = height/2+sin(a)*r;
    nodos.add(new Nodo(x, y));
  }
}

void draw() {
  background(10);
  noStroke();
  for (int i = 0; i < nodos.size (); i++) {
    Nodo n = nodos.get(i);
    n.update();
  }  

  float d = 400;
  float r = d/2;
  int c = 20;
  float s = r/c;
  float t = 2;

  float cx = width/2; 
  float cy = height/2;
  translate(cx, cy);
  scale(1+cos(frameCount*0.01)*0.1);
  rotate(frameCount*0.0013);
  noStroke();
  for (int j = -c; j <= c; j++) {
    for (int i = -c; i <= c; i++) {
      float x = i*s;//(i+(i%2)*0.5)*s;
      float y = (j+(i%2)*0.5)*s; 
      float tt = t;
      if (dist(x, y, 0, 0) > r) continue;
      ellipse(x, y, tt, tt);
    }
  }
}


class Nodo {
  boolean on;
  float x, y, d; 
  float ang, time, val;
  float dh, dv;
  Nodo(float x, float y) {
    this.x = x; 
    this.y = y;
    d = 10;
    ang = random(TWO_PI);
    time = 0;
    val = random(101);
    
    if(x < width/2) dh = -1;
    else dh = 1;
    if(y < height/2) dv = -1;
    else dv = 1;
  }
  void update() {
    if (dist(mouseX, mouseY, x, y) < d/2) {
      if (!on) { 
        on = true;
      }
    } else {
      if (on) {
        on = false;
      }
    }
    if (on) {
      time += 1000/60;
      if (time > 500) time = 500;
    } else {
      time -= 1000/60;
      if (time < 0) time = 0;
    }
    show();
  }
  void show() {
    if (time < 500) {
      float dd = 0;
      dd = map(time, 0, 500, d, d*2);
      float aa = map(dd, d, d*2, 255, 0);
      noStroke();
      fill(255, aa);
      ellipse(x, y, dd, dd);
    }

    showIndicador();

    noStroke();
    fill(255);
    ellipse(x, y, d, d);
  }

  void showIndicador() {
    float t1, t2;
    stroke(255);
    t1 = constrain(map(time, 0, 200, 0, 20), 0, 20);
    t2 = constrain(map(time, 200, 300, 0, 6), 0, 6);
    if (t1 != 0)line(x, y, x+t1*dh, y-t1*dv);
    if (t2 != 0)line(x+20*dh, y-20*dv, x+(20+t2)*dh, y-20*dv);


    if (time > 200) {
      float vv = map(time, 200, 500, 0, val);
      fill(255, constrain(map(time, 200, 400, 0, 255), 0, 255));
      if(dh > 0) textAlign(LEFT, DOWN);
      else textAlign(RIGHT, DOWN);
      text(int(vv)+"%", x+30*dh, y-20*dv);
    }
  }
}
