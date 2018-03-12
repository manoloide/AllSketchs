boolean comer(Jugador j) {
  boolean arriba, abajo, izquierda, derecha;
  float atam;
  int ya, xa;

  atam = (j.tam)/2;
  //colisones bordes y enemigos... 
  arriba = false;
  ya = int((j.y-atam)/TAMTILE);
  for (float i = j.x - atam; i < j.x + atam; i++) {
    xa = int(i/TAMTILE);
    if (nivel.colision(xa,ya)){
      arriba = true;
      break;
    }
  }

  abajo = false;
  ya = int((j.y+atam)/TAMTILE);
  for (float i = j.x - atam; i < j.x + atam; i++) {
    xa = int(i/TAMTILE);
    if (nivel.colision(xa,ya)){
      abajo= true;
      break;
    }
  }

  izquierda = false;
  xa = int((j.x-atam)/TAMTILE);
  for (float i = j.y - atam; i < j.y + atam; i++) {
    ya = int(i/TAMTILE);
    if (nivel.colision(xa,ya)){
      izquierda = true;
      break;
    }
  }

  derecha = false;
  xa = int((j.x+atam)/TAMTILE);
  for (float i = j.y - atam; i < j.y + atam; i++) {
    ya = int(i/TAMTILE);
    if (nivel.colision(xa,ya)){
      derecha = true;
      break;
    }
  }
  //mata si sobre sale.
  if (abajo && arriba && derecha && izquierda) {
    return false;
  }
  //mover si toca los bordes
  if (abajo && !arriba) {
    j.y -= j.vel;
  }
  if (!abajo && arriba) {
    j.y += j.vel;
  }
  if (derecha && !izquierda) {
    j.x -= j.vel;
  }
  if (!derecha && izquierda) {
    j.x += j.vel;
  }
  //colisiones con piedras(se puede mejorar...) NO ANDA;
  int fuerza = int(j.tam)/TAMTILE;
  for (int i = 0; i < nivel.piedras.size();i++) {
    Piedra aux = (Piedra) nivel.piedras.get(i);
    float dis = j.tam/2 + aux.tam/2;
    float disx = abs(j.x - aux.x);
    float disy = abs(j.y - aux.y);
    if (disx < dis && disy < dis) {
      //calcular px py
      int px, py;
      if (j.x > aux.x) {
        px = -1;
      }
      else {
        px = 1;
      }
      if (j.y > aux.y) {
        py = -1;
      }
      else {
        py = 1;
      }
      //
      if (disx < disy) {
        px = 0;
      }
      if (disx > disy) {
        py = 0;
      }
      println(px +" "+py);
      //mover piedra si la toca 
      aux.mover(px, py);
      int valor = coli(aux, px, py);
      if (valor == -1) {
        return false;
      }
      else {
        fuerza -= valor;
      }
    }
  }
  if (fuerza < 0) {
    return false;
  }
  return true;
}

int coli(Piedra pie, float nx, float ny) {
  //devuelve -1 si no se puede o elvuelve la cantidad que mueve
  //colision con bordes y enemigos....
  int cantidad = 0;
  int ya, xa;
  if (ny != 0) {
    if (ny < 0) {
      ya = int((pie.y-pie.tam/2)/TAMTILE);
    }
    else {
      ya = int((pie.y-1+pie.tam/2)/TAMTILE);
    }
    for (float i = pie.x - pie.tam/2; i < pie.x + pie.tam/2; i++) {
      xa = int(i/TAMTILE);
      if (nivel.mapa[xa][ya] == 1 || nivel.mapa[xa][ya] == 3) {
        return -1;
      }
    }
  }
  else {
    if (nx < 0) {
      xa = int((pie.x-pie.tam/2)/TAMTILE);
    }
    else {
      xa = int((pie.x-1+pie.tam/2)/TAMTILE);
    }
    for (float i = pie.y-pie.tam/2; i < pie.y+pie.tam/2; i++) {
      ya = int(i/TAMTILE);
      if (nivel.mapa[xa][ya] == 1 || nivel.mapa[xa][ya] == 3) {
        return -1;
      }
    }
  }
  //colosion con piedras
  for (int i = 0; i < nivel.piedras.size();i++) {
    Piedra aux = (Piedra) nivel.piedras.get(i);
    if (aux != pie) {
      if (colCubos(pie.x, pie.y, pie.tam, aux.x, aux.y, aux.tam)) {
        aux.mover(nx, ny);
        int valor = coli(aux, nx, ny);
        if (valor == -1) {
          return -1;
        }
        else {
          cantidad += valor;
        }
      }
    }
  }
  return cantidad;
}

void monitor() {
  fill(255, 100);
  rect(10, 10, 80, 80);
  String tex ="x:" + nivel.jugador.x + "\ny:" + nivel.jugador.y + "\nt:" + nivel.jugador.tam + "\ntiros:" + nivel.tiros.size() + "\nfr:" + frameRate;
  fill(0, 200);
  text(tex, 15, 25) ;
}

boolean colPunCub(float x1, float y1, float tam, float x2, float y2) {
  tam /= 2;
  if (x2 >= x1 - tam && x2 <= x1 + tam && y2 >= y1 - tam && y2 <= y1 + tam) {
    return true;
  }  
  return false;
}

boolean colCubos(float x1, float y1, float tam1, float x2, float y2, float tam2) {
  tam1 /= 2;
  tam2 /= 2;
  float dis = tam1 + tam2;
  if (abs(x1 - x2) < dis && abs(y1 - y2) < dis) {
    return true;
  }  
  return false;
}
