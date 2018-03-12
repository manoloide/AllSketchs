int palette[] = {
  #FCFCFF, 
  #E2E2E2, 
  #373846, 
  #FF655F, 
  #3CDEB4, 
  #2ED148
};

ArrayList<Field> fields;
Plant selection;

int tileSize = 10;
int menuHeight = 100;

void setup() {
  size(800, 600);

  fields = new ArrayList<Field>();
  int ss = tileSize;
  int bb = ss*2;
  int tt = ss*9;
  int cw = width/(bb+tt); 
  int ch = (height-menuHeight)/(bb+tt);
  float dx = (width-(tt+bb)*(cw-1))/2;
  float dy = ((height-menuHeight)-(tt+bb)*(ch-1))/2;
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      fields.add(new Field(dx+i*(bb+tt), dy+j*(bb+tt), tt));
    }
  }
}

void draw() {
  background(palette[1]);
  /*
  rectMode(CENTER);
   noStroke();
   fill(0, 18);
   int ss = tileSize;
   for (int j = (height%ss)/2+ss/2; j < height; j+=ss) {
   for (int i = (width%ss)/2+ss/2; i < width; i+=ss) {
   rect(i, j, 2, 2);
   }
   }
   */

  for (int i = 0; i < fields.size (); i++) {
    Field f = fields.get(i);
    f.update();
  }

  drawInterface();
}

void mousePressed() {
  if (mouseY < height-menuHeight) {
    if (selection != null) {
      for (int i = 0; i < fields.size (); i++) {
        Field f = fields.get(i);
        if(f.plant == null && mouseX > f.x-f.s/2 && mouseX < f.x+f.s/2 && mouseY > f.y-f.s/2 && mouseY < f.y+f.s/2){
          f.plant = selection; 
          selection = null;
        }
      }
    }
  } else { 
    selection = null;
    int v = (mouseX-(width-menuHeight*4))/menuHeight;
    if (v >= 1) {
      v--;
      selection = new Plant(v);
    }
  }
}

void drawInterface() {
  float xx = 0;
  float yy = height-menuHeight; 
  float ww = width;
  float hh = menuHeight;
  rectMode(CORNER);
  fill(palette[2]);
  rect(xx, yy, ww, hh);
  fill(0, 60);
  rect(xx+tileSize/2, yy+tileSize/2, tileSize*9, hh-tileSize, 5);

  rectMode(CENTER);
  for (int i = 0; i < 3; i++) {
    fill(0, 60);
    float x = xx+ww-hh*2.5+i*hh-tileSize;
    float y = yy+hh/2;
    rect(x, y, hh-tileSize*2, hh-tileSize*2, 5);
    ellipse(x, y, hh-tileSize*4, hh-tileSize*4); 
    fill(palette[3+i]);
    ellipse(x, y, hh-tileSize*6, hh-tileSize*6); 
    fill(palette[0], 60);
    ellipse(x+tileSize*0.7, y-tileSize*0.7, tileSize, tileSize);
  }

  if (selection != null) {
    float x = mouseX;
    float y = mouseY;
    stroke(0, 10);
    fill(selection.col);
    ellipse(x, y, hh-tileSize*6, hh-tileSize*6); 
    noStroke();
    fill(palette[0], 60);
    ellipse(x+tileSize*0.7, y-tileSize*0.7, tileSize, tileSize);
  }
}

