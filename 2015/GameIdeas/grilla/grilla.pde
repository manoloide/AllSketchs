int c = 5;
int tiles[][];
float tt, dx, dy;

int pallete[] = {
  #E6E6E6, 
  #FF2E3C, 
  #FFCF2E, 
  #2E5DFF
};

void setup() {
  size(600, 600);
  tiles = new int[c][c];
  tt = width/(c+1);
  dx = (width-(tt*c))/2.;
  dy = (height-(tt*c))/2;
}

void draw() {
  background(160);
  stroke(0, 30);
  for (int j = 0; j < c; j++) {
    for (int i = 0; i < c; i++) {
      fill(pallete[tiles[i][j]]);
      rect(dx+i*tt, dy+j*tt, tt, tt);
    }
  }
}


void mousePressed() {
  int px = int((mouseX-dx)/tt);
  int py = int((mouseY-dy)/tt);

  tiles[px][py]++;
  tiles[px][py] %= 4;
}

