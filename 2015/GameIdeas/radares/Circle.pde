class Circle {
  float x, y;
  Circle(float x, float y) {
    this.x = x; 
    this.y = y;
  }
 
  void update() {
    show();
  }
 
  void show() {
    noStroke();
    fill(0, 100);
    float lfo1 = cos(frameCount*0.1)*2;
    ellipse(x, y, 20+lfo1, 20+lfo1);
    fill(80);
    ellipse(x, y, 16, 16);
    noFill();
    stroke(80);
    strokeWeight(2);
    float lfo2 = cos(frameCount*0.05)*3;
    circlePoint(x, y, 100+lfo2, 20);
  }
  
  void circlePoint(float x, float y, float d, int c){
   float da = TWO_PI/c; 
   strokeCap(SQUARE);
   for(int i = 0; i < c; i++){
      arc(x, y, d, d, da*i, da*(i+0.5)); 
   }
}
}

