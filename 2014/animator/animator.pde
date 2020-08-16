/*

-guardar todo en json
-seleccion keyframes moverlos borrarlos ect
-agregar form y animar beziers
-manejar los colores
-separar la generacion de formas del dibujo para hacer un prepocesado de los puntos
-agregar images
-crear mas modulos 
-crear efectos
-armar el prerender
-agregar motionblur
-exportar a imagenes
-seleccionar la escla a exportar



*/

ArrayList<Element> elements;
Camera camera;
Input input;
Timeline timeline;
Video video;

boolean play;

void setup() {
  size(720, 480);
  input = new Input();
  video = new Video(400, 300, 60*5);
  camera = new Camera(width/2-video.w/2, height/2-video.h/2);
  frame.setResizable(true);
  timeline = new Timeline();
  elements = new ArrayList<Element>();
  elements.add(new Poly());
  elements.add(new Poly());
}

void draw() {
  if(frameCount%20 == 0) frame.setTitle("Animator  --  FPS: "+round(frameRate));
  background(200);
  pushMatrix();
  camera.update();
  if(input.ENTER.click) play = !play;
  if(input.LEFT.click && video.frame > 0) video.frame--;
  if(input.RIGHT.click && video.frame < video.frames-1) video.frame++;
  if(play) video.frame = (video.frame+1)%video.frames;
  noStroke();
  fill(255);
  rect(0,0,video.w, video.h);
  stroke(0);
  //image(video.iframes[video.frame],0,0);
  for(int i = 0; i < elements.size(); i++){
    Element e = elements.get(i);
    e.update();
    if(e.remove) elements.remove(i--);
  }
  popMatrix();
  timeline.update();
  input.act();
}
void keyPressed() {
  input.event(true);
}
void keyReleased() {
  input.event(false);
}

