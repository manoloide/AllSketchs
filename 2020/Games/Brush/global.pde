class Global {
  
  public float delta, time;
  private long timePrev, timeAct, timeInit;
  Global() {
    timeAct = timePrev = 0;
    timeInit = System.currentTimeMillis();
  }

  void update() {
    timeAct = System.currentTimeMillis() - timeInit;
    delta = (timeAct - timePrev) / 1000.0f;
    timePrev = timeAct;
    time = timeAct*0.001;
  }
}

int colors[] = {#FC3FF8, #378DF1, #5AA604, #FCCD06, #FD3C02};
int rcol() {
  return colors[int(random(colors.length))];
}


int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v); 
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}
