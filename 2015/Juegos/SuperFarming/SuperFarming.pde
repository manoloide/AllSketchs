Camera camera;
Map map;
Player player;

void setup() {
  size(800, 600);
  rectMode(CENTER);
  camera = new Camera();
  map = new Map(20, 14);
  player = new Player();
}

void draw() {
  camera.update();
  player.update();
  map.update();
  map.show();
  player.show();
}

void mousePressed(){
   player.clicked(); 
}

void mouseReleased(){
   player.released(); 
}

void keyPressed(){
   if(key == 'g') map.createMap(); 
}