void mousePressed() {
  input.mpress();
}
void mouseReleased() {
  input.mreleased();
}
void mouseDragged(){
  if(mouseButton == CENTER){
    camera.move(mouseX-pmouseX,mouseY-pmouseY);
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if(e > 0) e = 0.95;
  else e = 1.05;
  float azoom = camera.scale;
  float zoom = camera.scale*e;
  float dx = -(((mouseX-camera.x)/(width*azoom))*(width*zoom - width*azoom));
  float dy = -(((mouseY-camera.y)/(height*azoom))*(height*zoom - height*azoom));
  camera.move(dx, dy);
  camera.scale = zoom;
}

void saveProyect(){
  JSONObject proyect = new JSONObject();
  JSONArray jelements = new JSONArray();
  for(int i = 0; i < elements.size(); i++){
    Element e = elements.get(i);
    jelements.append(e.getJson());
  }
  proyect.setInt("width", video.w);
  proyect.setInt("height", video.h);
  proyect.setJSONArray("elements", jelements);
}

class Timeline{
  boolean on, move;
  int x, y, w, h; 
  int titleHeight, elementWidth, elementHeight;

  int selectedFrame;
  Timer selected;
  Timeline(){
    titleHeight = 22;
    elementWidth = 220;
    elementHeight = 22;
    selected = null;
  }
  void update() {
    w = width;
    h = 200;
    x = 0;
    y = height-h;
    if(input.click && mouseX >= x+elementWidth && mouseY > y+titleHeight){
      move = true;
    }
    if(input.released){
      move = false;
    }
    if(move){
      video.frame = constrain(round(map(mouseX, elementWidth, w, 0, video.frames)), 0, video.frames-1);
    }
    int des = 0;
    for(int i = 0; i < elements.size(); i++){
      Element e = elements.get(i);
      boolean hide = e.gui.hide;
      if(input.dclick && mouseX >= x && mouseX < x+elementWidth && mouseY >= y+titleHeight+elementHeight*des && mouseY < y+titleHeight+elementHeight*(des+1)){
        hide = !hide;
        e.gui.hide = hide;
      }
      des++;
      if(!hide){
        for(int j = 0; j < e.gui.properties.size(); j++){
          float desy = y+titleHeight+elementHeight*des;
          if(input.press && input.amouseX >= x+elementWidth-60 && input.amouseX < x+elementWidth && input.amouseY >= desy && input.amouseY < desy+elementHeight){
            Timer t = e.gui.properties.get(j);
            if(t instanceof BooleanTimer){
              boolean vall = false;
              if(mouseX > input.amouseX) vall = true;
              BooleanTimer bt = (BooleanTimer) t;
              bt.add(video.frame, vall);
            }
            if(t instanceof FloatTimer){
              FloatTimer ft = (FloatTimer) t;
              float vall = ft.getValue(video.frame)+(mouseX-pmouseX);
              ft.add(video.frame, vall);
            }
            if(t instanceof IntegerTimer){
              IntegerTimer it = (IntegerTimer) t;
              int vall = it.getValue(video.frame)+(mouseX-pmouseX);
              it.add(video.frame, vall);
            }
          }
          if(selected == null){
            for(int k = 0; k < e.gui.properties.get(j).size(); k++){
              Timer t = e.gui.properties.get(j);
              int pf = t.keys.get(k);
              if(input.click && dist(mouseX, mouseY, getPosition(pf), desy+elementHeight/2) <= 8){
                selected = t;
                selectedFrame = pf;
                break;
                //t.moveKey(pf, pf+2);
                //e.gui.timers.get(j).keys.get(k)
              }
              //ellipse(getPosition(pf), desy+elementHeight/2, 8, 8);
            }
          }else{
            selected.moveKey(selectedFrame, video.frame);
            selectedFrame = video.frame;
            if(input.released){
              selected = null;
            }
          }
          des++;
        }
      }
    }
    draw();
  }
  void draw(){
    //background
    noStroke();
    int col = 50;
    fill(col);
    rect(x+elementWidth, y+titleHeight, w-elementWidth,h-titleHeight);
    strokeCap(SQUARE);
    strokeWeight(1);
    stroke(col-10);
    line(x+elementWidth, y+titleHeight, x+elementWidth, y+h);

    float lineTimeX = getPosition(video.frame);
    stroke(#FBE360);
    strokeWeight(2);
    line(lineTimeX, height-h+titleHeight+1, lineTimeX, height);

    fill(44);
    noStroke();
    strokeWeight(1);
    int des = 0;
    col = 60;
    textAlign(LEFT, TOP);
    textSize(14);
    for(int i = 0; i < elements.size(); i++){
      Element e = elements.get(i);
      boolean hide = e.gui.hide;
      noStroke();
      fill(col);
      rect(x, y+titleHeight+elementHeight*des, elementWidth, elementHeight);
      stroke(col+10);
      line(x, y+titleHeight+elementHeight*des, x+elementWidth-1, y+titleHeight+elementHeight*des);
      stroke(col-10);
      line(x, y+titleHeight+elementHeight*(des+1)-1, x+elementWidth-1, y+titleHeight+elementHeight*(des+1)-1);
      fill(240);
      String name = elements.get(i).name;
      text(name, x+8, y+titleHeight+elementHeight*des+2);
      noStroke();
      if(hide) poly(x+textWidth(name)+16, y+titleHeight+elementHeight*(des+0.5), 10, 3, 0);
      else poly(x+textWidth(name)+16, y+titleHeight+elementHeight*(des+0.5), 10, 3, -PI/6);
      des++;
      if(!hide){
        for(int j = 0; j < e.gui.properties.size(); j++){
          float desy = y+titleHeight+elementHeight*des;
          for(int k = 0; k < e.gui.properties.get(j).size(); k++){
            int pf = e.gui.properties.get(j).keys.get(k);
            noStroke();
            fill(#FBE360);
            if(dist(mouseX, mouseY, getPosition(pf), desy+elementHeight/2) <= 8) stroke(#F1E497);
            ellipse(getPosition(pf), desy+elementHeight/2, 8, 8);
          }
          noStroke();
          fill(col-5);
          rect(x, desy, elementWidth, elementHeight);
          fill(240);
          text(e.gui.properties.get(j).name, x+20, desy);
          pushStyle();
          textAlign(RIGHT, TOP);
          fill(#FBE360);
          text(e.gui.properties.get(j).getStringValue(video.frame), x+elementWidth-6, desy);
          popStyle();
          des++;
        }
      }
    }
    if(y+titleHeight+elementHeight*des < height){
      fill(80);
      float yy = y+titleHeight+elementHeight*des;
      rect(x, yy, elementWidth, height-yy);
    }

    //bar title
    col = 44;
    fill(col);
    rect(x, y, w,titleHeight);
    stroke(col+10);
    line(x, y, x+w, y);
    stroke(col-10);
    line(x, y+titleHeight, x+w, y+titleHeight);
    fill(250);
    textAlign(LEFT, TOP);
    textSize(16);
    text("Timeline", 8, y+2);
  }

  float getPosition(int frame){
    return x+elementWidth+((w-elementWidth)*1./video.frames) * frame;
  }
};

class Camera{
  float x, y;
  float scale;
  Camera(){}
  Camera(float x, float y){
    this.x = x;
    this.y = y;
    scale = 1;
  }
  void update(){
    translate(x, y);
    scale(scale);
  }
  void move(float mx, float my){
    x += mx;
    y += my;
  }
};

class Element{
  ArrayList<Timer> properties;
  boolean remove;
  BooleanTimer view;
  GuiElement gui;
  String name;
  void update(){}
  void draw(){}
  JSONObject getJson(){return null;}
  void setJson(JSONObject jo){}
};

class Poly extends Element{
  FloatTimer x, y, dim, ang;
  IntegerTimer amount;
  Poly(){
    name = "Poly";
    properties = new ArrayList<Timer>();
    
    view = new BooleanTimer("view", true);
    x = new FloatTimer("x", video.w/2);
    y = new FloatTimer("y", video.h/2);
    dim = new FloatTimer("dim", 20);
    ang = new FloatTimer("ang");
    amount = new IntegerTimer("amount",3);
    amount.setMin(3);

    properties.add(view);
    properties.add(x);
    properties.add(y);
    properties.add(dim);
    properties.add(ang);
    properties.add(amount);

    gui = new GuiElement(this);
    /*
    for(int i = 0; i < video.frames; i+=int(random(3, 8))){
      if(random(1) < 0.95) view.add(i, true);
      else view.add(i, false);
      if(random(1) < 0.1) x.add(i, random(10, 400));
      if(random(1) < 0.1) y.add(i, random(10, 300));
      if(random(1) < 0.1) dim.add(i, random(10, 300));
      if(random(1) < 0.1) ang.add(i, random(TWO_PI));
      if(random(1) < 0.1) amount.add(i, int(random(3, 9)));
    }*/

  }
  void update(){
    draw();
  }
  void draw(){
    int f = video.frame;
    if(!view.getValue(f)) return;
    poly(x.getValue(f), y.getValue(f), dim.getValue(f), amount.getValue(f), ang.getValue(f));
  }
};

class GuiElement{
  ArrayList<Timer> properties;
  boolean hide;
  Element element;
  GuiElement(Element element){
    this.element = element;
    properties = element.properties;
  }/*
  void add(Timer e){
    properties.add(e);
  }
  */
};
