ArrayList<Square> squares;
Square grid[][];
int click;
PFont font;

void setup() {
  size(800, 800, P3D);
  smooth(8);
  pixelDensity(2);
  rectMode(CENTER);
  font = createFont("Chivo-Black.ttf", 32, true);
  textFont(font);
  
  generate();
}

void draw() {
  background(120);
  for (int i = 0; i < squares.size(); i++) {
    Square square = squares.get(i);
    square.update();
    square.show();
  }
}

void keyPressed() {
  if (key == 'g') generate();
}

void mousePressed() {
  click++;
  for (int i = 0; i < squares.size(); i++) {
    Square square = squares.get(i);
    if (square.on) {
      square.mouseClick(click);
    }
  }
}

void generate() {
  click = 0;
  squares = new ArrayList<Square>();
  int cc = int(random(3, random(3, 13))); 
  grid = new Square[cc][cc]; 
  float sep = height/(cc+1.); 
  float ss = sep*0.9; 
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float xx = sep*(i+1); 
      float yy = sep*(j+1); 
      grid[i][j] = new Square(xx, yy, i, j, ss);
      squares.add(grid[i][j]);
    }
  }
}
