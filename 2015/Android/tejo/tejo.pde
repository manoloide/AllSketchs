boolean viewEditor = true;
int tileSize = 90;

ArrayList<Tejo> tejos;
Editor editor;
Tejo select;
PImage tilesImages[];

void setup() {    size(800, 600);
  if (viewEditor) {
    size(800, 600);
    editor = new Editor();
  }
  createTiles();
  tejos = new ArrayList<Tejo>();
}

void draw() {
  background(200);

  if (viewEditor) {
    editor.update();
  }

  for (int i = 0; i < tejos.size(); i++) {
    Tejo t = tejos.get(i);
    t.update();
  }
}

void mousePressed() {
  if (viewEditor) return;
  select = new Tejo(mouseX, mouseY);
  tejos.add(select);
}

void mouseDragged() {
  if (viewEditor) return;
  select.add(new PVector(mouseX, mouseY));
}

void mouseReleased() {
  if (viewEditor) return;
  select.calculation();
  select = null;
} 

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  editor.tileSelect += int(e);
  editor.scrollTime += e;
}


class Tejo {
  ArrayList<PVector> points;
  float x, y, velocity;
  PVector direction;
  Tejo(float x, float y) {
    this.x = x; 
    this.y = y;
    points = new ArrayList<PVector>();
    direction = new PVector(0, 0);
  }
  void update() {
    x += direction.x*velocity;
    y += direction.y*velocity;
    velocity *= 0.98;
    show();
  }
  void show() {
    stroke(255, 0, 0);
    strokeWeight(3);
    fill(255, 240, 240);
    ellipse(x, y, 50, 50);
  }
  void add(PVector np) {
    points.add(np);
  }
  void calculation() {
    direction = new PVector(0, 0);
    for (int i = 1; i < points.size(); i++) {
      PVector ant = new PVector(points.get(i-1).x, points.get(i-1).y);
      PVector act = new PVector(points.get(i).x, points.get(i).y);
      act.sub(ant);
      direction.add(act);
    }
    velocity = direction.mag()/10;
    direction.normalize();
  }
}

void createTiles() {
  float unity = tileSize/10.;
  tilesImages = new PImage[4];
  PGraphics gra = createGraphics(tileSize, tileSize);
  gra.beginDraw();
  gra.background(#292329);
  gra.stroke(0, 25);
  gra.strokeWeight(tileSize/8);
  for (int i = 0; i < 7; i++) {
    gra.line(-2, i*tileSize/3, i*tileSize/3, -2);
  }
  gra.endDraw();
  tilesImages[0] = gra.get();
  gra.noStroke();
  gra.beginDraw();
  gra.background(#807E7E);
  gra.fill(0, 25);
  gra.beginShape();
  gra.vertex(unity*0, unity*0);
  gra.vertex(unity*0, unity*10);
  gra.vertex(unity*1, unity*9);
  gra.vertex(unity*1, unity*1);
  gra.endShape();
  gra.beginShape();
  gra.vertex(unity*7, unity*3);
  gra.vertex(unity*6, unity*4);
  gra.vertex(unity*6, unity*6);
  gra.vertex(unity*7, unity*7);
  gra.endShape();
  gra.fill(0, 51);
  gra.beginShape();
  gra.vertex(unity*0, unity*10);
  gra.vertex(unity*10, unity*10);
  gra.vertex(unity*9, unity*9);
  gra.vertex(unity*1, unity*9);
  gra.endShape();
  gra.beginShape();
  gra.vertex(unity*3, unity*3);
  gra.vertex(unity*4, unity*4);
  gra.vertex(unity*6, unity*4);
  gra.vertex(unity*7, unity*3);
  gra.endShape();

  gra.fill(255, 25);
  gra.beginShape();
  gra.vertex(unity*10, unity*0);
  gra.vertex(unity*10, unity*10);
  gra.vertex(unity*9, unity*9);
  gra.vertex(unity*9, unity*1);
  gra.endShape();
  gra.beginShape();
  gra.vertex(unity*3, unity*3);
  gra.vertex(unity*4, unity*4);
  gra.vertex(unity*4, unity*6);
  gra.vertex(unity*3, unity*7);
  gra.endShape();

  gra.fill(255, 51);
  gra.beginShape();
  gra.vertex(unity*0, unity*0);
  gra.vertex(unity*10, unity*0);
  gra.vertex(unity*9, unity*1);
  gra.vertex(unity*1, unity*1);
  gra.endShape();
  gra.beginShape();
  gra.vertex(unity*3, unity*7);
  gra.vertex(unity*4, unity*6);
  gra.vertex(unity*6, unity*6);
  gra.vertex(unity*7, unity*7);
  gra.endShape();
  gra.endDraw();
  tilesImages[1] = gra.get();

  gra.beginDraw();
  gra.background(#412713);
  gra.noStroke();
  gra.rectMode(CENTER);
  for (int i = 1; i < 5; i++) {
    if (i%2==0) {
      gra.fill(#412713);
    } else {
      gra.fill(#FF8013);
    }
    gra.rect(tileSize/2, tileSize/2, tileSize-unity*i*2, tileSize-unity*i*2);
  }
  gra.fill(0, 25);
  gra.beginShape();
  gra.vertex(0, 0);
  gra.vertex(0, tileSize);
  gra.vertex(tileSize, tileSize);
  gra.endShape();
  gra.beginShape();
  gra.vertex(tileSize, 0);
  gra.vertex(0, tileSize);
  gra.vertex(tileSize, tileSize);
  gra.endShape();
  tilesImages[2] = gra.get();

  gra.beginDraw();
  gra.background(#232323);
  gra.noStroke();
  gra.fill(#00EA35);
  for (int i = 0; i < 6; i++) {
    float y = i*unity*2;
    gra.beginShape();
    gra.vertex(0, y);
    gra.vertex(0, y+unity);
    gra.vertex(tileSize/2, y-unity);
    gra.vertex(tileSize, y+unity);
    gra.vertex(tileSize, y);
    gra.vertex(tileSize/2, y-unity*2);
    gra.endShape();
  }
  gra.fill(0, 25);
  gra.rect(tileSize/4., tileSize/2., tileSize/2., tileSize);
  gra.endDraw();
  tilesImages[3] = gra.get();
}
