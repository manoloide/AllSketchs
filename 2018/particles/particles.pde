ArrayList<Particle> particles;
PGraphics mask;
PFont font;
void setup() {
  size(720, 720, P3D);
  pixelDensity(2);

  mask = createGraphics(width, height);
  font = createFont("Chivo-Bold", 600, true);

  particles = new ArrayList<Particle>();

  background(0);
}

void draw() {

  noStroke();
  fill(getColor(frameCount*0.01), 50);
  rect(0, 0, width, height);

  int sca = -2;
  copy(0, 0, width, height, sca, sca, width-sca*2, height-sca*2);
  //background(160);

  float time = millis()*0.001;
  float xx = (cos(time*2.0)*0.3+0.5)*width;
  //particles.add(new Particle(xx, -80, 0));

  particles.add(new Particle(random(width), -80, 0));
  //particles.add(new Particle(random(width), -80, 0));
  //particles.add(new Particle(random(width), -80, 0));
  //particles.add(new Particle(random(width), -80, 0));

  lights();
  noStroke();

  for (int i = 0; i < particles.size(); i++) {
    Particle p = particles.get(i);
    p.update();
    p.show();

    if (p.remove) particles.remove(i--);
  }
}

void mouseMoved() {
  //particles.add(new Particle(mouseX, mouseY, 0));
}

void keyPressed() {
  mask.beginDraw();
  mask.background(0);
  mask.fill(255);
  mask.textFont(font);
  mask.textAlign(CENTER, CENTER);
  mask.text(str(key), width*0.5, height*0.35);
  mask.endDraw();

  for (int i = 0; i < 10000; i++) {
    float x = random(width); 
    float y = random(height);

    if (brightness(mask.get(int(x), int(y))) > 200) {
      particles.add(new Particle(x, y, 0));
    }
  }
}

class Particle {
  boolean remove, on;
  float x, y, z;
  float s;
  float ax, ay, az;
  float vs, vrx, vry, vrz;
  float time = 0;
  PVector force;
  float ic, dc;
  final float gravity = 0.09;
  Particle(float x, float y, float z) {
    this.x = x; 
    this.y = y;
    this.z = z;
    s = random(50, 80);

    ax = random(TWO_PI);
    ay = random(TWO_PI);
    az = random(TWO_PI);
    float vr = 0.1;
    vrx = random(-vr, vr);
    vry = random(-vr, vr);
    vrz = random(-vr, vr);

    force = new PVector();

    ic = random(colors.length);
    float dc = random(0.1)*random(1);

    vs = random(0.98, 0.99);
  }

  void update() {

    time += 1./60;

    force.x *= 0.9;
    force.y += gravity;
    x += force.x;
    y += force.y;

    ax += vrx;
    ay += vry;
    az += vrz;

    s *= vs;

    float ms = 200;
    on = false;
    if (mouseX > x-ms && mouseX < x+ms && mouseY > y-ms && mouseY < y+ms) {
      on = true;

      float max = 150;
      float dis = dist(mouseX, mouseY, x, y);
      float ang = atan2(y-mouseY, x-mouseX);
      float vel = 0; 
      if (dis < max) {
        vel = 1.-pow(dis/max, 0.6);
        vel *= 1.0;
        force.add(new PVector(cos(ang)*vel, sin(ang)*vel));

        if (dis < s && time > 1) {
          remove = true;
          for (int i = 0; i < 30; i++) {
            Particle aux = new Particle(x, y, 0);
            float dd = random(50);
            float aa = random(TWO_PI);
            aux.force = new PVector(cos(aa)*dd, sin(aa)*dd);
            particles.add(aux);
          }
        }
      }
    }


    if (s < 0.5) remove = true;
  }

  void show() {
    fill(255);
    //if (on) fill(255, 0, 0);
    pushMatrix();
    translate(x, y, z);
    rotateX(ax);
    rotateY(ay);
    rotateZ(az);
    float ss = s;
    if (time < 1) ss *= time;
    //fill(getColor(ic+dc*time));
    fill(getColor(frameCount*0.01+2.5));
    fill(255);
    box(ss);
    popMatrix();
  }
}

int colors[] = {#B14027, #476086, #659173, #9293A2, #262A2C, #D38644};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}
