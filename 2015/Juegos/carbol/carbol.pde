ArrayList<Car> cars;
ArrayList<Particle> particles;
Ball ball;
Camera camera;
Car car;
Field field;


void setup() {
  size(640, 640);
  imageMode(CENTER);
  rectMode(CENTER);
  reset();
}

void reset() {
  ball = new Ball();
  camera = new Camera();
  car = new Car();
  cars = new ArrayList<Car>();
  cars.add(car);
  field = new Field();
  particles = new ArrayList<Particle>();
}

void draw() {
  background(40); 
  for (int i = 0; i < cars.size (); i++) {
    Car c = cars.get(i);
    c.update();
  } 
  for (int i = 0; i < particles.size (); i++) {
    Particle p = particles.get(i);
    p.update();
    if (p.remove) particles.remove(i--);
  }
  ball.update();
  camera.setTarget(car.position);
  camera.update();


  field.show();
  for (int i = 0; i < cars.size (); i++) {
    Car c = cars.get(i);
    c.show();
  }
  ball.show();
  for (int i = 0; i < particles.size (); i++) {
    Particle p = particles.get(i);
    p.show();
  }
}

void keyPressed() {
  if (keyCode == UP || key == 'w') {
    car.accelerate = true;
  }
  if (keyCode == DOWN || key == 's') {
    car.reverse = true;
  }
  if (keyCode == LEFT || key == 'a') {
    car.left = true;
  }
  if (keyCode == RIGHT || key == 'd') {
    car.right = true;
  }

  if (key == 'r') {
    reset();
  }
}

void keyReleased() {
  if (keyCode == UP || key == 'w') {
    car.accelerate = false;
  }
  if (keyCode == DOWN || key == 's') {
    car.reverse = false;
  }
  if (keyCode == LEFT || key == 'a') {
    car.left = false;
  }
  if (keyCode == RIGHT || key == 'd') {
    car.right = false;
  }
}

class Camera {
  float velocity = 0.1;
  PVector position, target;
  Camera() {
    position = new PVector();
    target = new PVector();
  }
  void update() {
    PVector mov = new PVector(target.x, target.y);
    mov.sub(position);
    mov.mult(velocity);
    position.add(mov);
    translate(width/2, height/2);
    translate(position.x, position.y);
  }
  void setPosition(PVector p) {
    position.x = p.x;
    position.y = p.y;
  }

  void setTarget(PVector t) {
    target.x = t.x;
    target.y = t.y;
  }
}

class Entity {
  PVector position;
  void update() {
  }
  void show() {
  }
}

class Ball extends Entity {
  float angle, velocity, s;
  Ball() {
    position = new PVector();
    s = 38;
  }
  void update() {
    velocity *= 0.92;
    position.x += cos(angle)*velocity;
    position.y += sin(angle)*velocity;
  }
  void show() {
    noStroke();
    fill(253);
    ellipse(position.x, position.y, s, s);
  }
}

class Car extends Entity {
  boolean accelerate, reverse, left, right;
  color col;
  float maxVelocity, acceleration; 
  float angle, velocity;
  PImage img;
  Car() {
    angle = PI/2;
    position = new PVector(0, -300);
    col = color(255, 110, 100);
    acceleration = 0.1;
    maxVelocity = 8;
    generate();
  }
  void update() {
    if (reverse) {
      velocity -= acceleration*0.8;
      if (velocity < maxVelocity*-0.4) velocity = maxVelocity*-0.4;
    } else if (accelerate) {
      float res = 1;
      if (left || right) res = 0.4;
      velocity += acceleration*res;
      if (velocity > maxVelocity) velocity = maxVelocity;
    } else {
      velocity -= acceleration;
      if (velocity < 0) velocity = 0;
    }

    if (left) {
      angle -= map(velocity, 0, maxVelocity, 0, 0.06);
    }
    if (right) {
      angle += map(velocity, 0, maxVelocity, 0, 0.06);
    }

    position.x += cos(angle)*velocity;
    position.y += sin(angle)*velocity;

    if (accelerate ) {
      int cc = int(pow(velocity-1, 1.8)*random(0.1, 1))/3;
      if (cc > 0) {
        float xx = -position.x+cos(angle)*34+cos(angle-PI*0.5)*5;
        float yy = -position.y+sin(angle)*34+sin(angle-PI*0.5)*5;
        for (int i = 0; i < cc; i++) {
          float a = random(TWO_PI);
          float s = velocity*random(0.5);
          particles.add(new SmookeParticle(xx+cos(a)*s, yy+sin(a)*s, angle+random(-1.2, 1.2)));
        }
      }

      field.drawTrace(position.x, position.y, angle, velocity/maxVelocity);
    }

    if (Collision.rectCircle(-position.x, -position.y, img.width, img.height, angle, ball.position.x, ball.position.y, ball.s*0.5)) {
      ball.velocity += velocity*1.2;
      ball.angle = angle-PI;
    }
  }
  void show() {
    pushMatrix();
    translate(-position.x, -position.y);
    rotate(angle);
    fill(col);
    imageMode(CENTER);
    image(img, 0, 0);
    popMatrix();
  }

