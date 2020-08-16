ArrayList paths[];
int cant = 20;
void setup() {
  paths = new ArrayList[cant*2+1];
  for (int i = 0; i < paths.length; i++) {
    paths[i] = new ArrayList();
  }
  paths[0].add(new PVector(0, 0));
  int res = 0;
  int lvl = 0;
  while (lvl < cant*2-1) {
    for (int i = 0; i < paths[lvl].size (); i++) {
      PVector p = (PVector)paths[lvl].get(i);
      if (p.x <= cant && p.y <= cant) {
        if (p.x < cant) paths[lvl+1].add(new PVector(p.x+1, p.y));
        if (p.y < cant) paths[lvl+1].add(new PVector(p.x, p.y+1));
      }
    }
    if(lvl > 0) paths[lvl-1].clear();
    println("LEVEL", lvl, paths[lvl].size ());
    lvl++;
  }
  println("res", paths[lvl].size ());
}
