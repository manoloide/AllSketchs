float dx, dy;
int cw, ch, tt;
int matrix[][];

void setup() {
	size(600, 600);
	tt = 40;
	cw = (width/tt)-1;
	ch = (height/tt)-1;
	dx = (width-cw*tt)/2;
	dy = (height-ch*tt)/2;
	matrix = new int[cw][ch];
	generar();
}

void draw() {
	background(20);
	stroke(#FFB545);
	strokeWeight(6);
	for(int j = 0; j < ch; j++){
		for(int i = 0; i < cw; i++){
			int ddx, ddy;
			ddx = ddy = 0;
			switch (matrix[i][j]) {
				case 0:
					ddx = -1;
					ddy = -1;
					break;
				case 1:
					ddx = -1;
					ddy = 0;
					break;
				case 2:
					ddx = -1;
					ddy = 1;
					break;
				case 3:
					ddx = 0;
					ddy = 1;
					break;
				case 4:
					ddx = 1;
					ddy = 1;
					break;
				case 5:
					ddx = 1;
					ddy = 0;
					break;
				case 6:
					ddx = 1;
					ddy = -1;
					break;
				case 7:
					ddx = 0;
					ddy = -1;
					break;
			}
			float xx = dx+i*tt+tt/2;
			float yy = dy+j*tt+tt/2;
			float xx2 = dx+(i+ddx)*tt+tt/2;
			float yy2 = dy+(j+ddy)*tt+tt/2;
			line(xx,yy,xx2,yy2);
		}
	}
	for(int j = 0; j < ch; j++){
		for(int i = 0; i < cw; i++){
			float xx = dx+i*tt+tt/2;
			float yy = dy+j*tt+tt/2;
			ellipse(xx, yy, 16, 16);	
		}
	}
}

void keyPressed(){
	if(key == 's') saveFrame();
	else generar();
}

void generar(){
	for(int j = 0; j < ch; j++){
		for(int i = 0; i < cw; i++){
			matrix[i][j] = int(random(8));
		}
	}
}