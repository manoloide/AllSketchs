/***********************
 + Manoloide 2013.     +
 + Gamboa Naon, Manuel +
 + manoloide.com.ar    +
 + manoloide@gmail.com +
 ***********************/
/* materiales

*/


/*
cosas por hacer:
	picar
	recolectar materiales
	crafteos
	iluminacion
	gui

ideas:
	chat
	rayo
bugs:
	colision pero no se bien cual es
*/

final String nombre = "Mineria";
final String version = "Alpha 0.1";

Jugador j1;
Mundo m;

void setup(){
	size(800,600);
	noStroke();
	frame.setResizable(true);
	j1 = new Jugador(0,0);
	m = new Mundo(16,16);
}

void draw(){
	background(0);
	if(frameCount%10 == 0){
		frame.setTitle(nombre + " " + version + " -- FPS: " + frameRate);
	}
	j1.act();
	m.act();
	m.dibujar();
	j1.dibujar();
}

void mousePressed(){
	int tx = int(j1.x+mouseX-width/2); 
	int ty = int(j1.y+mouseY-height/2);
	if(tx >= 0){
		tx = (tx/16)%m.w;
	}else{
		tx = m.w+((tx/16)%m.w)-1;
	}
	if(ty >= 0){
		ty = (ty/16)%m.h;
	}else{
		ty = m.h+((ty/16)%m.h)-1;
	}
	if(m.tiles[tx][ty] != null){
		m.tiles[tx][ty] = null;
	}else{
		m.tiles[tx][ty] = new Tile();
	}
	println(tx,ty);
}

void keyPressed(){
	if(key == 'w' || key == 'W'){
		j1.arriba = true;
	}else if(key == 's' || key == 'S'){
		j1.abajo = true;
	}else if(key == 'd' || key == 'D'){
		j1.derecha = true;
	}else if(key == 'a' || key == 'A'){
		j1.izquierda = true;
	}
}

void keyReleased(){
	if(key == 'w' || key == 'W'){
		j1.arriba = false;
	}else if(key == 's' || key == 'S'){
		j1.abajo = false;
	}else if(key == 'd' || key == 'D'){
		j1.derecha = false;
	}else if(key == 'a' || key == 'A'){
		j1.izquierda = false;
	}
}