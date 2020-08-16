ArrayList<Cell> cells;
Global global;
ArrayList<Player> players;
PFont font;

void setup() {
  size(960, 540, P3D);
  pixelDensity(2);
  smooth(4);
  
  font = createFont("fonts/Chivo-Black.ttf", 60, true);
  textFont(font);
  
  global = new Global();
  players = new ArrayList<Player>();
  players.add(new Player(#5523c1));
  players.add(new Player(#F29A16));
  generate();
}

void draw() {

  global.update();
  background(140);

  for (int i = 0; i < cells.size(); i++) {
    Cell c = cells.get(i);
    c.update();
    c.show();
  }

  noStroke();
  for (int i = 0; i <players.size(); i++) {
    Player p = players.get(i);
    fill(p.col);
    ellipse((1+i)*15, 15, 10, 10);
  }
}

void generate() {

  cells = new ArrayList<Cell>();
  int cc = int(random(2, random(2, 8000)));
  for (int i = 0; i < cc; i++) {
    float ss = width*random(0.08, 0.24);
    float xx = ss*0.5+(width-ss*1.0)*lerp(0.5, random(0.1, 0.9), random(1));
    float yy = ss*0.5+(height-ss*1.0)*lerp(0.5, random(0.1, 0.9), random(1));
    boolean add = true;
    for (int j = 0; j < cells.size(); j++) {
      Cell c = cells.get(j);
      if (dist(xx, yy, c.x, c.y) < (ss+c.s)*0.55) {
        add = false;
        break;
      }
    }
    if (add) cells.add(new Cell(xx, yy, ss));
  }
}

void keyPressed() {
  if (key == 'g') generate();
}

void mousePressed() {
  for (int i = 0; i < cells.size(); i++) {
    Cell c = cells.get(i);
    c.click(mouseX, mouseY);
  }
}
