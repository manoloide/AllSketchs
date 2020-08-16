class Cell {
  boolean on;
  int values = 0;
  float x, y, s;
  float velOsc;
  float timeSpawn;
  Player player;
  Cell(float x, float y, float s) {
    this.x = x; 
    this.y = y; 
    this.s = s;
    velOsc = random(0.6, 1.4);
    values = int(random(30));
  }
  void update() {
    on = dist(x, y, mouseX, mouseY) < s*0.5;

    if (player != null) {
      timeSpawn -= global.delta;
      if (timeSpawn < 0) {
        values++;
        timeSpawn += 2;
      }
    }
  }

  void show() {
    float osc = 1+cos(global.time*2*velOsc)*0.02;
    float ss = s*osc;
    noStroke();
    fill(110);
    if (player != null) fill(player.col);
    ellipse(x, y+ss*0.02, ss, ss);
    if (on) {
      fill(255, 10);
      ellipse(x, y+ss*0.02, ss, ss);
    }
    textAlign(CENTER, CENTER);
    textSize(ss*0.2);
    fill(250, 150);
    text(values, x, y);
  }

  void click(float x, float y) {
    if (on) {
      player = players.get(int(random(2)));
    }
  }
}
