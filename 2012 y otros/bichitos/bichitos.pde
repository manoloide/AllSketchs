ArrayList bichitos, comidas;
color celeste = color(145, 195, 215);

void setup() {
  size(600, 600);
  smooth();
  background(celeste);

  //listas...
  bichitos = new ArrayList();
  comidas = new ArrayList();
  //agrega un solo bichito para empezar
  bichitos.add( new bichito(300, 300));
}
void draw() {
  //sobre escribe el fondo 
  fill(red(celeste), green(celeste), blue(celeste), 10);
  rect(0, 0, width, height);
  //actualiza la comida
  for (int i = 0; i < comidas.size();i++) {
    comida aux = (comida) comidas.get(i);
    aux.act();
  }
  //actualiza los bichos
  for (int i = 0; i < bichitos.size();i++) {
    bichito aux = (bichito) bichitos.get(i);
    aux.act();
    //mata a los bichos cuando se quedan sin comida
    if (aux.hambre < 0) {
      bichitos.remove(i);
      i--;
    }
    //hace que se separe en dos bichos cuando come mucho
    else if (aux.hambre > 1000) {
      bichitos.add(new bichito(aux.x,aux.y));
      bichitos.add(new bichito(aux.x,aux.y));
      bichitos.remove(i);
      i--;
    }
  }
}

void mousePressed() {
  //agrega comida con un click
  comidas.add(new comida(mouseX, mouseY));
}

class bichito {
  float x, y, ang, vel, posx[], posy[], hambre;
  color c = color(90, 47, 90);

  bichito(float nx, float ny) {
    x = nx;
    y = ny;
    ang = random(2*PI);
    vel = 0.2;
    hambre = 1000;
    //llena toda la lista de posiciones con el valor inicial
    posx = new float[10];
    posy = new float[10];
    for (int i = 0; i < 10; i++) {
      posx[i] = x;
      posy[i] = y;
    }
  }

  void act() {
    hambre--;
    noStroke();
    //este es el probisorio para buscar la comida mas cerca
    comida este = null;
    float mi = 1000;
    for (int i = 0; i < comidas.size(); i++) {
      comida aux = (comida) comidas.get(i);
      float dis = dist(aux.x, aux.y, x, y);
      //se fija si esta muy cerca y la come
      if (dis < 5) {
        hambre += aux.cant;
        comidas.remove(i);
        i--;
      }
      //si esta cerca acutaliza a este con el mas cerca
      else if (dis < 60) {
        if (dis < mi){
          mi = dis;
          este = aux;
        }
      }
    }
    //derifica si encontro comida cerca
    if (este != null) {
      float prob = atan2(este.y-y, este.x-x);
      if (prob < 0){
         prob += TWO_PI; 
      }
      ang = ang % (TWO_PI);
      if (ang < 0){
         ang += TWO_PI; 
      }
      prob = (prob + ang)/2;
      if (ang < prob) {
        ang += 0.2;
      }
      else {
        ang -= 0.2;
      }
    }
    //hace que el movimiento sea aleatorio
    ang += random(-0.1, 0.1);
    x += cos(ang) * vel;
    y += sin(ang) * vel;
    //crea el efecto de escenario interminable
    if (x < -5) {
      x = 605;
    }
    else if (x > 605) {
      x = -5;
    }
    if (y < -5) {
      y = 605;
    }
    else if (y > 605) {
      y = -5;
    }
    //grafica al bichito 
    for (int i = 1; i < 9; i++) {
      posx[i] = posx[i-1];
      posy[i] = posy[i-1];
      fill(red(c), green(c), blue(c), 255/i);
      ellipse(posx[i], posy[i], 6./i, 6./i);
    }
    posx[0] = x;
    posy[0] = y;
    fill(c);
    ellipse(x, y, 6, 6);
  }
}

class comida {
  float x, y, cant;
  color c =  color(70, 90, 40);

  comida(float nx, float ny) {
    x = nx;
    y = ny;
    cant = 1000;
  }

  void act() {
    fill(c);
    ellipse(x, y, 2, 2);
  }
}

