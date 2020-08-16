void setup() {
  size(1280, 640, P2D);
}

void draw() {

  background(map(cos(frameCount*0.1), -1, 1, 0, 255));

  float ang = map(cos(frameCount*0.0071), -1, 1, 0, TWO_PI);
  float ddd = height*0.38;
  ArrayList<PVector> vert = new ArrayList<PVector>();
  for (int i = 0; i < 4; i++) {
    vert.add(new PVector(width*0.5+cos(HALF_PI*i+ang)*ddd, height*0.5+sin(HALF_PI*i+ang)*ddd));
  }
  noStroke();
  /*
  beginShape();
   for (int k = 0; k < vert.size(); k++) {
   vertex(vert.get(k).x, vert.get(k).y);
   }
   endShape(CLOSE);
   */


  float w = map(cos(frameCount*0.2), -1, 1, 0.2, 0.8);//random(0.2, 0.8); 
  float h = map(cos(frameCount*0.02), -1, 1, 0.2, 0.8);//random(0.2, 0.8); 

  float cx = lerp(lerp(vert.get(0).x, vert.get(1).x, w), lerp(vert.get(3).x, vert.get(2).x, w), h);
  float cy = lerp(lerp(vert.get(0).y, vert.get(3).y, h), lerp(vert.get(1).y, vert.get(2).y, h), w);

  for (int i = 0; i < 4; i++) {
    PVector p1 = vert.get(i);
    PVector p2 = vert.get((i+1)%vert.size());
    beginShape();
    fill(map(cos(frameCount*0.097), -1, 1, 0, 255));
    vertex(p1.x, p1.y);
    vertex(p2.x, p2.y);
    fill(map(cos(frameCount*0.07), -1, 1, 0, 255));
    vertex(cx, cy);
    endShape(CLOSE);
  }

  /*
  fill(255);
   ellipse(cx, cy, 3, 3);
   */
}