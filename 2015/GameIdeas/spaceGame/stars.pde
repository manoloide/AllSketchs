class Stars {
  ArrayList<Star> stars;
  int amount; 
  float ang; 
  float minSize, maxSize;
  
  Stars() {
    
    amount = 100; 
    minSize = 1;
    maxSize = 3;
    init();
    
  }

  void init() {
    
    stars = new ArrayList<Star>(); 
    for (int i = 0; i < amount; i++) {
      stars.add(new Star(random(width), random(height), random(minSize, maxSize)));
    }
    
  }

  void update() {
    
    if(stars.size() < amount){
        stars.add(new Star(random(width), -random(maxSize, maxSize*2), random(minSize, maxSize)));
    }
    
    for (int i = 0; i < stars.size(); i++) {
      Star star = stars.get(i); 
      star.update();
      if (star.remove) stars.remove(i--);
    }
    
  }
}

class Star {
  
  boolean remove;
  float x, y, s;
  float v;
  
  Star(float x, float y, float s) {
    
    this.x = x; 
    this.y = y;
    this.s = s;
    v = random(0.1, 0.8);
    remove = false;
    
  }

  void update() {
    
    float vy = v;

    y += vy;
    
    if (vy < 0 && y < -s/2) remove = true;
    if (vy > 0 && y > height+s/2) remove = true;


    show();
  }

  void show() {
    
    noStroke();
    fill(255);
    ellipse(x, y, s, s);
    
  }
}