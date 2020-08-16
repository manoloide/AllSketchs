int pixelSize = 2;

int gridWidth = 5;
int gridHeight = 5;
int borderGrid = 16;

int colorBall[] = {
  #FF003C, 
  #FF8A00, 
  #FABE28, 
  #88C100, 
  #00C176
};

boolean activeGrid[][];
int levelVal[][];
int ballsCount[];
int moves;
int money;

PGraphics render;

void setup() {
  size(400, 600);
  initGame();
  render = createGraphics(width/pixelSize, height/pixelSize);
}

void draw() {
  render.beginDraw();
  render.noSmooth();
  drawBackground();
  drawGrid();
  drawGui();
  render.endDraw();
  noSmooth();
  image(render, 0, 0, width, height);
}

void keyPressed() {
  if (key == 'g') createLevel();
}

void mousePressed() {
  if (moves <= 0) return;
  int w = render.width;
  int h = render.height;
  int size = min((w-borderGrid*2)/gridWidth, (h-borderGrid*2)/gridHeight);
  int dx = (w-(gridWidth*size))/2;
  int dy = (h-(gridHeight*size))/2;
  int mx = mouseX/pixelSize;
  int my = mouseY/pixelSize;

  int px = (mx-dx)/size;
  int py = (my-dy)/size; 
  if (mx < dx || my < dy || px >= gridWidth || py >= gridHeight || !activeGrid[px][py]) return; 

  moves--;
  activeGrid[px][py] = false;

  int form = levelVal[px][py];
  boolean getForm = true;
  for (int j = 0; j < gridHeight; j++) {
    for (int i = 0; i < gridWidth; i++) {
      if (levelVal[i][j] == form && activeGrid[i][j]) {
        getForm = false;
      }
    }
  }
  if (getForm) {
    ballsCount[form-1]++;
  }
}

void initGame() {
  ballsCount = new int[colorBall.length];
  createLevel();
}

void createLevel() {
  activeGrid = new boolean[gridWidth][gridHeight];
  levelVal = new int[gridWidth][gridHeight];
  moves = 10; 

  for (int j = 0; j < gridHeight; j++) {
    for (int i = 0; i < gridWidth; i++) {
      activeGrid[i][j] = true;
      levelVal[i][j] = 0;
    }
  }

  for (int i = 0; i < 3; i++) {
    int form = int(random(colorBall.length))+1;
    if (formExist(form)) continue;
    if (form == 1) {
      addFormLevel(form, 0, 0, 1, 0, 0, 1, 1, 1);
    }
    if (form == 2) {
      addFormLevel(form, 0, 0, 0, 1, 0, 2, 0, 3);
    }  
    if (form == 3) {
      addFormLevel(form, 0, 0, 1, 1, 2, 2, 3, 3);
    }
    if (form == 4) {
      addFormLevel(form, 0, 0, -1, 1, 0, 1, 1, 1);
    }
    if (form == 5) {
      addFormLevel(form, 0, 0, 1, 0, 1, 1, 2, 1);
    }
  }
}

boolean formExist(int form) {
  for (int j = 0; j < gridHeight; j++) {
    for (int i = 0; i < gridWidth; i++) {
      if (levelVal[i][j] == form) return true;
    }
  }
  return false;
}


void addFormLevel(int form, int... pos) {
  int minX = gridWidth;
  int maxX = 0;
  int minY = gridHeight;
  int maxY = 0;

  for (int i = 0; i < pos.length; i+=2) {
    minX = min(minX, pos[i]); 
    maxX = max(maxX, pos[i]);
    minY = min(minY, pos[i+1]); 
    maxY = max(maxY, pos[i+1]);
  }

  if (minX >= 0) minX = 0;
  else minX = abs(minX);

  if (minY >= 0) minY = 0;
  else minY = abs(minY);

  if (maxX < 0) maxX = gridWidth;
  else maxX = gridWidth-maxX;

  if (maxY < 0) maxY = gridHeight;
  else maxY = gridHeight-maxY;

  int xx = int(random(minX, maxX));
  int yy = int(random(minY, maxY));

  boolean add = true;
  for (int i = 0; i < pos.length; i+=2) {
    if (levelVal[xx+pos[i]][yy+pos[i+1]] > 0) {
      add = false;
      continue;
    }
  }

  if (add) {
    for (int i = 0; i < pos.length; i+=2) {
      levelVal[xx+pos[i]][yy+pos[i+1]] = form;
    }
  }
}

void drawBackground() {
  render.background(#3D4037);

  int sep = 16; 
  render.stroke(#50534b);
  /*
  for (int j = -(frameCount/3)%sep; j < render.height+sep; j+= sep) {
   for (int i = -(frameCount/3)%sep; i < render.width+sep; i+= sep) {
   render.line(i-2, j, i+2, j);
   render.line(i, j-2, i, j+2);
   }
   }*/
  render.strokeWeight(4);

  for (int i = - (frameCount/4)%sep; i < render.width+render.height; i+= sep) {
    render.line(-2, i, i, -2);
  }
  render.strokeWeight(1);
}

void drawGrid() {
  int w = render.width;
  int h = render.height;
  int size = min((w-borderGrid*2)/gridWidth, (h-borderGrid*2)/gridHeight);
  int dx = (w-(gridWidth*size))/2;
  int dy = (h-(gridHeight*size))/2;
  for (int j = 0; j < gridHeight; j++) {
    for (int i = 0; i < gridWidth; i++) {
      render.stroke(0);
      render.fill(240);//, 100);
      if (activeGrid[i][j]) {
        render.rect(i*size+dx, j*size+dy, size, size, size*0.2);
      } else 
        if (levelVal[i][j] > 0) {
        //render.stroke(bri(colorBall[levelVal[i][j]], -180));
        render.fill(colorBall[levelVal[i][j]-1]);
        render.ellipse((i+0.5)*size+dx, (j+0.5)*size+dy, size*0.6, size*0.6);
        render.noStroke();
        render.fill(bri(colorBall[levelVal[i][j]-1], 24));
        render.ellipse((i+0.5)*size+dx+size*0.1, (j+0.5)*size+dy-size*0.1, size*0.2, size*0.2);
      }
    }
  }
  render.text(moves, 20, 20);
}

void drawGui() {
  for (int i = 0; i < ballsCount.length; i++) {
    render.fill(250);
    render.text(ballsCount[i], 20+i*32, 60);
  }
}


color bri(int col, float val) {
  return color(red(col)+val, green(col)+val, blue(col)+val, alpha(col));
}
