void setup(){
	size(600, 800);
	generar();
}

void draw(){
		
}

void keyPressed(){
	if(key == 's') saveFrame("#######");
	else generar();
}

void generar(){
	float x = width/2;
	float y = height/2;
	float diag = dist(0,0, width, height);
	float lar = 20;
	int cant = int(diag/lar)+1;
	color c1 = color(random(256), random(256), random(256));
	color c2 = color(random(256), random(256), random(256));
	for(int j = 0; j < cant; j++){
		color col = lerpColor(c1, c2, map(j, 0, cant-1, 0, 1));
		float dis = j*lar;
		int cc = int(dis*PI);
		float da = TWO_PI/cc;
		stroke(col);
		strokeWeight(3);
		for(int i = 0; i < cc; i++){
			float ang = da*i;
			float ll = lar + random(-1, 1);
			line(x+cos(ang)*ll*j, y+sin(ang)*ll*j, x+cos(ang)*ll*(j+1), y+sin(ang)*ll*(j+1));
		}
	}
}