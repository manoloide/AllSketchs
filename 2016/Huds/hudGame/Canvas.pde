

class Canvas {
  ArrayList<PVector> boxes;
  Camera camera;
  int width = 480;
  int height = 480;
  PGraphics render;
  Canvas() {
    render = createGraphics(width, height, P3D);
    camera = new Camera(render);
    boxes = new ArrayList<PVector>();
    for (int i = 0; i < 10; i++) {
      PVector aux = new PVector(random(-800, 800), random(-800, 800), random(-800, 800));
      boxes.add(aux);
    }
  }

  void update() {
    show();
  }

  void show() {
    render.beginDraw();
    render.background(12);
    render.stroke(255);
    camera.update();
    for (int i = 0; i < boxes.size(); i++) {
      PVector p = boxes.get(i);
      render.pushMatrix();
      render.translate(p.x, p.y, p.z);
      render.box(10);
      render.popMatrix();
      //render.point(p.x, p.y, p.z);
    }
    render.endDraw();
    image(render, -width/2, -height/2);
  }
}

class Camera {
  PGraphics render;
  PVector rot, rotTarget;
  Camera (PGraphics render) {
    this.render = render;
    rot = new PVector(PI/4, PI/4);
    rotTarget = new PVector();
  }
  void update() {

    PVector aux = rotTarget.copy();
    aux.sub(rot);
    aux.mult(0.1);
    rot.add(aux);

    render.translate(width/2, height/2, -1200);
    render.rotateX(rot.x);
    render.rotateY(rot.y);
  }

  void moved() {
    float rate = 0.01;
    rotTarget.x += (pmouseY-mouseY) * rate;
    rotTarget.y += (mouseX-pmouseX) * rate;
  }

  void rectMove(int mx, int my) {
    rotTarget.x += (PI/4)*my;
    rotTarget.y += (PI/4)*mx;
  }
}