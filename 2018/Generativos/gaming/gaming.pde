ArrayList<Aro> aros;
int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  aros = new ArrayList<Aro>();
}

float vy = 0;
float xx = 0; 
float yy = 0;

float cx = 0;
float cy = 0;

void draw() {

  cx = lerp(cx, xx, 0.2);
  cy = lerp(cy, yy, 0.2);
  translate(-cx, -cy);

  fill(0, 20);
  rect(0, 0, width, height);

  vy -= 0.7;
  vy = constrain(vy, -100, 100);
  yy -= vy;

  if (left) {
    float dx = map(constrain(vy, 0, 40), 0, 40, 0, 10);
    xx -= dx;
  }
  if (right) {
    float dx = map(constrain(vy, 0, 40), 0, 40, 0, 10);
    xx += dx;
  }

  translate(width*0.5, height*0.5);
  float ss = 50+cos(vy*0.2)*20;
  stroke(0, 20);
  fill(getColor(frameCount*0.05));
  ellipse(xx, yy, ss, ss);

  for (int j = 0; j < aros.size(); j++) {
    Aro a = aros.get(j);
    a.update();
    a.show();
    if (a.remove) aros.remove(j--);
  }
}   

boolean left = false, right = false;

void keyPressed() {

  if (key == 'a') left = true;
  if (key == 'd') right = true;
  if (key == ' ') {
    vy += 20;
    aros.add(new Aro(xx, yy));
  }

  if (key == 's') saveImage();
  if (key == 'g') {
    seed = int(random(999999));
  }
}

void keyReleased() {
  if (key == 'a') left = false;
  if (key == 'd') right = false;
}

class Aro {
  boolean remove;
  float x, y, time, life; 
  Aro(float x, float y) {
    this.x = x; 
    this.y = y;
    time = 0;

    life = random(4, 8);
  }
  void update() {
    time += 1./60;
    if (time > life) {
      println("remove");
      remove = true;
    }
  }
  void show() {
    float ss = 180;
    float s = map(pow((time+cos(time))/life, 1.2), 0, 1, 4, ss);
    fill(getColor(s));
    for (int i = -5; i <= 5; i++) {
      aro(x+i*ss, y, s, s*0.1);
    }
  }
}

void aro(float x, float y, float s, float b) {
  int seg = int(s*PI*0.5);
  float da = TWO_PI/seg;
  float r = s*0.5;
  beginShape();
  for (int i = 0; i <= seg; i++) {
    float a = da*i;
    vertex(x+cos(a)*r, y+sin(a)*r);
  }
  for (int i = seg; i >= 0; i--) {
    float a = da*i;
    vertex(x+cos(a)*(r-b), y+sin(a)*(r-b));
  }
  endShape();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}
int colors[] = {#FFFCF7, #FDDA02, #EE78AC, #3155A3, #028B88};
//int colors[] = {#01AFD8, #009A91, #E46952, #784391, #1B2D53};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}