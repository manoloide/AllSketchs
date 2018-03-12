import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.*;

Box2DProcessing box2d;

Ball ball;
Line line;

void setup() {
  size(480, 720);

  box2d = new Box2DProcessing(this);
  box2d.createWorld();  
  box2d.setGravity(0, -20);

  ArrayList<Vec2> points = new ArrayList<Vec2>();
  points.add(new Vec2(0, 300));
  points.add(new Vec2(240, 400));
  points.add(new Vec2(480, 300));

  line = new Line(points);
  line.updateSurface();
}

void draw() {

  box2d.step();
  background(200);

  line.show();
  if (ball != null) ball.update();
}

void mousePressed() {
  ball = new Ball(mouseX, mouseY);
  ball.direction = new PVector(0, -20);
}

class Ball {
  PVector position;
  PVector direction;

  Ball(float x, float y) {
    position = new PVector(x, y);
    direction = new PVector(0, -0.02);
  }

  void update() {
    direction.y += 0.1;
    position.add(direction);
    show();
  }

  void show() {
    ellipse(position.x, position.y, 20, 20);
  }
}

class Line {
  ArrayList<Vec2> points;
  Line(ArrayList<Vec2> p) {
    points = p;
  }

  void updateSurface() {
    ChainShape chain = new ChainShape();

    for (int i = 0; i < points.size(); i++) {
      Vec2 p = points.get(i);
      points.add(new Vec2(p.x, p.y));
    }
    Vec2[] vertices = new Vec2[points.size()];
    for (int i = 0; i < vertices.length; i++) {
      Vec2 edge = box2d.coordPixelsToWorld(points.get(i));
      vertices[i] = edge;
    }
    chain.createChain(vertices, vertices.length);

    BodyDef bd = new BodyDef();
    bd.position.set(0.0f, 0.0f);
    Body body = box2d.createBody(bd);
    body.createFixture(chain, 1);
  }

  void show() {
    stroke(0, 255, 20);
    noFill();
    beginShape();
    for (Vec2 v : points) {
      vertex(v.x, v.y);
    }
    endShape();
  }
}