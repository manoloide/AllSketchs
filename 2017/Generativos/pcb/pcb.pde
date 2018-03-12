void setup() {
  size(960, 960);
  smooth(8);
  rectMode(CENTER);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  background(10);

  int cc = int(random(20, 100));
  float ss = width/(cc+2.);
  translate(ss*1.5, ss*1.5);

  strokeWeight(ss*0.15);


  boolean used[][] = new boolean[cc][cc];
  int useds = cc*cc;
  ArrayList<Line> lines = new ArrayList<Line>();
  ArrayList<Component> components = new ArrayList<Component>();

  if (random(1) < 0.995) {
    int c = int(cc*cc*random(0.04));
    for (int i = 0; i < c; i++) {
      int w = 1;
      int h = 1;
      int dw = 0;
      int dh = 0;
      if (random(1) < 0.5) {
        dw = 1;
        w = 4;
      } else {
        dh = 1;
        h = 4;
      }

      int x = int(random(cc-w));
      int y = int(random(cc-h));

      boolean busy = false;
      for (int yy = y; yy < y+h+dh; yy++) {
        for (int xx = x; xx < x+w+dw; xx++) {
          if (used[xx][yy]) busy = true;
        }
      }
      if (busy) { 
        i--; 
        continue;
      }

      for (int yy = y; yy < y+h+dh; yy++) {
        for (int xx = x; xx < x+w+dw; xx++) {
          //if (dw == 1) 
          used[xx][yy] = true;
          useds--;
        }
      }

      lines.add(new Line(x, y));
      lines.add(new Line(x+w*dw, y+h*dh));

      components.add(new Resistor(x*ss, y*ss, x*ss+w*ss*dw, y*ss+h*ss*dh));
    }

    c = int(cc*cc*random(0.02));
    for (int i = 0; i < c; i++) {
      int w = 3;
      int h = 3;
      int dw = 0;
      int dh = 0;
      if (random(1) < 0.5) {
        dw = 1;
        w = int(random(3, 10));
      } else {
        dh = 1;
        h = int(random(3, 10));
      }

      int x = int(random(cc-w));
      int y = int(random(cc-h));

      boolean busy = false;
      for (int yy = y; yy <= y+h; yy++) {
        for (int xx = x; xx <= x+w; xx++) {
          if (used[xx][yy]) busy = true;
        }
      }

      if (busy) { 
        i--; 
        continue;
      }

      for (int yy = y; yy <= y+h; yy++) {
        for (int xx = x; xx <= x+w; xx++) {
          //if (dw == 1) 
          used[xx][yy] = true;
          useds--;
        }
      }

      for (int k = 0; k <= max(w, h); k++) {
        lines.add(new Line(x+dw*k, y+dh*k));
        lines.add(new Line(x+dw*k+w*dh, y+dh*k+h*dw));
      }

      noStroke();
      fill(140);
      float ww = (w+dw)*ss;
      float hh = (h+dh)*ss;
      rect(x*ss+ww*0.5-ss*0.5*dw, y*ss+hh*0.5-ss*0.5*dh, ww, hh, ss*0.2);
    }

    for (int i = 0; i < 10000; i++) {
      Line l = lines.get(int(random(lines.size())));
      int x = int(l.getLast().x);
      int y = int(l.getLast().y);
      boolean finish = false;
      int ccc = 2;
      int mx = int(random(-2, 2));
      int my = int(random(-2, 2));
      while (!finish) {
        if (x+mx < 0 || x+mx >= cc || y+my < 0 || y+my >= cc || used[x+mx][y+my]) {
          mx = int(random(-2, 2));
          my = int(random(-2, 2));
          ccc--;
          if (ccc < 0) finish = true;
        } else {
          x += mx;
          y += my;
          l.add(x, y);
          used[x][y] = true;
          useds--;
        }
      }
    }
  } else {

    /*
  while (useds > 0) {
     int x = int(random(cc));
     int y = int(random(cc));
     if (!used[x][y]) {
     used[x][y] = true;
     useds--;
     Line l = new Line(x, y);
     lines.add(l);
     }
     }
     */


    while (useds > 0) {
      int x = int(random(cc));
      int y = int(random(cc));
      if (!used[x][y]) {
        Line l = new Line(x, y);
        used[x][y] = true;
        useds--;
        boolean finish = false;
        int ccc = 2;
        int mx = int(random(-2, 2));
        int my = int(random(-2, 2));
        while (!finish) {
          if (x+mx < 0 || x+mx >= cc || y+my < 0 || y+my >= cc || used[x+mx][y+my]) {
            mx = int(random(-2, 2));
            my = int(random(-2, 2));
            ccc--;
            if (ccc < 0) finish = true;
          } else {
            x += mx;
            y += my;
            l.add(x, y);
            used[x][y] = true;
            useds--;
          }
        }
        lines.add(l);
      }
    }
  }
  stroke(250);
  noFill();
  for (int i = 0; i < lines.size(); i++) {
    Line l = lines.get(i);
    l.show(ss);
  }
  stroke(250);
  noFill();
  for (int i = 0; i < components.size(); i++) {
    Component c = components.get(i);
    c.show();
  }
}

