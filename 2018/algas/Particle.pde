class Particle {
  ArrayList<PVector> points;
  int maxPoints = 60;
  float x, y;
  float vd;
  float des;
  Particle() {
    vd = random(0.4, 2)*20;
    des = random(10000);
    points = new ArrayList<PVector>();
  }

  void update() {
    for(int i = 0; i < points.size(); i++){
       PVector p = points.get(i);
       p.x -= vd;
    }
    
    x = height*lerp(-0.8, 0.8, noise(des+time*0.1, 2));
    y = height*lerp(-0.8, 0.8, noise(des+4, time*0.1));
    points.add(new PVector(0, x, y));
    
    if(points.size() > maxPoints){
       points.remove(0); 
    }
  }

  void show() {
    beginShape();
    for (int i = 0; i < points.size(); i++) {
      PVector p = points.get(i);
      float v = map(i, 0, points.size(), 0, 1);
      stroke(v*255);
      vertex(p.x, p.y, p.z);
    }
    endShape();
  }
}
