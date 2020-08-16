void formSky(){
  ArrayList<PVector> points = new ArrayList<PVector>();
  for(int i = 0; i < 100; i++){
    float x = random(width);
    float y = random(height);
    float s = width*random(0.02, 0.1)*map(y, 0, height, 1, 0.3);
    boolean add = true;
    for(int j = 0; j < points.size(); j++){
       PVector o = points.get(j);
       if(dist(x, y, o.x, o.y) < (s+o.z)*0.6){
         add = false;
         break;
       }
    }
    if(add) points.add(new PVector(x, y, s));
  }
  for(int i = 0; i < points.size(); i++){
     PVector p = points.get(i);
     if(random(1) > 0.8) continue;
     float alp = random(180, 255);
     fill(rcol(), alp);
     ellipse(p.x, p.y, p.z*0.5, p.z*0.5);
     fill(0, alp);
     rect(p.x-p.z*0.05, p.y+p.z*0.4, p.z*0.1, p.z*0.1);
  }
}
