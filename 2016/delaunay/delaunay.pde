import java.util.*;

Delaunay tris;

PImage image = loadImage("http://revistametronomo.com/wp-content/uploads/2016/03/yorke-1017.jpeg");
void setup() {
  size(image.width, image.height);

  tris = new Delaunay();
  tris.addVertex(new Vertex(0, 0, 0, 0));
  tris.addVertex(new Vertex(width, 0, width, 0));
  tris.addVertex(new Vertex(width, height, width, height));
  tris.addVertex(new Vertex(0, height, 0, height));
}


void draw() {
  image(image, 0, 0);

  stroke(255, 0, 0);
  noFill();

  tris.draw();
}

void mousePressed() {
  tris.addVertex(new Vertex(mouseX, mouseY, mouseX, mouseY));
  tris.triangulate();
}

class Vertex {
  float x, y, ux, uy;
  int i;
  Vertex(float x, float y) {
    this.x = x; 
    this.y = y;
  }
  Vertex(float x, float y, float ux, float uy) {
    this.x = x; 
    this.y = y;
    this.ux = ux; 
    this.uy = uy;
  }
}

class Triangle {
  int vertices[];
  Triangle(int i1, int i2, int i3) {
    vertices = new int[3];
    vertices[0] = i1;
    vertices[1] = i2;
    vertices[2] = i3;
  }
}

class Delaunay {
  ArrayList<Vertex> vertices; 
  ArrayList<Triangle> triangles;
  Delaunay() {
    vertices = new ArrayList<Vertex>();
    triangles = new ArrayList<Triangle>();
  }

  void clear() {
    vertices.clear();
    triangles.clear();
  }

  void addVertex(Vertex v) {
    v.i = vertices.size();
    vertices.add(v);
  }

  void triangulate() {
    ArrayList<Vertex> temp = new ArrayList<Vertex>(vertices);
    int nv = vertices.size();
    Collections.sort(temp, new Comparator<Vertex>() {
      public int compare(Vertex v1, Vertex v2) {
        if (v1.x < v2.x)
          return -1;
        else if (v1.x > v2.x)
          return 1;
        return 0;
      }
    }
    );
  }

  void draw() {
    for (int i = 0; i < vertices.size (); i++) {
      Vertex v = vertices.get(i);
      stroke(255, 0, 0);
      noFill();
      ellipse(v.x, v.y, 2, 2);
      fill(255, 0, 0);
      text(v.i, v.x+4, v.y);
    }
  }
}

