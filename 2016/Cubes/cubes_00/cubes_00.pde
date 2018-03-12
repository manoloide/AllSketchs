ArrayList<Cube> cubes;
boolean busy[][][];
int cant = 10; 
float size = 50;
//PImage displace;
PShader post;

void setup() {
  size(640, 640, P3D);
  //displace = loadImage("https://s-media-cache-ak0.pinimg.com/236x/ed/3c/73/ed3c73929f1a2f8638a780935c171ab2.jpg");
  post = loadShader("post.glsl");
  post.set("resolution", float(width), float(height));
  //post.set("displace", displace);
  cubes = new ArrayList<Cube>();
  busy = new boolean[cant][cant][cant];
  for (int j = 0; j < cant; j++) {
    for (int i = 0; i < cant; i++) {
      cubes.add(new Cube(i, cant-1, j));
    }
  }
}

void draw() {
  post.set("time", millis()/1000.);
  background(#151121);
  lights();
  translate(width/2, height/2, -300+sin(frameCount*0.002)*40);
  rotateY(frameCount*0.001);
  stroke(255, 10);
  pushMatrix();
  translate(0, 250, 0);
  rotateX(HALF_PI);
  grid(cant*size, cant*size, cant, cant);
  popMatrix();

  translate((-cant+1)*size*0.5, (-cant+1)*size*0.5, (-cant+1)*size*0.5);// -cant/2.*size, -cant/2.*size);
  fill(240, 245);
  //stroke(255);
  for (int i = 0; i < cubes.size (); i++) {
    Cube c = cubes.get(i);
    c.update();
    c.show();
  }
  filter(post);
  /*
  if(frameCount > 60*25){
   if(frameCount%2 == 1) saveFrame("####.png");
   if(frameCount > 60*33) exit();
   }*/
}

void keyPressed() {
  if (key == 's') saveFrame("####.png");
}  

void grid(float w, float h, int cw, int ch) {
  float dx = w/cw;
  float dy = h/ch;
  float mw = w/2.;
  float mh = h/2.;
  float v;
  for (int i = 0; i <= cw; i++) {
    v = dy*i-mh;
    line(-mw, v, mw, v);
  }
  for (int i = 0; i <= cw; i++) {
    v = dx*i-mw;
    line(v, -mh, v, mh);
  }
}


class Cube {
  boolean remove, move;
  float s = size; 
  PVector pos, npos, ant; 
  Cube(float x, float y, float z) {
    pos = new PVector(x, y, z);
    npos = new PVector(x, y, z);
    ant = new PVector(x, y, z);

    busy[int(x)][int(y)][int(z)] = true;
  }
  void update() {
    if (move) {
      PVector mov = new PVector(npos.x, npos.y, npos.z);
      mov.sub(pos);
      mov.mult(0.1);
      pos.add(mov);

      float dist = pos.dist(npos);
      if (dist < 0.001) {
        move = false;
        pos = new PVector(npos.x, npos.y, npos.z);
        busy[int(ant.x)][int(ant.y)][int(ant.z)] = false;
      }
    } else if (random(1) < 0.02) {
      boolean np = false;
      PVector aux = new PVector(pos.x, pos.y, pos.z);
      if (random(1) < 0.3333333) {
        aux.x -= (random(1) < 0.5)? -1 : 1;
        if (aux.x >= 0 && aux.x < cant) np = true && !busy[int(aux.x)][int(aux.y)][int(aux.z)];
      } else {
        if (random(1) < 0.5) {
          aux.y -= (random(1) < 0.5)? -1 : 1;
          if (aux.y >= 0 && aux.y < cant) np = true && !busy[int(aux.x)][int(aux.y)][int(aux.z)];
        } else {
          aux.z -= (random(1) < 0.5)? -1 : 1;
          if (aux.z >= 0 && aux.z < cant) np = true && !busy[int(aux.x)][int(aux.y)][int(aux.z)];
        }
      }
      if (np) {
        ant = new PVector(pos.x, pos.y, pos.z);
        busy[int(aux.x)][int(aux.y)][int(aux.z)] = true;
        move = true;
        npos = aux;
      }
    }
  }

  void show() {
    pushMatrix();
    //noFill();
    translate(pos.x*s, pos.y*s, pos.z*s);
    box(s);
    /*
    float ms = s*0.5;
    stroke(255);
    point(-ms, -ms, -ms);
    point(-ms, ms, -ms);
    point(-ms, -ms, ms);
    point(-ms, ms, ms);
    point(ms, -ms, -ms);
    point(ms, ms, -ms);
    point(ms, -ms, ms);
    point(ms, ms, ms);
    */
    popMatrix();
  }
}

