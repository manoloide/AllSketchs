class Line {
  ArrayList<Point> points;
  boolean remove;
  float x, y, z;
  float vel, time, timeLife;
  float detColor;
  Line(float x, float y, float z) {
    this.x = x; 
    this.y = y; 
    this.z = z;
    vel = random(4);
    detColor = random(0.001);
    
    timeLife = random(6, 8);
    time = 0;
    
    points = new ArrayList<Point>();
  }

  void update() {
    
    time += 1./60;
    if(time > timeLife) remove = true;
    
    float a1 = noise(des1+x*det, des1+y*det, des1+z*det)*TAU*4;
    float a2 = noise(des2+x*det, des2+y*det, des2+z*det)*TAU*4;
    x += cos(a1)*cos(a2)*vel;
    y += cos(a1)*sin(a2)*vel;
    z += sin(a1)*vel;
    int col = getColor(noise(x*detColor, y*detColor, z*detColor)*colors.length*2);
    points.add(new Point(x, y, z, col));
    
    if(points.size() > 10){
       points.remove(0); 
    }
  }

  void show() {
    noFill();
    beginShape();
    for (int i = 0; i < points.size(); i++) {
      Point p = points.get(i);
      stroke(p.col, 250);
      vertex(p.x, p.y, p.z);
    }
    endShape();
  }
}

class Point {
  float x, y, z;
  int col;
  Point(float x, float y, float z, int col) {
    this.x = x; 
    this.y = y; 
    this.z = z; 
    this.col = col;
  }
}
