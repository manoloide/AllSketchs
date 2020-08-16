class Node {
  
  boolean remove;
  float size;
  int col;
  PVector pos, force;

  Node(float x, float y) {
    pos = new PVector(x, y);
    force = new PVector(0, 0);
    col = rcol();
  }

  void update() {
    
    float nsize = map(pow(noise(des+pos.x*det, des+pos.y*det), pwrSize), 0, 1, minSize, maxSize);
    size = lerp(size, nsize, velSize);
    
    pos.add(force);
    force.mult(0);
    
    if(pos.x < -size || pos.x > width+size) remove = true;
    if(pos.y < -size || pos.y > height+size) remove = true; 
  }

  void show() {
    fill(col);
    ellipse(pos.x, pos.y, size, size);
  }
}