  void generate() {
    int w = 64;
    int h = 32;
    PGraphics gra = createGraphics(w, h);
    color col2 = color(red(col)+12, green(col)+12, blue(col)+12);
    gra.beginDraw();
    gra.translate(w/2, h/2);
    gra.rectMode(CENTER);
    gra.noStroke();
    gra.fill(40);
    gra.rect(-15, -13, 9, 3, 3);
    gra.rect(15, -13, 9, 3, 3);
    gra.rect(-15, 13, 9, 3, 3);
    gra.rect(15, 13, 9, 3, 3);
    gra.fill(col);
    gra.rect(0, 0, 64, 28, 14, 6, 6, 14);
    gra.fill(255, 220);
    gra.rect(0, -3, 64, 3);
    gra.rect(0, 3, 64, 3);
    gra.fill(56);
    gra.rect(4, 0, 44, 22, 8, 5, 5, 8);
    gra.fill(col2);
    gra.rect(5, 0, 24, 22, 1);
    gra.endDraw();

    img = gra.get();
  }
}

class Field {
  int w, h;
  PGraphics gra;
  Field() {
    w = 1024; 
    h = 2048;
    generate();
  }

  void update() {
  }

  void show() {
    image(gra, 0, 0);
  }

  void generate() {
    gra = createGraphics(w, h);
    gra.beginDraw();
    float osc = random(30, 80);
    gra.background(osc+random(50), osc+random(20)+100, osc+random(20));
    gra.stroke(255, 250);
    gra.noFill();
    gra.strokeWeight(8);
    gra.rect(0, 0, w, h);
    gra.strokeWeight(4);
    gra.ellipse(w/2, h/2, w*0.2, w*0.2);
    gra.ellipse(w/2, h/2, 5, 5);
    gra.line(0, h/2, w, h/2);
    int cc = int(random(7, 17))*2;
    float tt = h*1./cc;
    gra.noStroke();
    gra.fill(255, random(20, 60));
    for (int i = 0; i < cc; i+=2) {
      gra.rect(0, i*tt, w, tt);
    }
    gra.filter(BLUR, 0.6);
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        color col = gra.get(i, j);
        float dx = abs(w/2.-i)/w/2.;
        float dy = abs(h/2.-j)/h/2.;
        float dis = max(dx, dy);
        float bri = random(-4, 6)+dis*-120;
        col = color(red(col)+bri+random(2), green(col)+bri*1.6+random(2), blue(col)+bri+random(2));
        gra.set(i, j, col);
      }
    }
    gra.endDraw();
  }

  void drawTrace(float x, float y, float a, float i) {
    gra.beginDraw();
    gra.fill(120, 50, 5, pow(i*7., 2.1)+random(-10, 10)-30);
    gra.pushMatrix();
    gra.translate(-x+w/2, -y+h/2);
    gra.rotate(a+random(-0.07, 0.07));
    gra.rectMode(CENTER);
    float l = random(6, 9);
    float anc = random(1, 4);
    gra.rect(-15, -12, l, anc);
    gra.rect(-15, 12, l, anc);
    gra.rect(15, -12, l, anc);
    gra.rect(15, 12, l, anc);
    if (random(1) < 0.7) {
      float t = random(5);
      gra.ellipse(random(-30), random(-17, 17), t, t);
    }
    gra.popMatrix();
    gra.endDraw();
  }
}


class Particle {
  boolean remove;
  int time;
  PVector position;
  void update() {
  }
  void show() {
  }
}

class SmookeParticle extends Particle {
  float col, alp;
  float angle, size, movement, velocity;
  int init;
  SmookeParticle(float x, float y, float a) {
    position = new PVector(x, y);
    angle = a;
    time = int(random(10, 40));
    size = random(3, 12);
    movement = random(0.05);
    velocity = random(0.01, 0.8);
    col = int(random(200, 255));
    alp = int(random(180, 240));
    init = 3;
  }
  void update() {
    angle += random(-movement, movement);
    position.x += cos(angle)*velocity;
    position.y += sin(angle)*velocity;
    time--;
    init--;
    alp -= random(20);
    size -= random(0.4);
    if (time < 0 || size < 0 || alp < 0) remove = true;
  }
  void show() {
    float s = size;
    if (init > 0) {
      s = map(init, 3, 0, 0, size);
    }
    fill(col, alp);
    ellipse(position.x, position.y, s, s);
  }
}

