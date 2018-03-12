import processing.video.*;
Movie mov;

ArrayList<Particle> particles;

int colors[] = {#1E2E5D, #EDB629, #FFE51A, #FAFAFA};
PImage img;

void setup() {
  size(1350, 1080);
  background(0);

  mov = new Movie(this, "video.mov");  

  mov.play();
  //img = loadImage("https://scontent.fgig1-4.fna.fbcdn.net/v/t1.0-9/1936962_726134317523409_8335053481866602480_n.jpg?oh=33969c3eb3f942377813435e5ab6aba0&oe=5892938A");
  generate();
}

void draw() {

  if (mov.available() == true) {
    mov.read();
  }

  //image(mov, 0, 0);


  for (int i = 0; i < particles.size(); i++) {
    Particle p = particles.get(i);
    p.update();
  }
}

void keyPressed() {
  generate();
}

void generate() {

  particles = new ArrayList<Particle>();
  for (int i = 0; i < 2000; i++) {
    particles.add(new Particle());
  }
}

class Particle {
  int size[] = {2, 2, 5, 5, 10, 20};
  float x, y, s;
  float c, vc;
  Particle() {
    s = size[int(random(size.length)*random(0.5, 1))];
    x = random(width);
    x -= x%s;
    y = random(height);
    y -= y%s;

    c = random(colors.length);
    vc = random(0.05);
  }

  void update() {
    if (random(1) < 0.5) {
      if (random(1) < 0.5) {
        x -= s;
      } else {
        x += s;
      }
    } else {
      if (random(1) < 0.5) {
        y -= s;
      } else {
        y += s;
      }
    }

    c += vc;
    show();
  }

  void show() {
    stroke(0, 20);
    //fill(getColor(c));
    int xx = constrain(int(x+s*0.5), 0, mov.width*3-1);
    int yy = constrain(int(y+s*0.5), 0, mov.height*3-1);
    fill(mov.get(xx/3, yy/3));
    rect(x, y, s, s);
  }
}

int getColor(float v) {
  v = v%(colors.length);

  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  float m = v%1;

  return lerpColor(c1, c2, m);
}