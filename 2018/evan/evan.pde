ArrayList<Particle> particles;
Ship ship;
PGraphics mask;
PFont font;
void setup() {
  size(720, 720, P3D);
  pixelDensity(2);

  mask = createGraphics(width, height);
  font = createFont("Chivo-Bold", 600, true);

  particles = new ArrayList<Particle>();
  
  ship = new Ship();

  background(0);
}

void draw() {

  noStroke();
  fill(getColor(frameCount*0.01), 5);
  //rect(0, 0, width, height);

  int sca = -2;
  copy(0, 0, width, height, sca, sca, width-sca*2, height-sca*2);
  //background(160);

  float time = millis()*0.001;
  //float xx = (cos(time*2.0)*0.3+0.5)*width;
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
  
  ship.update();
  ship.show();
}

void mouseMoved() {
  //particles.add(new Particle(mouseX, mouseY, 0));
}

void keyPressed() {
  /*
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
   */
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
