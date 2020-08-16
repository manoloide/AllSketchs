// añadir flores
// añadir pajaros
// añadir superMeat walls
// añadir particulas
// add coins animation ui
// añadir inventario a lo terraria
// añadir vida a los tiles


int tileSize = 40;

Input input;
Global global;
Map map;
Player player;
Stats stats;

PFont regular, bold;

void setup() {
  size(800, 800, P2D); 

  regular = createFont("fonts/Archivo-Regular.ttf", 20, true);
  bold = createFont("fonts/Archivo-Bold.ttf", 20, true);

  input = new Input();
  global = new Global();
  stats = new Stats();
  player = new Player();
  map = new Map();
}

void draw() {

  input.update();
  global.update();
  stats.update();

  background(220); 

  map.show();

  for (int i = 0; i < objects.size(); i++) {
    Object obj = objects.get(i);
    obj.update();
    obj.show();
    if (obj.remove) {
      objects.remove(i--);
    }
  }

  player.update();
  player.show();

  water();

  ui();
}

void ui() {

  rectMode(CORNER);
  stroke(255, 40);
  int mx = mouseX;
  int my = mouseY;
  mx -= mx%tileSize;
  my -= my%tileSize;
  noFill();
  strokeWeight(2);
  rect(mx, my, tileSize, tileSize);
  strokeWeight(1);

  noStroke();
  rectMode(CENTER);
  for (int i = 0; i < colors.length; i++) {
    fill(colors[i]);
    rect((i*0.5+0.5)*tileSize, tileSize*0.5, tileSize*0.4, tileSize*0.4);
  }

  /*
  rectMode(CORNER);
   for (int i = 0; i < 10; i++) {
   float ww = tileSize*0.4*6;
   float noi = noise(i*0.01+global.time, i);
   fill(0, 80);
   rect(0.3*tileSize, tileSize*(0.8+i*0.2), ww*noi, tileSize*0.1);
   fill(255, 80);
   rect(0.3*tileSize+ww*noi, tileSize*(0.8+i*0.2), ww*(1-noi), tileSize*0.1);
   }
   */

  for (int i = 0; i < stats.coins; i++) {

    float osc = (1+cos(global.time+i)*0.1)*0.3;
    float rot = abs(cos(global.time*3+i));

    fill(getColor(i*0.5-global.time*3));
    ellipse(width-tileSize*0.5, tileSize*(0.5+i*0.5), tileSize*(0.5*rot+0.2)*osc, tileSize*osc);
  }


  textAlign(LEFT, TOP);
  textFont(regular);
  textSize(18);
  fill(255);
  text("Level: "+nf(stats.level, 4), tileSize*0.25+2, tileSize);
  text("Coins: "+nf(stats.coins, 4), tileSize*0.25+2, tileSize*1.5);
  //text("FPS: "+nf(int(frameRate), 2), tileSize*0.25, tileSize*1.5);
}

void dead() {
  stats.level = 1;
  stats.coins -= 5;
  if (stats.coins < 0) stats.coins = 0;
  generate();
}

void nextLevel() {
  stats.level += 1;
  stats.coins += 5;
  generate();
}

void generate() {
  map.create();
}

void keyPressed() {

  input.pressed();

  if (key == 'g') 
    generate();
}

void keyReleased() {

  input.released();
}

void mousePressed() {
  map.click(mouseX, mouseY);
}
