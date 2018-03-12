class Mundo{
	int w, h, dx, dy;
	Tile tiles[][];
	Mundo(int w, int h){
		this.w = w; 
		this.h = h;
		tiles = new Tile[w][h];

		//tiles[5][5] = new Tile();
		tiles[15][15] = new Tile();
		/*
		for(int i = 0; i < w*h; i++){
			if(random(5)< 1){
				tiles[i%w][i/h] = new Tile();
			}
		}*/
	}
	void act(){
		dx = int(-j1.x)+width/2;
		dy = int(-j1.y)+height/2;
	}
	void dibujar(){
		int x1, y1, x2, y2;
		x1 = int(j1.x-width/2)/16-1;
		y1 = int(j1.y-height/2)/16-1;
		x2 = int(j1.x+width/2)/16+1;
		y2 = int(j1.y+height/2)/16+1;
		for (int j = y1; j<y2; j++){
			int ty = j%h;
			if(j < 0){
				ty = (j+1)%h;
				ty = h-abs(ty)-1;
			}
			for (int i = x1; i<x2; i++){
				int tx = i%w;
				if(i < 0){
					tx = (i+1)%w;
					tx = w-abs(tx)-1;
				}
				if(tiles[tx][ty] != null){
					image(tiles[tx][ty].img,dx+i*16,dy+j*16);
				}
			}
		}
	}
	boolean colision(Jugador j, float xx, float yy){
		int px = int(j1.x/16);
      	int py = int(j1.y/16);
      	int tx = int(j1.x);
      	int ty = int(j1.y);
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
		//println(tx,ty);
		for (int h = -2; h<2; h++){
			for (int w = -2; w<2; w++){
				
				fill(255,0,0);
				rect(dx+(px+w)*16,dy+(py+h)*16,16,16);
				fill(0,255,0);
				rect(width/2-16+xx,height/2-16+yy,32,32);
				
				int ax, ay;
				if(px < 0){
					ax = (tx+w+m.w+1)%m.w;
				}
				else{
					ax = (tx+w+m.w)%m.w;
				}
				if(py < 0){
					ay = (ty+h+m.h+1)%m.h;
				}
				else{
					ay = (ty+h+m.h)%m.h;
				}
				//println(ax, ay);
				if(tiles[ax][ay] != null){
					//println(frameCount,ax,ay,w+2,h+2);
					if(colisionRectangulo(width/2-16+xx,height/2-16+yy,32,32,dx+(px+w)*16,dy+(py+h)*16,16,16)){
						//println(frameCount,ax,ay,tx,ty);
						return true;
					}
				}
			}
		}
		return false;
	}
}

boolean colisionRectangulo(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2){
    if ((x1 < x2+w2) && (x2 < x1+w1) && (y1 < y2 + h2)){
        return y2 < y1 + h1;
    }
    return false;
}