
ArrayList<Cube> cubes;
ArrayList<Node> nodes;

void setup() {
  size(960, 960, P3D);
  generate();
}

void draw() {
  background(250);
  smooth(4);
  translate(width/2, height/2, -300);
  float vel = 0.04;
  rotateX(frameCount*0.07*vel);
  rotateY(frameCount*0.012*vel);
  rotateZ(frameCount*0.003*vel);
  /*
  for (int i = 0; i < nodes.size (); i++) {
   Node n = nodes.get(i);
   n.updateMovement();
   }*/
  //fill(255, 0, 80);
  for (int i = 0; i < nodes.size (); i++) {
    Node n = nodes.get(i);
    n.update();
  }
  for (int i = 0; i < cubes.size (); i++) {
    Cube c = cubes.get(i);
    c.update();
    if (c.remove) cubes.remove(i--);
  }

  if (cubes.size() > 0 && frameCount%10 == 0) cubes.get(int(random(cubes.size()))).subDivide();
}

void keyPressed() {
  if (key == 's') saveImage();
  else if (key == 'd') {
    if (cubes.size() > 0) cubes.get(int(random(cubes.size()))).subDivide();
  } else {
    generate();
  }
}

void generate() {
  cubes = new ArrayList<Cube>();
  nodes = new ArrayList<Node>();

  int cc = 12; 
  int ss = int(random(40, 56)); 
  int mt = (cc*ss)/2;

  Cube cube = new Cube(0, 0, 0);
  cubes.add(cube);

  /*
  int tt = cc*ss;
   for (int k = 0; k < cc; k++) {
   for (int j = 0; j < cc; j++) {
   for (int i = 0; i < cc; i++) {
   Node n = new Node(i*ss-tt/2, j*ss-tt/2, k*ss-tt/2);
   nodes.add(n);
   if (i > 0) n.add(nodes.get((i-1)+j*cc+k*cc*cc));
   if (j > 0) n.add(nodes.get(i+(j-1)*cc+k*cc*cc));
   if (k > 0) n.add(nodes.get(i+j*cc+(k-1)*cc*cc));
   }
   }
   }
   */
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

class Cube {
  boolean remove;
  float size;
  Node[][][] vertices;
  PVector position;
  Cube(float x, float y, float z) {
    size = 500;
    position = new PVector(x, y, z);
    vertices = new Node[2][2][2];
    for (int k = 0; k < 2; k++) {
      for (int j = 0; j < 2; j++) {
        for (int i = 0; i < 2; i++) {
          Node n = new Node(position.x-size/2+size*i, position.y-size/2+size*j, position.z-size/2+size*k); 
          nodes.add(n);
          vertices[i][j][k] = n;
        }
      }
    }
  }

  Cube(Node[][][] n) {
    size = n[0][0][0].target.dist(n[1][0][0].target);
    vertices = n;
    position = new PVector(0, 0, 0);
    for (int k = 0; k < 2; k++) {
      for (int j = 0; j < 2; j++) {
        for (int i = 0; i < 2; i++) {
          position.add(vertices[i][j][k].target);
        }
      }
    }
    position.div(8);
    for (int k = 0; k < 2; k++) {
      for (int j = 0; j < 2; j++) {
        for (int i = 0; i < 2; i++) {
          vertices[i][j][k].position = new PVector(position.x, position.y, position.z);
        }
      }
    }
  }

  void update() {
    show();
  }

  void show() {
    PVector p1, p2;
    for (int i = 0; i < 4; i++) {
      p1 = vertices[i%2][i/2][0].position;
      p2 = vertices[i%2][i/2][1].position;
      line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);
      p1 = vertices[i%2][0][i/2].position;
      p2 = vertices[i%2][1][i/2].position;
      line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);
      p1 = vertices[0][i%2][i/2].position;
      p2 = vertices[1][i%2][i/2].position;
      line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);
    }
  }

  void subDivide() {
    Node auxVertices[][][] = new Node[3][3][3];

    for (int k = 0; k < 3; k++) {
      for (int j = 0; j < 3; j++) {
        for (int i = 0; i < 3; i++) {
          if (i == 1 || j == 1 || k == 1) {
            float x = position.x+map(i, 0, 2, -size/2, size/2);
            float y = position.y+map(j, 0, 2, -size/2, size/2);
            float z = position.z+map(k, 0, 2, -size/2, size/2);
            Node n = new Node(x, y, z);
            auxVertices[i][j][k] = n;
            nodes.add(n);
          } else {
            auxVertices[i][j][k] = vertices[i/2][j/2][k/2];
          }
        }
      }
    }

    for (int ck = 0; ck < 2; ck++) {
      for (int cj = 0; cj < 2; cj++) {
        for (int ci = 0; ci < 2; ci++) {
          Node[][][] vertCube = new Node[2][2][2];
          for (int k = 0; k < 2; k++) {
            for (int j = 0; j < 2; j++) {
              for (int i = 0; i < 2; i++) {
                vertCube[i][j][k] = auxVertices[i+ci][j+cj][k+ck];
              }
            }
          }
          Cube ncube = new Cube(vertCube);
          cubes.add(ncube);
        }
      }
    }

    remove = true;
  }
}

class Node {
  ArrayList<Node> brothers;
  boolean remove;
  float vel, elastic, centerDistance, noise;
  PVector position, target;
  PVector velocity, force;
  Node(float x, float y, float z) {
    position = new PVector();
    target = new PVector(x, y, z);
    brothers = new ArrayList<Node>();
    velocity = new PVector();
    force = new PVector();
    vel = random(0.6, 0.82);
    noise = 30*random(0.8, 1);
    elastic = random(0.01, 0.014);
    centerDistance = target.mag();
  }

  void update() {


    PVector aux = new PVector(target.x-position.x, target.y-position.y, target.z-position.z);
    velocity.add(aux);
    velocity.mult(vel);
    position.add(velocity);

    force = new PVector();
    force.x += (noise(position.x*0.008+frameCount*0.05)-0.5)*noise;
    force.y += (noise(position.y*0.008+frameCount*0.05)-0.5)*noise;
    force.z += (noise(position.z*0.008+frameCount*0.05)-0.5)*noise;
    position.add(force);

    show();
    stroke(0, 50);
    showConnections();
  }

  void show() {
    pushMatrix();
    translate(position.x, position.y, position.z);
    //box(2);
    popMatrix();
  }

  void showConnections() {
    for (int i = 0; i < brothers.size (); i++) {
      Node n = brothers.get(i); 
      line(position.x, position.y, position.z, n.position.x, n.position.y, n.position.z);
    }
  }
  void add(Node n) {
    if (!brothers.contains(n)) {
      brothers.add(n);
    }
  }
}

