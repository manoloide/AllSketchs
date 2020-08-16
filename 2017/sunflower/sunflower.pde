ArrayList<PVector> points;
Camera cam;
boolean zoom = false;
Rect rect = null;

void setup() {
  size(720, 720, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
  background(0);

  cam = new Camera(width/2, height/2, 1);
}

void draw() {

  background(lerpColor(getColor(frameCount*0.02), color(0), 0.9));

  updatePoints();

  cam.update();
  stroke(0);
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    if (p.z > 30) {
      fill(255, 80);
      float plus = map(p.z, 30, 60, 0, 8);
      ellipse(p.x, p.y, p.z+plus, p.z+plus);
    }
    fill(getColor(p.z*0.1+frameCount*0.01));
    ellipse(p.x, p.y, p.z, p.z);
  }


  if (rect != null) {
    noStroke();
    fill(255, 40);
    rect.show();
    if (rect.remove) rect = null;
  }
  //render();
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}
void mousePressed() {
  zoom = !zoom;
  if (zoom) {
    cam.set(width/2, height/2, 1);
    if (rect != null) rect.open = false;
  } else {
    float dx = 0;
    float dy = 0;
    float ww = width;
    float hh = height;
    float vx = width/2-mouseX;
    float vy = height/2-mouseY;
    int val = int(random(4));
    if (abs(vx) > abs(vy)) {
      val = (vx < 0)? 2 : 3;
    } else {
      val = (vy < 0)? 0 : 1;
    }
    if (val == 0) {
      dy -= width/4;
      ww *= 2;
    }
    if (val == 1) {
      dy += width/4;
      ww *= 2;
    }
    if (val == 2) {
      dx -= height/4;
      hh *= 2;
    }
    if (val == 3) {
      dx += height/4;
      hh *= 2;
    }

    rect = new Rect(-dx*4, -dy*4, ww-10, hh-10);
    cam.set(width/2+dx, height/2+dy, 0.5);
  }
  //points.add(new PVector(mouseX, mouseY));
}

void updatePoints() {
  int n = points.size();
  float radius = width*0.8;
  float phi = (sqrt(5)+1)/2.0;
  float dd = 20;
  float cx = 0;
  float cy = 0;
  float maxDis = 300;
  float minDis = 40;
  for (int i = 0; i < n; i++) {
    float r = (i > n)? 1 : (sqrt(i-1./2)/sqrt(n-1)/2.0)*radius;
    float theta = TWO_PI*(i/pow(phi, 2));
    float xx = cx+r*cos(theta);
    float yy = cy+r*sin(theta);
    float ang = atan2(cam.my-yy, cam.mx-xx);
    float ss = 5;
    float dis = dist(xx, yy, cam.mx, cam.my);


    float des = 0;
    if (dis < maxDis) {
      des = pow(map(dis, minDis, maxDis, 1, 0), 2)*40;
      ss = map(pow((1-dis/maxDis), 5), 0, 1, 5, 30);
      if (dis < minDis) {
        ss =  map(dis, 0, minDis, 80, 30);
        des = map(dis, 0, minDis, 0, des);
      }
    }
    float nx = xx-cos(ang)*des;
    float ny = yy-sin(ang)*des;
    float ns = ss;

    float nv = 0.1;//map(dist(mouseX, mouseY, pmouseX, pmouseY), 0, 20, 0.1, 0);
    PVector p = points.get(i);
    p.x = p.x+(nx-p.x)*nv;
    p.y = p.y+(ny-p.y)*nv;
    p.z = p.z+(ns-p.z)*nv;
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  points = new ArrayList<PVector>();
  for (int i = 0; i < 180; i++) {
    points.add(new PVector(0, 0));
  }
}

int colors[] = {#F05638, #F5C748, #3FD189, #FFB9DB, #AF8AB4, #6FC4EA, #FFFFFF, #412A50};

int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = abs(v)%(colors.length);

  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  float m = v%1;

  //m = pow(m, 4);
  //return c1;
  return lerpColor(c1, c2, m);
}


class Camera {
  float x, y, s;
  float nx, ny, ns;
  float vel = 0.08;
  float mx, my;
  Camera(float x, float y, float s) {
    this.x = nx = x;
    this.y = ny = y;
    this.s = ns = s;
  }
  void update() {
    x += (nx-x)*vel;
    y += (ny-y)*vel;
    s += (ns-s)*vel;

    mx = map(mouseX-x, 0, width, 0, width/s);
    my = map(mouseY-y, 0, height, 0, height/s);

    translate(x, y);
    scale(s);
  }
  void set(float nx, float ny, float ns) {
    this.nx = nx;
    this.ny = ny;
    this.ns = ns;
  }
}

class Rect {
  boolean remove;
  color col;
  float x, y, w, h;
  float time;
  boolean open;
  Rect(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w; 
    this.h = h;
    time = 0;
    open = true;
    col = rcol();
  }
  void show() {
    rectMode(CENTER);
    if (open) {
      if (time < 1) time += 0.03;
      if (time > 1) time = 1;
    } else {

      if (time > 0) time -= 0.06;
      if (time < 0) time = 0;
    }
    float tt = pow(time, 0.8);
    float m1, m2;
    m1 = m2 = 0;
    if (tt < 0.2) {
      m1 = map(tt, 0, 0.2, 0, 0.1);
      m2 = map(tt, 0, 0.2, 0, 0.1);
    } else if (tt < 0.6) {
      m1 = map(tt, 0.2, 0.6, 0.1, 0.8);
      m2 = map(tt, 0.2, 0.6, 0.1, 0.2);
    } else if (tt < 1) {
      m1 = map(tt, 0.6, 1, 0.8, 1.0);
      m2 = map(tt, 0.6, 1, 0.2, 1.0);
    } else {
      m1 = m2 = 1;
    }
    float ww = w;
    float hh = h;
    if (w > h) {
      ww *= m1;
      hh *= m2;
    } else {
      hh *= m1;
      ww *= m2;
    }
    fill(col);
    rect(x, y, ww, hh, 4);
  }
}