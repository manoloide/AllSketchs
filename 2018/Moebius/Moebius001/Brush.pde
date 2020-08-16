class Brush {

  Brush() {
  }

  void draw (PGraphics render, Stroke stroke) {
    
    if(stroke.points.size() <= 0) return;
    
    render.noFill();

    /*
    render.beginShape();
     for(int i = 0; i < stroke.points.size(); i++){
     PVector p =  stroke.points.get(i);
     render.vertex(p.x, p.y);
     }
     render.endShape();
     */

    render.noStroke();
    render.fill(0);
    //render.stroke(255, 0, 0);
    render.beginShape();
    float x = stroke.points.get(0).x;
    float y = stroke.points.get(0).y;
    render.vertex(x, y);
    for (int i = 1; i < stroke.points.size(); i++) {
      PVector p1 =  stroke.points.get(i-1);
      PVector p2 =  stroke.points.get(i);
      float ang = atan2(p2.y-p1.y, p2.x-p1.x)-HALF_PI;
      x = p2.x+cos(ang)*1;
      y = p2.y+sin(ang)*1;
      render.vertex(x, y);
    }
    
    
    for (int i = stroke.points.size()-1; i > 0; i--) {
      PVector p1 =  stroke.points.get(i-1);
      PVector p2 =  stroke.points.get(i);
      float ang = atan2(p2.y-p1.y, p2.x-p1.x)+HALF_PI;
      x = p2.x+cos(ang)*1;
      y = p2.y+sin(ang)*1;
      render.vertex(x, y);
    }
    render.endShape();
  }
}