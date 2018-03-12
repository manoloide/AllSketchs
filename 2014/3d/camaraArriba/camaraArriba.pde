Camara camara;
int matriz[][];
int tam = 100;
int posx, posy;

void setup() {
	size(800, 600, P3D);
	camara = new Camara();
	matriz = new int[width/tam*2][height/tam*2];
	for(int j = 0; j < matriz[0].length; j++){
		for(int i = 0; i < matriz.length; i++){
			matriz[i][j] = int(random(2));
		}
	}
}

void draw() {
	background(#181F16);
	directionalLight(32, 32, 32, 1, 0, -1);
	directionalLight(64, 64, 64, 0, -1, 0);
	directionalLight(126, 126, 126, 0, 0, -1);
	ambientLight(102, 102, 102);
	camara.update();
	translate(posx, posy);
	drawMatriz();
}

void keyPressed(){
	int vel = 5;
	if(keyCode == LEFT) posx += vel;
	if(keyCode == RIGHT) posx -= vel;
	if(keyCode == UP) posy += vel;
	if(keyCode == DOWN) posy -= vel;
}

void drawMatriz(){
	noStroke();
	fill(#A7D297);
	for(int j = 0; j < matriz[0].length; j++){
		for(int i = 0; i < matriz.length; i++){
			if(matriz[i][j] != 0){
				pushMatrix();
				translate(i*tam, j*tam, 0);
				box(tam);
				popMatrix();
			}
		}
	}
}

class Camara{
	float x, y, z;
	Camara(){
		x = y = z = 0;
	}

	void update(){
		translate(x, y, z);
	}

	void mover(float mx, float my, float mz){
		float dd = 0.3;
		x = (x-mx)*dd; 
		y = (y-my)*dd; 
		z = (z-mz)*dd;
	}

	void pos(float x, float y, float z){
		this.x = x; 
		this.y = y; 
		this.z = z;
	}
}
