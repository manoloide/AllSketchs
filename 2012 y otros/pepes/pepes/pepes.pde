Linea l1,l2,l3;
void setup(){

  size(600,600);
  l1 = new Linea(300,200,3);
  l2 = new Linea(150,400,5);
  l3 = new Linea(450,400,3);

}

void draw(){
  background(0);
  l1.agregar();
  l1.draw();
  l2.agregar();
  l2.draw();
  l3.agregar();
  l3.draw();
  delay(1);
}

class Linea{
  ArrayList puntos;
  int ran;
  
  Linea(int nx, int ny, int r){
    ran = r;
    puntos = new ArrayList(); 
    puntos.add(new Punto(nx,ny));  
  }
  
  void agregar(){
     int x,y,pos;
     Punto aux; 
     
     pos = puntos.size()-1;
     aux = (Punto) puntos.get(pos);
     
     x = aux.x + int(random(-ran,ran));
     y = aux.y + int(random(-ran,ran));
     
     puntos.add(new Punto(x,y));
     //if (pos > 20000){
     //  puntos.remove(0); 
     //}
  }
  
  void draw(){
    Punto aux1,aux2;
    int lar = puntos.size()-1;
    for(int i = 0; i < lar;i++){
       aux1 = (Punto) puntos.get(i);
       aux2 = (Punto) puntos.get(i+1);
       stroke((i/float(lar))*255,70,209);
       line(aux1.x,aux1.y,aux2.x,aux2.y);
    }
  }

}

class Punto{
  int x,y;
  
  Punto(int nx, int ny){
    x = nx;
    y = ny;
  } 
}
