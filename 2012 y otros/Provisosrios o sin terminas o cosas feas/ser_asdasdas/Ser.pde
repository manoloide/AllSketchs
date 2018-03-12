class Ser {
  float x, y, hambre;

  Ser(float nx, float ny) {
    x = nx;
    y = ny;
    hambre = 1000;
  }

  void act() {
    draw();
    hambre--;
    if (hambre%10 == 0){
       println(hambre); 
    }
  }

  void draw() {
    stroke(255, 200);
    fill(255, 100);
    ellipse(x, y, 20, 20);
  }
}

