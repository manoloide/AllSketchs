class Jugador{
	boolean arriba, abajo, derecha, izquierda;
	float x, y;
	float velocidad;
	Jugador(float x, float y){
		this.x = x; 
		this.y = y;
		velocidad = 1;
	}
	void act(){
		float xx = 0, yy = 0;
		if(derecha){
			xx += velocidad;
		}else if(izquierda){
			xx -= velocidad;
		}else if(arriba){
			yy -= velocidad;
		}else if(abajo){
			yy += velocidad;
		}
		if(!m.colision(this,xx,yy)){
			x += xx;
			y += yy;
			/*
			if(x < 0){
				x += m.w * 16;
			}else if(x >= m.w * 16){
				x -= m.w * 16;
			}
			if(y < 0){
				y += m.h * 16;
			}else if(y >= m.h * 16){
				y -= m.h * 16;
			}
			*/
		}
	}
	void dibujar(){
		fill(255);
		rect(width/2-16,height/2-16,32,32);
	}
}