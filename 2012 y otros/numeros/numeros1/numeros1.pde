ArrayList bichitos;

float ran = 0.0;

String comando = "numero 3 digitos + enter";



void setup() {
  size(400, 400);

  bichitos = new ArrayList();

  //smooth();
  noStroke(); 
  textAlign(CENTER);
}

void draw() {
  fill(0,10);
  rect(0,0,width,height);
  
  ran += random(0.01);
  
  for (int i = 0; i < bichitos.size(); i++) {
    bichito aux = (bichito) bichitos.get(i);
    aux.act();
    if (aux.vid <= 0) {
      bichitos.remove(i);
      i--;
      println("MURIO");
    }
  }
  //numero 
  fill(255, 120);
  text(comando, width/2, height/2);
}



void keyPressed() {
  if (comando.length()>10) {
    textSize(56);
    comando = "";
  }
  if (key == '\n' && comando.length() == 3) {
    bichitos.add(new bichito(int(comando)));
    comando = "";
  } 
  else if (keyCode == BACKSPACE) {
    int lar = comando.length();
    if (lar > 0) {
      comando = comando.substring(0, lar-1);
    }
  }
  else if (key >= '0' && key <= '9' && comando.length() < 3) {
    comando += key;
  }
}


class bichito {
  float x, y, tam, vel, fue, vid, ang;
  color col;

  bichito(int num) {
    int n1, n2, n3;
    n1 = int(num/100);
    n2 = int((num%100)/10);
    n3 = int(num%10);

    col = color((n1/10.)*256, (n2/10.)*256, (n3/10.)*256);

    tam = n1*3+10;
    vel = float((n2+1)*5)/tam;
    fue = n3;
    vid = tam;

    println(tam+" "+vel+" "+fue+" "+vid);

    x = random(width);
    y = random(height);
    ang = random(TWO_PI);
  }

  void act() {
    //mover
    bichito bmin = null;
    float dismin = 10000;
    for (int i = 0; i < bichitos.size(); i++) {
      bichito aux = (bichito) bichitos.get(i);
      if ( aux != this) {
        float dis = dist(aux.x, aux.y, x, y);
        if (dismin > dis && dis < (tam+aux.tam)*2) {
          dismin = dis;
          bmin = aux;
        }
      }
    }
    //
    ang += noise(ran*tam/fue)-0.5;
    ang = ang%TWO_PI;
    if (ang < 0) {
      ang+=TWO_PI;
    }
    //desviar
    if (bmin != null ) {
      float dang = atan2(y-bmin.y, x-bmin.x);
      if (dang < 0) {
        dang+=TWO_PI;
      }
      //aca tiene que variar el angulo con respecto a eso
      float valor;
      dang = (dang + ang)/2;
      if (ang < dang) {
        valor = abs(dang-ang)/3;
      }
      else {
        valor = -abs(dang-ang)/3;
      }

      if ( fue >= bmin.fue) {
        ang -= valor;
        if (dist(x, y, bmin.x, bmin.y) < (tam+bmin.tam)/2) {
          bmin.vid -= fue;
          fue += valor;
        }
      }
      else {
        ang += valor;
      }
    }
    //
    x -= cos(ang)* vel;
    y -= sin(ang)* vel;
    //bordes
    if ( x < -40) {
      x = width+40;
    }
    else if ( x > width+40) {
      x = -40;
    }
    if ( y < -40) {
      y = height+40;
    }
    else if ( y > height+40) {
      y = -40;
    }
    //dibujar
    fill(col);
    ellipse(x, y, tam, tam);
  }
}

