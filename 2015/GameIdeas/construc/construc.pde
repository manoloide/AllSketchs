//ArrayList<Wall> walls; 
ArrayList<Room> rooms;
int sizeTile = 16;

Room editingRoom = null;

void setup() {
  size(800, 600);
  rooms = new ArrayList<Room>();
}

void draw() {
  background(40);
  noStroke();
  fill(60);
  rectMode(CENTER);
  for (int j = 0; j < height; j+=sizeTile) {
    for (int i = 0; i < width; i+=sizeTile) {
      rect(i, j, 2, 2);
    }
  }
  if (editingRoom != null) {
    editingRoom.x1 = mouseX-(mouseX%sizeTile);
    editingRoom.y1 = mouseY-(mouseY%sizeTile);
  }
  for (int i = 0; i < rooms.size (); i++) {
    Room r = rooms.get(i);
    r.update();
  }
}

void mousePressed() {
  if (editingRoom == null) {
    editingRoom = new Room();
    rooms.add(editingRoom);
  }
}

void mouseReleased() {
  editingRoom = null;
}

class Room {
  float x0, y0, x1, y1; 
  Room() {
    x0 = x1 = mouseX-(mouseX%sizeTile); 
    y0 = y1 = mouseY-(mouseY%sizeTile);
  }
  Room(float x0, float y0, float x1, float y1) {
    this.x0 = x0; 
    this.y0 = y0;
    this.x1 = x1; 
    this.y1 = y1;
  }
  void update() {
    show();
  }
  void show() {
    strokeWeight(2); 
    stroke(#2775F0, 200);
    fill(#3049D1, 80);
    rectMode(CORNERS);
    rect(x0, y0, x1, y1);
  }
}

