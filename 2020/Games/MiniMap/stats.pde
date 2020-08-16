class Stats {
  int coins, level;
  float water;
  Stats() {
    level = 1;
    coins = 10;
    water = 0;
  }

  void update() {
    water += global.delta*4;
  }
}
