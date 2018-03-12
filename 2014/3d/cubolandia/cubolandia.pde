ArrayList<Forma> formas;
Jugador jugador;
Plano plano;

void setup() {
	size(800, 600, P3D);
	//noCursor();
	jugador = new Jugador();
	formas = new ArrayList<Forma>();
	plano = new Plano(0,100,0);
	for(int i = 0; i < 30; i++){
		formas.add(new Forma(random(-1000, 1000), 50, random(-1000, 1000)));
	}
}

void draw() {
	if(frameCount%10 == 0) frame.setTitle("FPS: "+frameRate);
	background(0);
	pushMatrix();
	jugador.update();
	pointLight(51, 102, 126, 35, 40, 36);
	noStroke();
	lightFalloff(1.0, 0.001, 0.0);
	directionalLight(126, 126, 126, 0, 0, -1);
	ambientLight(102, 102, 102);
	plano.update();
	for(int i = 0; i < formas.size(); i++){
		Forma f = formas.get(i);
		f.update();
	}
	popMatrix();
	   hint(DISABLE_DEPTH_TEST);
   stroke(255);
   line(width/2, height/2-8, width/2, height/2+8);
   line(width/2-8, height/2, width/2+8, height/2);
   hint(ENABLE_DEPTH_TEST);
}

class Plano{
	float w, h; 
	PVector pos;
	Plano(float x, float y, float z){
		w = h = 3000;
		pos = new PVector(x, y, z);
	}
	void update(){
		draw();
	}
	void draw(){
		pushMatrix();
		translate(pos.x, pos.y, pos.z);
		beginShape(QUADS);
		vertex(w/2, 0, h/2);
		vertex(-w/2, 0, h/2);
		vertex(-w/2, 0, -h/2);
		vertex(w/2, 0, -h/2);
		endShape();
		popMatrix();
	}
};

class Forma{
	boolean eliminar; 
	float w, h, d;
	PVector pos;
	Forma(float x, float y, float z){
		w = h = d = 100;
		pos = new PVector(x, y, z);
	}
	void update(){
		draw();
	}
	void draw(){
		pushMatrix();
		translate(pos.x, pos.y, pos.z);
		beginShape(QUADS);
		vertex(-w/2, h/2, d/2);
		vertex(-w/2, h/2, -d/2);
		vertex(-w/2, -h/2, -d/2);
		vertex(-w/2, -h/2, d/2);

		vertex(w/2, h/2, d/2);
		vertex(w/2, h/2, -d/2);
		vertex(w/2, -h/2, -d/2);
		vertex(w/2, -h/2, d/2);

		vertex(w/2, -h/2, d/2);
		vertex(w/2, -h/2, -d/2);
		vertex(-w/2, -h/2, -d/2);
		vertex(-w/2, -h/2, d/2);
		
		vertex(w/2, h/2, d/2);
		vertex(w/2, h/2, -d/2);
		vertex(-w/2, h/2, -d/2);
		vertex(-w/2, h/2, d/2);

		vertex(w/2, h/2, -d/2);
		vertex(-w/2, h/2, -d/2);
		vertex(-w/2, -h/2, -d/2);
		vertex(w/2, -h/2, -d/2);

		vertex(w/2, h/2, d/2);
		vertex(-w/2, h/2, d/2);
		vertex(-w/2, -h/2, d/2);
		vertex(w/2, -h/2, d/2);
		endShape();
		popMatrix();
	}
};

class Jugador{
   float velocidad, mouseVel;
   float verAng, horAng, fov;
   PVector pos, dir, vel;
   Jugador(){
      pos = new PVector(0,0,0);
      dir = new PVector(0,0,0);
      vel = new PVector(0,0,0);
      verAng = PI;
      horAng = 0;
      fov = 45;
      velocidad = 4;
      mouseVel = 0.0005;
   }
   void update(){
      verAng += ((height/2-mouseY))*mouseVel;
      horAng += ((width/2-mouseX))*mouseVel;

      dir.x = cos(verAng)*sin(horAng);
      dir.y = sin(verAng);
      dir.z = cos(verAng)*cos(horAng);
      PVector der = new PVector(sin(horAng+PI/2), 0, cos(horAng+PI/2));
      PVector arr = der.cross(dir);
      
      PVector vel = new PVector(0,0,0);
      if(keyPressed){
         if(key == 'w'){
         	vel = dir.get();
         	vel.mult(velocidad);
         }
         if(key == 's'){
         	vel = dir.get();
         	vel.mult(-velocidad);
         }
         if(key == 'd'){
         	vel = der.get();
         	vel.mult(velocidad);
         }
         if(key == 'a'){
         	vel = der.get();
         	vel.mult(-velocidad);
         }
         //if(key == 's') vel = dir.mult(-velocidad);
      }
      pos.add(vel);
      pos.y = 0;
	  perspective(fov, float(width)/float(height), 0.1, 10000);
      camera(pos.x,pos.y,pos.z, pos.x+dir.x,pos.y+dir.y,pos.z+dir.z, 0,1,0);
   }
};
