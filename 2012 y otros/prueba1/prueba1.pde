ArrayList cosos;
void setup(){
  size(600,600);
   // Enable 4x oversampling (if supported)
  hint(ENABLE_OPENGL_4X_SMOOTH);
  background(0);
  cosos = new ArrayList();
  cosos.add(new Coso(300,400,256,270));
}

void draw(){
  for(int i = 0; i < cosos.size(); i++){
     Coso aux = (Coso) cosos.get(i); 
     aux.paint();
  }
  delay(60);
}

void mousePressed(){
    for(int i = 0; i < cosos.size(); i++){
     Coso aux = (Coso) cosos.get(i); 
     aux.click();
  }
}

class Coso {
  float x,y,radio,ang;
  color colorin;
  
  Coso(float nx, float ny, float nradio, float nang){
    x = nx;
    y = ny;
    radio = nradio;
    ang = nang;
    colorin = color(random(255),random(255),random(255));
  }
  
  void paint(){
    fill(this.colorin);
    noStroke();
    smooth();
    ellipse(x,y,radio,radio); 
  }
  
  void hacer(){
    float rad, nx, ny;
    rad = radio/2;
    ang = ang-30;
    nx = x+(cos(radians(ang))*(radio/2+rad/2));
    ny = y+(sin(radians(ang))*(radio/2+rad/2));
    cosos.add(new Coso(nx,ny,rad,ang));
    ang = ang+60;
    nx = x+(cos(radians(ang))*(radio/2+rad/2));
    ny = y+(sin(radians(ang))*(radio/2+rad/2));
    cosos.add(new Coso(nx,ny,rad,ang));
  }
  void click(){
    float dis = dist(x,y,mouseX,mouseY);
    if(dis < radio/2){
      hacer();
    }
  }
}
