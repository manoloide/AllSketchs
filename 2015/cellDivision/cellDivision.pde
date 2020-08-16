ArrayList<Ball> balls;

void setup() {
  size(640, 640);
  balls = new ArrayList<Ball>();
  balls.add(new Ball(width/2, height/2, 100000));
}

void draw() {
  background(190);
  float mm = 0;
  for (int i = 0; i < balls.size (); i++) {
    Ball b = balls.get(i);
    b.update();
    mm += b.m;
    if (b.remove) balls.remove(i--);
    if (b.divide) {
      float a = random(TWO_PI);
      balls.add(new Ball(b.x-cos(a)*b.r/2, b.y-sin(a)*b.r/2, b.m/2));
      balls.add(new Ball(b.x+cos(a)*b.r/2, b.y+sin(a)*b.r/2, b.m/2));
      //balls.add(new Ball(b.x+b.r, b.y, b.m/2));
      balls.remove(i--);
    }
  }
  println(mm);
}

class Ball {
  boolean remove, divide;
  float x, y, m, r, d;
  float a, v, t;
  Ball(float x, float y, float m) {
    this.x = x; 
    this.y = y;
    this.m = m;
    r = sqrt((m/PI));
    d = r*2;

    a = random(TWO_PI);
    v = random(0.001, 0.01);
    t = 30;
  }

  void update() {
    /*
    x += cos(a)*d*v;
     y += sin(a)*d*v;
     */
    divide = false;
    if (t > 0) t--;
    if (dist(mouseX, mouseY, x, y) < r && t == 0) {
      divide = true;
    }

    show();
  }

  void show() {
    strokeWeight(d*0.01);
    ellipse(x, y, d, d);
    ellipse(x, y, d*0.05, d*0.05);
  }
}

