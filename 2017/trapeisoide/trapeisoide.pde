int sel = -1;
ArrayList<PVector> points;

PImage img;

void setup() {
  size(1280, 720, P2D);
  points = new ArrayList<PVector>();
  points.add(new PVector(10, 10));
  points.add(new PVector(width-10, 10));
  points.add(new PVector(width-10, height-10));
  points.add(new PVector(10, height-10));

  img = loadImage("image.jpeg");
}

void draw() {
  background(80);
  noStroke();

  beginShape(); 
  texture(img);
  vertex(0, 0, 0, 0);
  vertex(img.width, 0, img.width, 0);
  vertex(img.width, img.height, img.width, img.height);
  vertex(0, img.height, 0, img.height);
  endShape(CLOSE);

  textureMode(IMAGE);
  beginShape(); 
  texture(img);
  vertex(width*0.66, 10, points.get(0).x, points.get(0).y);
  vertex(width-10, 10, points.get(1).x, points.get(1).y);
  vertex(width-10, height*0.3, points.get(2).x, points.get(2).y);
  vertex(width*0.66, height*0.3, points.get(3).x, points.get(3).y);
  endShape(CLOSE);

  fill(200, 200, 0);
  for (int i = 0; i <points.size(); i++) {
    ellipse(points.get(i).x, points.get(i).y, 4, 4);
  }
}

void keyPressed(){
  
   if(key == 's'){
      saveFrame("export.png"); 
   }
}


void mouseDragged() {
  if (sel != -1) {
    PVector p = points.get(sel);
    p.x = mouseX;
    p.y = mouseY;
  }
}

void mousePressed() {
  for (int i =0; i < points.size(); i++) {
    if (dist(mouseX, mouseY, points.get(i).x, points.get(i).y) < 4) {
      sel = i;
      println(sel);
    }
  }
}

void mouseReleased() {
  sel = -1;
}