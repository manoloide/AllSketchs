PVector camera, mouse, cursor;

float deltaTime, nowTime, lastTime;

Player player;

void setup() {
  size(720, 720, P3D);
  smooth(8);
  pixelDensity(2);

  noCursor();

  camera = new PVector();
  mouse = new PVector(); 
  cursor = new PVector(); 

  lastTime = millis();

  player = new Player();
}

void draw() {

  nowTime = millis()*0.001;
  deltaTime = nowTime-lastTime;
  lastTime = nowTime;

  background(230);

  translate(width*0.5, height*0.5);
  translate(camera.x, camera.y);
  
  camera.x = lerp(camera.x, -player.position.x, 0.1);
  camera.y = lerp(camera.y, -player.position.y, 0.1);

  inifityGrid();

  player.update();
  player.show();

  drawCursor();
}

void drawCursor() {

  if (mousePressed) mouse.z = lerp(mouse.z, 10, 0.2);
  else mouse.z = lerp(mouse.z, 5, 0.2);
 

  noStroke();
  fill(80, 200);
  ellipse(mouse.x, mouse.y, mouse.z, mouse.z);
  float size = mouse.z*1.8+cos(nowTime*0.17)*sin(nowTime*2.1)*mouse.z*0.8;
  size *= 1.4;
  noFill();
  stroke(80, 200);
  ellipse(mouse.x, mouse.y, size, size);

  if (mousePressed) {
    cursor = getCursor();

    float dist = mouse.dist(cursor);  
    float modDist = pow(constrain(dist/(size*1.2), 0.5, 1), 0.8);

    noStroke();
    fill(80, 200);
    ellipse(cursor.x, cursor.y, cursor.z*modDist, cursor.z*modDist);

    noFill();
    stroke(80, 200);
    ellipse(cursor.x, cursor.y, size*modDist, size*modDist);

    if (dist > size*0.5*modDist+size*0.5) {
      float angle = atan2(mouse.y-cursor.y, mouse.x-cursor.x);
      float des1 = size*modDist*0.5;
      float des2 = dist-size*0.5;
      line(cursor.x+cos(angle)*des1, cursor.y+sin(angle)*des1, cursor.x+cos(angle)*des2, cursor.y+sin(angle)*des2);
    }
  }
}

void mousePressed() {
  mouse = getCursor();
}

void mouseMoved() {
  mouse = getCursor();
}

PVector getCursor() {
  return new PVector(mouseX-width*0.5, mouseY-height*0.5, mouse.z);
}

void inifityGrid() {
  int sizeGrid = 100;
  stroke(210);

  for (int i = int(camera.x)%sizeGrid; i < width; i+=sizeGrid) {
    line(i, 0, i, height);
  }

  for (int i = int(camera.y)%sizeGrid; i < height; i+=sizeGrid) {
    line(0, i, width, i);
  }
}
