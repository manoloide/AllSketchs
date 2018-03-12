void setup() {
  size(600, 600);
  background(255);
  colorMode(HSB);
}

void draw() {
  for (int i = 0; i < 100; i++) {
    coso(width/2, height/2, 100, random(1), 87, 180);
  }
}

void coso(float cx, float cy, float anc, float pos, int cant, float anc2) {
  float ang = pos*TWO_PI;
  float nang = map(pos, 0, 1, 0, TWO_PI*cant);
  float x = cx+cos(ang)*anc+cos(nang)*anc2;
  float y = cy+sin(ang)*anc+sin(nang)*anc2;
  float dis = dist(x, y, cx, cy);
  noStroke();
  fill(0+cos(ang)*80+sin(ang)*20, map(dis, 40, 280, 180, 255), map(dis, 40, 280, 200, 80));
  ;
  ellipse(x, y, 1, 1);
}

void mousePressed(){
   saveFrame("as####.png"); 
}
