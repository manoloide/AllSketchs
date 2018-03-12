ArrayList<Parti> partis = new ArrayList<Parti>();
Time time;

void setup() {
  size(640, 640);
  time = new Time();
  background(220);
}

void draw() {
  background(0);
  for (int i = 0; i < partis.size (); i++) {
    Parti p = partis.get(i);
    p.update();
    if (p.remove) partis.remove(i--);
  }
  time.update();
}

void mouseDragged() {
  float dis = dist(mouseX, mouseY, pmouseX, pmouseY);
  float a = atan2(pmouseY-mouseY, pmouseX-mouseX);
  int cc = int(pow(dis, 1.2))*2;
  float d = dis/cc;
  for (int i = 0; i < cc; i++) {
    float x = pmouseX+cos(a)*d*i;
    float y = pmouseY+sin(a)*d*i;
    partis.add(new Parti(x, y));
  }
}

void mousePressed() {
  /*
  for (int i = 0; i < 1000; i++) {
   partis.add(new Parti(mouseX, mouseY));
   }
   */
}

class Parti {
  boolean remove;
  color col;
  float x, y, s, a;
  Parti(float x, float y) {
    this.x = x; 
    this.y = y;
    s = random(2, 20);
    a = random(TWO_PI);
    col = (random(1) < 0.8)? color(random(256)) : color(255, random(100, 200), 0);
  }
  void update() {
    a += random(-6, 6)*time.deltaTime;
    x += cos(a)*50*time.deltaTime;
    y += sin(a)*50*time.deltaTime;
    s *= 1-0.99*time.deltaTime;
    if (s < 0.8) remove = true;
    show();
  }
  void show() {
    stroke(0, 200);
    fill(col, 240);
    strokeWeight(s*0.05);
    ellipse(x, y, s, s);
  }
}

void keyPressed() {
  int times[] = {
    1, 5, 10, 18, 20, 30, 60, 80, 100, 120
  };
  if (key >= 48 && key < 58) {
    int i = (int(key)-39)%10;
    frameRate(times[i]);
  }
}

class Time {
  int currentTime, previousTime;
  float deltaTime;
  Time() {
  }
  void update() {
    previousTime = currentTime;
    currentTime = millis();
    deltaTime = (currentTime-previousTime)/1000.;
  }
}

