import manoloide.Input.*;

ArrayList<Disparo> disparos;
ArrayList<Planeta> planetas;
float dt;
Input input;
Jugador jugador;
PFont helve;

void setup(){
   size(800, 600, P3D);
   smooth(16); 
   sphereDetail(32, 24);
   helve = createFont("Helvetica Neue Bold", 32, true);
   textFont(helve);
   input = new Input(this);
   jugador = new Jugador();
   disparos = new ArrayList<Disparo>();
   planetas = new ArrayList<Planeta>();
   for(int i = 0; i < 10; i++){
      planetas.add(new Planeta(random(-1000,1000),random(-1000,1000),random(-1000,1000), random(20, 400)));
   }
}

void draw(){
   lights();
   directionalLight(60, 60, 60, 0, 0, 1);
   ambientLight(40, 40, 40, -200, 0, 0);
   dt = 1/frameRate;
   if(frameCount%10 == 0) frame.setTitle("Nave -- FPS: "+frameRate);
   background(0);
   pushMatrix();
   jugador.update();
   for(int i = 0; i < planetas.size(); i++){
      Planeta p = planetas.get(i);
      p.update();
   }
   for(int i = 0; i < disparos.size(); i++){
      Disparo d = disparos.get(i);
      d.update();
   }
   popMatrix();
   hint(DISABLE_DEPTH_TEST);
   stroke(255);
   line(width/2, height/2-10, width/2, height/2+10);
   line(width/2-10, height/2, width/2+10, height/2);
   fill(255);
   textSize(10);
   textAlign(LEFT, TOP);
   text("Pitch: "+degrees(jugador.pitch)+"\nYaw: "+degrees(jugador.yaw), 20, 20);
   hint(ENABLE_DEPTH_TEST);
   input.update();
}

void keyPressed(){
   input.event(true);
}

void keyReleased(){
   input.event(false);
}

void mousePressed(){
   input.mpress();
}

void mouseReleased(){
   input.mreleased();
}

class Jugador{
   float velocidad;
   float pitch, yaw;
   PVector pos, rot, vel;
   Jugador(){
      pos = new PVector(0,0,0);
      rot = new PVector(0,0,0);
      vel = new PVector(0,0,0);
      velocidad = 0;
      pitch = yaw = 0;
   }
   void update(){
      pitch += ((height/2.-mouseY)/height)*dt*5;
      if(pitch > PI*1.5) pitch = PI*1.5;
      if(pitch < PI*0.5) pitch = PI*0.5
;
      yaw -= ((width/2.-mouseX)/width)*dt*5;
      if(yaw < 0) yaw = TWO_PI;
      else if(yaw >= TWO_PI) yaw %= TWO_PI;

      rot.x = cos(yaw)*cos(pitch);
      rot.y = sin(pitch);
      rot.z = sin(yaw)*cos(pitch);

      if(keyPressed){
         if(key == 'w') velocidad += 0.2;
         if(key == 's') velocidad -= 0.2;
      }else {
         velocidad *= 0.9;
      }

      if(input.ENTER.click){
         disparos.add(new Disparo(pos, rot));
      }

      vel.set(rot);
      vel.normalize();
      vel.mult(velocidad);
      pos.add(vel);

      perspective(45, float(width)/float(height), 0.1, 10000);
      camera(pos.x,pos.y,pos.z, pos.x+rot.x,pos.y+rot.y,pos.z+rot.z, 0,1,0);
   }
}

class Disparo{
   float velocidad;
   PVector pos, ang, vel;
   Disparo(PVector pos, PVector ang){
      this.pos = new PVector(0,0,0);
      this.ang = new PVector(0,0,0);
      this.vel = new PVector(0,0,0);
      this.pos.set(pos);
      this.ang.set(ang);
      velocidad = 2;
      vel.set(ang);
      vel.normalize();
      vel.mult(velocidad);
   }
   void update(){
      pos.add(vel);
      draw();
   }
   void draw(){
      strokeWeight(4);
      stroke(255);
      PVector cola = new PVector(0,0,0);
      cola.set(pos);
      cola.sub(vel);
      cola.sub(vel);
      cola.sub(vel);
      cola.sub(vel);
      line(pos.x, pos.y, pos.z, cola.x, cola.y, cola.z);
   }
}

class Planeta{
   color col; 
   float dim;
   String name;
   PVector pos;
   Planeta(float x, float y, float z, float dim){
      pos = new PVector(x,y,z);
      this.dim = dim;

      name = char(int(random(97, 123)))+"-"+int(random(1000));
      col = color(random(256),random(256),random(256));
   }
   void update(){
      draw();
   }
   void draw(){
      pushMatrix();
      translate(pos.x,pos.y,pos.z);
      noStroke();
      fill(col);
      sphere(dim);
      PVector rot = new PVector(0,0,0);
      rot.set(jugador.pos);
      rot.sub(pos);
      rot.normalize();
      rot.mult(dim*1.3);
      translate(rot.x, rot.y, rot.z);
      /*
      rotateX(rot.x);
      rotateY(rot.y);
      rotateZ(rot.z);
      translate(0, -dim*1.3, 0);
      */
      fill(255, 200);
      textAlign(CENTER,CENTER);
      textSize(dim/4);
      text(name,0,0);
      popMatrix();
   }
}