class Line {
  ArrayList<PVector> points;
  Line(int x, int y) {
    points = new ArrayList<PVector>();
    add(x, y);
  }

  void show(float s) {
    ellipse(points.get(0).x*s, points.get(0).y*s, s*0.5, s*0.5);
    if (points.size() > 1) {
      ellipse(points.get(points.size()-1).x*s, points.get(points.size()-1).y*s, s*0.5, s*0.5);
      beginShape();
      for (int i = 0; i < points.size(); i++) {
        PVector p = points.get(i);
        vertex(p.x*s, p.y*s);
      }
      endShape();
    }
  }

  void add(float x, float y) {
    points.add(new PVector(x, y));
  }

  PVector getLast() {
    return points.get(points.size()-1);
  }
}

class Component {
  void show() {
  }
}

class Resistor extends Component {
  float x1, y1, x2, y2;
  float s;
  Resistor(float x1, float y1, float x2, float y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    s = max(abs(x1-x2), abs(y1-y2));
  }

  void show() {
    float x = (x1+x2)/2;
    float y = (y1+y2)/2;
    float w = s*0.65;
    float h = s*0.65;
    if (abs(x1-x2) < abs(y1-y2)) {
      w = s*0.18;
    } else {
      h = s*0.18;
    }
    stroke(140);
    strokeWeight(s*0.05);
    line(x1, y1, x2, y2);
    noStroke();
    fill(250, 220, 160);
    rect(x, y, w, h, s*0.1);
  }

  int colors[]  = {#000000, #ca8856, #ff0000, #e47412, #f5f010, #00ff02, #00ff02, #934287, #807f7d, #fffffd, #a5930b, #8f9289};
  int[] getColor() {
    int aux[] = {0};
    return aux;
  }
}

class IC extends Component {
  float x1, y1, x2, y2;
  float s;
  IC(float x1, float y1, float x2, float y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    s = max(abs(x1-x2), abs(y1-y2));
  }

  void show() {
    float x = (x1+x2)/2;
    float y = (y1+y2)/2;
    float w = s*0.65;
    float h = s*0.65;
    if (abs(x1-x2) < abs(y1-y2)) {
      w = s*0.18;
    } else {
      h = s*0.18;
    }
    stroke(140);
    strokeWeight(s*0.05);
    line(x1, y1, x2, y2);
    noStroke();
    fill(250, 220, 160);
    rect(x, y, w, h, s*0.1);
  }

  int colors[]  = {#000000, #ca8856, #ff0000, #e47412, #f5f010, #00ff02, #00ff02, #934287, #807f7d, #fffffd, #a5930b, #8f9289};
  int[] getColor() {
    int aux[] = {0};
    return aux;
  }
}

int colors[] = {#A60000, #00A600, #0000A6};

int rcol() {
  return colors[int(random(colors.length))];
}