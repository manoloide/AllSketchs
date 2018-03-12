color colSel;
Imagen aux; 

void setup(){
	size(800, 600);
	aux = new Imagen(width,height);
	aux.cargar("http://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Raunkiaer.jpg/250px-Raunkiaer.jpg");
	colSel = color(0);
	noStroke();
}

void draw(){
	if(frameCount%10 == 0) frame.setTitle("GameJam -- FPS: "+frameRate);
	image(aux.getImagen(),0,0);
	fill(colSel);
	rect(20,height-60,40,40);
}

void mousePressed(){
	absorver();
}

void absorver(){
	aux.sumar(colSel);
	colSel = aux.getColor(mouseX,mouseY);
	aux.restar(colSel);
}

class Color{
	int r, g, b;
	Color(int r, int g, int b){
		this.r = r; 
		this.g = g;
		this.b = b;
	}
	void sumar(color col){
		r += red(col);
		g += green(col);
		b += blue(col);
	}
	void restar(color col){
		r -= red(col);
		g -= green(col);
		b -= blue(col);
	}
	color get(){
		return color(r,g,b);
	}
}

class Imagen{
	int w, h;
	Color pixels[][];
	PImage img; 

	Imagen(int w, int h){
		this.w = w;
		this.h = h;
		pixels = new Color[w][h];
		for(int j = 0; j < h; j++){
			for(int i = 0; i < w; i++){
				pixels[i][j] = new Color(int(random(256)),int(random(256)),int(random(256)));
			}	 	
		} 
		generarImg();
	}
	void cargar(String src){
		PImage aux = loadImage(src);
		w = aux.width;
		h = aux.height;
		for(int j = 0; j < h; j++){
			for(int i = 0; i < w; i++){
				color colorin = aux.get(i,j);
				pixels[i][j] = new Color(int(red(colorin)),int(green(colorin)),int(blue(colorin)));
			}	 	
		} 
		generarImg();
	}	
	void sumar(color col){
		for(int j = 0; j < h; j++){
			for(int i = 0; i < w; i++){
				pixels[i][j].sumar(col);
			}	 	
		}
		generarImg();
	}
	void restar(color col){
		for(int j = 0; j < h; j++){
			for(int i = 0; i < w; i++){
				pixels[i][j].restar(col);
			}	 	
		}
		generarImg();
	}
	void generarImg(){
		img = createImage(w,h,RGB);
		img.loadPixels();
		for(int j = 0; j < h; j++){
			for(int i = 0; i < w; i++){
				img.set(i,j,pixels[i][j].get());
			}	 	
		} 
		img.updatePixels();
	}
	PImage getImagen(){
		return img;
	}
	color getColor(int x, int y){
		return img.get(x,y);
	}
}