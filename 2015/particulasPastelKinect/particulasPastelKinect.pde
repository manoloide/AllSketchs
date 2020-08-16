import SimpleOpenNI.*;

SimpleOpenNI  context;

ArrayList<Nodo> nodos;

PVector com = new PVector();                                 
PVector com2d = new PVector();  
color[]       userClr = new color[] { 
  color(255, 0, 0), 
  color(0, 255, 0), 
  color(0, 0, 255), 
  color(255, 255, 0), 
  color(255, 0, 255), 
  color(0, 255, 255)
};
//ArrayList<Particula> particulas;

void setup() {
  size(640, 480, P3D);


  context = new SimpleOpenNI(this, SimpleOpenNI.RUN_MODE_SINGLE_THREADED);
  if (context.isInit() == false) {
    println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
    exit();
    return;
  } // enable depthMap generation 

    frameRate(60);
  context.enableDepth();
  context.enableUser();

  context.setMirror(false);
  /*
  particulas = new ArrayList<Particula>();
   for (int i = 0; i < 60; i++) {
   particulas.add(new Particula(width/2, height/2));
   }
   */
  nodos = new ArrayList<Nodo>();
  for (int i = 0; i < 15; i++) {
    nodos.add(new Nodo(width/2, height/2));
  }

  background(80);
}

void draw() {

  noStroke();
  fill(80, 180);
  rect(0, 0, width, height);

  for (int i = 0; i < nodos.size (); i++) {
    Nodo n = nodos.get(i);
    n.update();
  }

  if (frameCount%2 == 0) {
    context.update();
    int users[] = context.getUsers();
    for (int i = 0; i < min (1, users.length); i++) {
      int id = users[i];
      if (context.isTrackingSkeleton(id)) {
        // draw the skeleton
        stroke(0);
        strokeWeight(2);
        drawSkeleton(id);
        for (int j = 0; j < nodos.size (); j++) {
          Nodo n = nodos.get(j);

          PVector real = new PVector();
          context.getJointPositionSkeleton(id, j, real);
          PVector proj = new PVector();
          context.convertRealWorldToProjective(real, proj);
          //fill(0, 255, 0);
          n.setPosition(proj.x, proj.y);
        }
      }
    }
  }
}

// SimpleOpenNI events

void onNewUser(SimpleOpenNI curContext, int userId) {
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");
  curContext.startTrackingSkeleton(userId);
}

void onLostUser(SimpleOpenNI curContext, int userId) {
  println("onLostUser - userId: " + userId);
}

void onVisibleUser(SimpleOpenNI curContext, int userId) {
  //println("onVisibleUser - userId: " + userId);
}


void drawSkeleton(int userId) {  
  // draw limbs  
  context.drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK);

  context.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);

  context.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);

  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO);

  context.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT);

  context.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT);
}

class Nodo {
  Particula[] particulas;
  int cp = 120;
  float x, y, cx, cy;
  float vel = 0.8;
  Nodo(float x, float y) {
    this.x = cx = x; 
    this.y = cy = y;
    particulas = new Particula[cp];
    for (int i = 0; i < cp; i++) {
      particulas[i] = new Particula(x, y);
    }
  }
  void update() {
    x += (cx-x)*vel;
    y += (cy-y)*vel;

    for (int i = 0; i < particulas.length; i++) {
      Particula p = particulas[i];
      p.setMouse(x, y);
      p.update();
    }
  }
  void setPosition(float nx, float ny) {
    cx = nx;
    cy = ny;
  }
}

class Particula {
  color colors[] = {
    #F7D8A6, 
    #FFC296, 
    #FFA69E, 
    #CB9FB1, 
    #BFDED6
  };
  color col;
  float x, y, dx, dy, ax, ay;
  float mx, my;
  float atr, est, tam;
  float dis, ang;
  Particula(float x, float y) {
    this.x = x; 
    this.y = y;

    col = color(colors[int(random(colors.length))]);
    dx = random(0.2);
    dy = random(0.2);
    atr = random(0.7, 1);
    est = random(0.2, 0.8);
    tam = random(1, 5);
  }
  void setMouse(float mx, float my) {
    this.mx = mx;
    this.my = my;
  }
  void update() {
    dis = dist(mx, my, x, y);
    ang = atan2(my-y, mx-x);
    ax = x;
    ay = y;
    x += cos(dx*frameCount)*dis*est;
    y += cos(dy*frameCount)*dis*est;

    x += cos(ang)*dis*atr;
    y += sin(ang)*dis*atr; 

    show();
  }
  void show() {

    noStroke();
    fill(col);
    //ellipse(x, y, tam, tam);

    stroke(col);
    strokeWeight(tam/2*dis*0.008);
    line(ax, ay, x, y);
  }
}
