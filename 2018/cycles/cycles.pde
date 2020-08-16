void setup() {
  size(640, 640);
}

void draw() {
  background(0);
  float time = millis()/10000.;
  time = time%2;
  ellipse(cycle(time, 0.25, 0.75)*width, height*0.2, 5, 5); 
  ellipse(cycle(time, 0.75, 0.25)*width, height*0.3, 5, 5);  
  ellipse(cycle(time, 0, 0.5)*width, height*0.4, 5, 5);  
  ellipse(cycle(time, 0.5, 0.0)*width, height*0.5, 5, 5); 
  ellipse((cycle(time, -0.25, 0.25)+0.5)*width, height*0.6, 5, 5); 
  ellipse((cycle(time, 0.25, -0.25)+0.5)*width, height*0.7, 5, 5); 
  ellipse(cycle(time, 0, 1)*width, height*0.8, 5, 5);
  ellipse(cycle(time, 1, 0)*width, height*0.9, 5, 5);

  generate();
}

int seed = int(random(99999999));
void keyPressed() {
  seed = int(random(99999999));
}

void generate() {
  background(0);

  randomSeed(seed);

  float time = millis()*0.001;

  int cc = int(random(4, 120));
  float hh = height*1./cc;
  noStroke();
  for (int i = 0; i < cc; i++) {
    float vel = 30./pow(2, int(random(50)));
    float c = cycle(time*vel, 1, 0);
    if (random(1) < 0.5) c = cycle(time*-vel, 1, 0);
    float xx = c*width;
    rect(xx, i*hh, 10, hh);
  }
}

float cycle(float v, float l1, float l2) {
  if (l1 < l2) return (v-l1)%(l2-l1);
  return (v-l2)%(l1-l2);
}