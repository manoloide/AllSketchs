class Cosa {
  int tam;
  float x, y, nx, ny;
  boolean selec, mover;

  Cosa (float nx, float ny) {
    tam = 10;
    x = nx;
    y = ny;
    selec = false;
    mover = false;
  }

  void draw() {
    if (selec) {
      stroke(0, 255, 0);
      strokeWeight(2);
      fill(255);
      ellipse(x, y, tam, tam);
    }
    else {
      stroke(0);
      strokeWeight(1);
      fill(255);
      ellipse(x, y, tam, tam);
    }
  }

  void mover() {
    float ang;
    if (dist(x, y, nx, ny) > 1) {
      ang = atan2(ny-y, nx-x);
      for (int i=0; i < cosas.size();i++) {
         Cosa aux = (Cosa) cosas.get(i);
         if ((dist(x,y,aux.x,aux.y) < 14)&&this!=aux){
            float angp1,angp2,px1,py1,px2,py2,dis1,dis2,cam;
            angp1 = atan2(aux.y-y, aux.x-x);
            cam = PI/4;
            angp2 = angp1 - cam;
            angp1 += cam;
            px1 = aux.x + cos(angp1)*6;
            py1 = aux.y + sin(angp1)*6;
            px2 = aux.x + cos(angp2)*6;
            py2 = aux.y + sin(angp2)*6;
            fill(255,0,0);
            dis1 = dist(px1,py1,nx,ny);
            dis2 = dist(px2,py2,nx,ny);
            if (dis1 >= dis2){
              ang -= PI/4;
            }else{
              ang += PI/4;
            }
            //println("1: "+degrees(angp1)+" 2: "+degrees(angp2));
          }
      }
      x = x+(cos(ang)*1);
      y = y+(sin(ang)*1);
    }
    else {
      mover = false;
    }
  }
}

