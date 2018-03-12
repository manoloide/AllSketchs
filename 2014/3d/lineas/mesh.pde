class Mesh {
  ArrayList<PVector> verts;
  ArrayList<Face> faces;
  PVector pos, rot, sca;
  Mesh() {
    pos = new PVector();
    rot = new PVector();
    sca = new PVector();

    verts = new ArrayList<PVector>();
    faces = new ArrayList<Face>();
    createLineMesh();
  }
  void update() {
  }
  void draw() {
    beginShape(TRIANGLES);
    for (int j = 0; j < faces.size (); j++) {
      int fverts[] = (faces.get(j)).values;
      for (int i = 0; i < fverts.length; i++) {
        int ind = fverts[i];
        PVector ver = verts.get(ind);
        vertex(ver.x, ver.y, ver.z);
      }
    }
    endShape();
  }
  void createRandomMesh() {
    float tt = 500;
    for (int i = 0; i < 20; i++) {
      verts.add(new PVector(random(-tt, tt), random(-tt, tt), random(-tt, tt)));
    } 
    for (int i = 0; i < 8; i++) {
      faces.add(new Face(int(random(verts.size())), int(random(verts.size())), int(random(verts.size()))));
    }
  }

  void createLineMesh() {
    float dim = 10; 
    int cant = 20;
    float des = 2;
    float ang1 = random(TWO_PI);
    float ang2 = random(TWO_PI);
    float x = 0;
    float y = 0; 
    float z = 0;
    for(int i = 0; i < cant; i++){
        
    }
  }
}

class Face {
  int values[];
  Face(int... values) {
    this.values = values;
  }
}
