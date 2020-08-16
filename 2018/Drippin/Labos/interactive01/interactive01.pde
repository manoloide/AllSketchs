ArrayList<Rect> rects;
float mx, my, mm, time;

void setup() {
  size(640, 640, P2D);
  smooth(2);
  noCursor();
  //pixelDensity(2);
  //frameRate(25);
  generate();
}


void draw() {
  mm *= 0.95;
  //if (mm < 0.04) mm *= 0.2;
  mx = mouseX-width/2;
  my = mouseY-height/2;
  time = millis()*0.002;
  background(190);

  translate(width/2, height/2);

  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    r.update();
    r.showShadow();
  }

  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    r.show();
  }

  fill(255);
  ellipse(mx, my, 50, 50);
}

void keyPressed() {
  generate();
}

void mouseClicked() {
  sub();
}

void mouseMoved() {
  mm += 0.05;
  sub();
}

void sub() {
  for (int i = rects.size()-1; i >= 0; i--) {
    if (rects.get(i).isOn(mx, my)) {
      rects.get(i).sub(); 
      break;
    }
  }
}

void generate() {
  rects = new ArrayList<Rect>();
  rects.add(new Rect(-200, -200, 400, color(random(256))));
}

class Rect {
  color ncol, col;
  float ix, iy, x, y, s, b;
  float ang, dis;
  Rect(float x, float y, float s, int c) {
    this.x = x; 
    this.y = y; 
    ix = x; 
    iy = y;
    this.s = s;
    b = 50;
    ncol = rcol();
    col = c;
  }

  void mouseMovement() {
    float cx = x+s*0.5;
    float cy = y+s*0.5;
    float maxDist = 200;
    dis = dist(cx, cy, mx, my);
    ang = atan2(cy-my, cx-mx);
    if (dis < maxDist) {
      float dd = map(dis, 0, maxDist, 1, 0);
      dd = pow(dd, 0.9)*20*mm;
      x += cos(ang)*dd;
      y += sin(ang)*dd;
    }
  }

  void update() {

    x = lerp(x, ix, 0.09);
    y = lerp(y, iy, 0.09);
    col = lerpColor(col, ncol, 0.05); 

    mouseMovement();
  }

  void showShadow() {
    noStroke();
    beginShape();
    fill(0, 40);
    vertex(x+s, y);
    vertex(x+s, y+s);
    fill(0, 0);
    vertex(x+s+b, y+s+b);
    vertex(x+s+b, y+b);
    endShape(CLOSE);
    beginShape();
    fill(0, 40);
    vertex(x, y+s);
    vertex(x+s, y+s);
    fill(0, 0);
    vertex(x+s+b, y+s+b);
    vertex(x+b, y+s+b);
    endShape(CLOSE);
  }

  void show() {  
    stroke(255, 2);
    fill(col);
    rect(x, y, s, s);
  }

  boolean isOn(float mx, float my) {
    return (mx >= x && mx < x+s && my >= y && my < y+s);
  }

  void sub() {
    float ms = s*0.5;
    Rect r;
    rects.add(r = new Rect(ix, iy, ms, col));
    r.x+=x-ix;
    r.y+=y-iy;
    rects.add(r = new Rect(ix+ms, iy, ms, col));
    r.x+=x-ix;
    r.y+=y-iy;
    rects.add(r = new Rect(ix+ms, iy+ms, ms, col));
    r.x+=x-ix;
    r.y+=y-iy;
    rects.add(r = new Rect(ix, iy+ms, ms, col));
    rects.remove(this);
  }
}

int colors[] = {#5741BB, #FD7060, #FDBF67, #34C592, #D8F6DA, #FFFFFF};
int rcol() {
  return colors[int(random(colors.length))];
}
int[] rcols(int cc) {
  cc = constrain(cc, 1, colors.length);
  int[] aux = new int[cc];
  aux[0] = rcol();
  for (int i = 1; i < cc; i++) {
    boolean add = true;
    while (add) {
      add = false;
      aux[i] = rcol();
      for (int j = 0; j < i; j++) {
        if (aux[i] == aux[j]) {
          add = true;
        }
      }
    }
  }
  return aux;
}

int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}

void shuffleArray(int[] array) {
  for (int i = array.length; i > 1; i--) {
    int j = int(random(i));
    int tmp = array[j];
    array[j] = array[i-1];
    array[i-1] = tmp;
  }
}