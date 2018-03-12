class Camara {
  float x, y, dx, dy;
  Camara() {
    x = 0; 
    y = 0;
  }
  void act() {
    /*
    dx = -actual.x;
    dy = -actual.y;
    if (dx > -width/2)dx = -width/2; 
    if (dy > -height/2)dy = -height/2; 
    if (dx < width/2-t.w) dx = width/2-t.w;
    if (dy < height/2-t.h) dy = height/2-t.h;
    float dist = dist(dx, dy, x, y);
    float ang = atan2(dy-y, dx-x);
    float vel = (dist < 5)? dist/2 : dist/5;   
    x += cos(ang)*vel;
    y += sin(ang)*vel;
    */
  }
}

class Jugador {
}

class Nivel {
  int w, h;
  int tiles[][];
  Nivel(){
  }
  void act(){
    
  }
  
  void dibujar(){
    
  }
  
  void cargarNivel(){
    
  }
  
  void reiniciar(){
    
  }
}

class Solido {
}

class Plataforma extends Solido {
}

class Punto{
}

class Bala{
  
}

class Canon{  
}
