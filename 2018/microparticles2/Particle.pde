class Particle {
  ArrayList<PVector> vertex;
  boolean remove;
  color col;
  float osc, aos, dos;
  float x, y, s, ss;
  float or; 
  float rx, ry;
  float time, lifeTime;
  float iam, am;
  float vel;
  PVector center; 
  Particle(float x, float y) {
    this.x = x;
    this.y = y;

    col = rcol();


    vertex = new ArrayList<PVector>();

    s = random(50, 80);
    lifeTime = random(5, 7);//random(6, 8);
    time = 0;

    osc = int(random(3, 8));
    aos = random(0.08);
    dos = random(-1., 1)*random(0.2, 1);

    or = random(2, 8);

    iam = random(10000);
    am = random(0.1);
    vel = random(1)*random(0.8);
  }

  void update() {
    time += 1./60; 
    if (time > lifeTime) remove = true;

    float ang = noise(iam+am*time)*TWO_PI*2;

    x += rx;
    y += ry;

    rx = 0; 
    ry = 0;

    float mv = pow(cos(globalTime+time*20)*0.5+0.5, 0.8);
    float endTime = constrain(map(time, lifeTime*0.9, lifeTime, 1, 0), 0, 0);
    float dv = vel*(1+mv*0.1)*endTime;

    x += cos(ang)*dv;
    y += sin(ang)*dv;

    center = dis(x, y);
    if (center.x < -s || center.x > width+s || center.y < -s || center.y > height+s){
      if(time < lifeTime*0.9) time = lifeTime*0.9;
      //remove = true;
    }

    ss = s;
    if (time < lifeTime*0.4) ss *= Easing.ExpoOut(map(time, 0, lifeTime*0.4, 0, 1), 0., 1, 1.0);
    else if (time > lifeTime*0.5) ss *= Easing.ExpoOut(map(time, lifeTime*0.5, lifeTime*0.9, 1, 0), 0, 1, 1);
    if (time > lifeTime*0.90) {
      float tt = map(time, lifeTime*0.9, lifeTime, 0, 1);
      ss *= (1-tt*0.2)+abs(sin(tt*TWO_PI))*0.1;
    }
    calculeVertex();
  }

  PVector dis(float x, float y) {
    float d1 = 0.008;
    float n1 = noise(x*d1, y*d1, time*0.02)*TWO_PI;
    float a1 = ss*0.2; 
    float d2 = 0.001;
    float n2 = noise(x*d2, y*d2, time*0.02)*TWO_PI;
    float a2 = ss*1.0; 
    //return new PVector(x, y);
    return new PVector(x+cos(n1)*a1+cos(n2)*a2, y+sin(n1)*a1+sin(n2)*a2);
  }

  void calculeVertex() {
    vertex.clear();
    if (ss > 0 && ss < s*2) {
      float r = ss*0.5*(1+sin(time*or)*.06);
      int res = 48;

      float gro = 0.9+cos(time+globalTime*20)*0.01;
      float da = TWO_PI/res;

      for (int i = 0; i < res; i++) {
        float ao = cos(((i*1./res)*osc+time*dos)*TWO_PI)*0.5+0.5;
        float amp = r*(1+pow(ao*aos, 0.8))*gro;
        PVector p = dis(x+cos(da*i)*amp, y+sin(da*i)*amp);
        vertex.add(new PVector(p.x, p.y));
      }
    }
  }

  void show() {
    beginShape();
    PVector p;
    for (int i = 0; i < vertex.size(); i++) {
      p = vertex.get(i%vertex.size());
      vertex(p.x, p.y);
    }
    endShape(CLOSE);

    if (time > lifeTime*0.9) {
      pushStyle();
      float tt = Easing.BounceOut(map(time, lifeTime*0.9, lifeTime, 0, 1), 0, 1, 1);
      float ss = s*tt;
      noFill();
      stroke(g.fillColor);
      strokeWeight(2-tt*2);
      ellipse(center.x, center.y, ss, ss);
      popStyle();
    }
  }

  void rep(Particle o) {
    if (time > lifeTime*0.9) return;
    float dis = dist(x, y, o.x, o.y);
    float maxDis = (ss+o.ss)*1.5;
    if (dis < maxDis) {
      float ang = atan2(y-o.y, x-o.x); 

      float rep = 1.-map(dis, 0, maxDis, 0, 1);//Easing.BounceInOut(map(dis, 0, maxDis, 0, 1), 0, 1, 1);
      rep = pow(rep, .8);
      rx += cos(ang)*rep*ss*0.1;
      ry += sin(ang)*rep*ss*0.1;

      o.rx += cos(ang+PI)*rep*o.ss*0.1;
      o.ry += sin(ang+PI)*rep*o.ss*0.1;
    }
  }

  void rep(float xx, float yy, float ss2) {
    if (time > lifeTime*0.9) return;
    float dis = dist(x, y, xx, yy);
    float maxDis = (ss+ss2)*1.5;
    if (dis < maxDis) {
      float ang = atan2(y-yy, x-xx); 

      float rep = 1.-map(dis, 0, maxDis, 0, 1);//Easing.BounceInOut(map(dis, 0, maxDis, 0, 1), 0, 1, 1);
      rep = pow(rep, .8);
      rx += cos(ang)*rep*ss*0.1;
      ry += sin(ang)*rep*ss*0.1;
    }
  }
}
