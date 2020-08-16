void formSky(){
  ArrayList<PVector> points = new ArrayList<PVector>();
  for(int i = 0; i < 1000; i++){
    float x = random(width);
    float y = random(height);
    float s = width*random(0.02, 0.1);
    boolean add = true;
    for(int j = 0; j < points.size(); j++){
       PVector o = points.get(j);
       if(dist(x, y, o.x, o.y) < (s+o.z)*0.5){
         add = false;
         break;
       }
    }
    if(add) points.add(new PVector(x, y, s));
  }
  for(int i = 0; i < points.size(); i++){
     PVector p = points.get(i);
     fill(rcol());
     ellipse(p.x, p.y, p.z, p.z);
  }
}
