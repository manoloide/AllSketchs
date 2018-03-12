int col[] = {#E55D97,#5FC3E4};

void setup(){
	size(600, 600);
	generar();
}

void draw(){
}

void keyPressed(){
	if(key == 's') saveImage();
	else generar();
}

void generar(){
	background(rcol());
	strokeWeight(2);
	rectMode(CENTER);
	for(int i = 0; i < 300; i++){
		stroke(rcol());
		fill(rcol());
		int r = int(random(3));
		if(r == 0){
			float tt = random(20, 80);
			ellipse(random(width),random(height), tt, tt);
		}else if(r == 1){
			float tt = random(20, 80);
			float bor = tt*random(0.05, 0.2);
			rect(random(width),random(height), tt, tt, bor);
		}
	}

}

void saveImage(){
	File f = new File(sketchPath);
	int num = f.listFiles().length - 1;
	saveFrame("l"+num+".png");
}

int rcol(){
	return col[int(random(col.length))];
}
