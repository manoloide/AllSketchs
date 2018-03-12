ArrayList<Zone> zones;
PShader post;

void setup() {
  size(1280, 720, P3D);
  post = loadShader("data/post.glsl");
  post.set("resolution", float(width), float(height));
  generarZone();
}


void draw() {
  post.set("time", millis()/1000.);
  background(10);
  stroke(255, 14);
  drawGrid(0, 0, width, height, 20);

  for (int i = 0; i < zones.size (); i++) {
    Zone z = zones.get(i);
    z.update();
  }

  filter(post);
}

void keyPressed() {
  generarZone();
}

void generarZone() {
  zones = new ArrayList<Zone>();
  int esp = 20;
  int ww = int(width/esp);
  int hh = int(height/esp);
  for (int i = 0; i < 1000; i++) {
    int x = int(random(ww-3)+1);
    int y = int(random(hh-4)+1);
    int w = int(random(2, ww-x));
    int h = int(random(3, hh-y));
    boolean collision = false;
    for (int j = 0; j < zones.size (); j++) {
      Zone z = zones.get(j);
      if (z.collision(x*esp, y*esp, w*esp-1, h*esp-1)) {
        collision = true;
      }
    }
    if (!collision) zones.add(new Zone(x*esp, y*esp, w*esp, h*esp));
  }
}


void drawGrid(float x, float y, float w, float h, int cc) {
  for (int i = 0; i <= w; i+=cc) {
    line(i, 0, i, h);
  } 
  for (int i = 0; i <= h; i+=cc) {
    line(0, i, w, i);
  }
}

int paleta[] = {
  #01EEFF, 
  #F0E8F3, 
  #FD0A8A, 
  #981877, 
  #47092E
};

int rcol() {
  return paleta[int(random(paleta.length))];
}

class Zone {
  int col;
  float x, y, w, h;
  Zone(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y;
    this.w = w;
    this.h = h;
    col = rcol();
  }

  void update() {
    show();
  }

  void show() {
    fill(col, 40);
    rect(x, y, w, h);
    fill(col);
    rect(x, y, w, 20);
  }

  boolean collision(float x1, float y1, float w1, float h1) {
    return !(x > x1+w1 || x+w < x1 || y > y1+h1 || y+h < y1);
  }
}

