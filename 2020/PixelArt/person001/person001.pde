void setup() {
  size(960, 540);
  noSmooth();
  generate();
}

void draw() {
}

void keyPressed() { 
  generate();
}

void generate() {

  int tileSize = 32;  
  noStroke();
  for (int j = 0; j <= height/2/tileSize; j++) {
    for (int i = 0; i < width/2/tileSize; i++) {
      int x = i*tileSize;
      int y = j*tileSize;
      fill(30+((i+j)%2)*20);
      rect(x, y, tileSize, tileSize);

      human(x+tileSize*0.5, y+tileSize*0.5, tileSize*0.8);
    }
  }




  PImage copy = get(0, 0, width/2, height/2);
  image(copy, 0, 0, width, height);
}

void human(float x, float y, float s) {
  noStroke();
  fill(rcol());
  ellipse(x, y, s*0.22, s*0.4);

  fill(rcol());
  arc(x, y+s*0.1, s*0.24, s*0.62, PI, TAU);

  strokeWeight(2);
  stroke(rcol());
  float cx, cy, a, d;
  cx = x-s*0.1;
  cy = y-s*0.2;
  a = random(TAU);
  d = s*0.25;
  line(cx, cy, cx+cos(a)*d, cy+sin(a)*d);

  cx = x+s*0.1;
  cy = y-s*0.2;
  a = random(TAU);
  d = s*0.25;
  line(cx, cy, cx+cos(a)*d, cy+sin(a)*d);


  cx = x-s*0.1;
  cy = y+s*0.18;
  a = HALF_PI;
  d = s*0.3;
  line(cx, cy, cx+cos(a)*d, cy+sin(a)*d);
  cx = x+s*0.1;
  cy = y+s*0.18;
  a = HALF_PI;
  d = s*0.3;
  line(cx, cy, cx+cos(a)*d, cy+sin(a)*d);

  noStroke();

  //head
  fill(rcol());
  ellipse(x, y-s*0.4, s*0.28, s*0.28);
}



int colors[] = {#A06CA9, #A86679, #63A6A0, #8093D3, #193FD4};
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
  return lerpColor(c1, c2, pow(v%1, 0.6));
} 
