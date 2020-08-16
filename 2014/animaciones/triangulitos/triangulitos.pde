boolean grabar = false;
int seed;
int paleta[] = {#029978, #342D27, #F9F3CF, #FFB007, #F8411F};//{#D2283C, #FF6C01, #FFA201, #34B36C, #3481B3};

void setup(){
	size(1280/1, 720/1);
	frameRate(30);
	textFont(createFont("Helvetica Neue Bold", height*0.08, true));
	seed = 3;//int(random(999999999));
}

void draw(){
	if(frameCount%15 == 0) frame.setTitle("fps: "+frameRate);
	background(200, 200, 20);
	randomSeed(seed);
	for(int i = 0; i < 200; i++){
		float x = noise(i*random(200)+(frameCount*0.002))*width*2-width/2;
		float y = noise(i*random(200)+(frameCount*0.002))*height*2-height/2;
		float ttt = constrain((frameCount-0)/200., 0, 1);
		float d = width*random(0.001, 0.05)*ttt;
		int cant = int(random(3, 12));
		strokeCap(SQUARE);
		stroke(paleta[int(random(paleta.length))]);
		strokeWeight(d*random(0.4, 0.7));
		line(x+d, y+d, x-d, y-d);
		line(x+d, y-d, x-d, y+d);
	}
	for(int i = 0; i < 20; i++){
		float x = noise(i*random(200)+(frameCount*0.01))*width;
		float y = noise(i*random(200)+(frameCount*0.01))*height;
		float ttt = constrain(frameCount/360., 0, 1);
		float d = width*random(0.05, 0.35)*ttt*map(i, 0, 20, 2, 0.1);
		int cant = int(random(3, 12));
		float e = random(10, 400);
		float ang = random(TWO_PI)+frameCount*random(0.02);
		float vel = random(0.3)*random(1);
		polyAnimado(x, y, d, cant, e, ang, vel);
	}
	for(int i = 0; i < 20; i++){
		float x = noise(i*random(200)+(frameCount*0.005))*width;
		float y = noise(i*random(200)+(frameCount*0.005))*height;
		float ttt = constrain((frameCount-300)/40., 0, 1);
		float d = width*random(0.01, 0.05)*ttt;
		int cant = int(random(3, 12));
		noStroke();
		fill(250, 80);
		ellipse(x, y, d, d);
		fill(250);
		ellipse(x, y, d*0.80, d*0.80);
	}
	if(frameCount < 60){//30*15){
		int frame = frameCount-20;//30*15;
		int cant = 12;
		int hh = height/cant;
		noStroke();
		for(int i = 0; i < cant; i++){
			fill(paleta[int(random(paleta.length))]);
			float des = cos(constrain(map(frame, 0+i*2, 10+i*2, 0, 1), 0, PI/2))*width;
			rect(0, i*hh, des, hh);
		}
	}

	if(frameCount > 30*15){
		int frame = frameCount-30*15;
		int cant = 12;
		int hh = height/cant;
		float desy = sin(constrain(map(frame, 30+cant*2, 10+cant*2+44, 0, 1), 0 , PI/2))*height;
		noStroke();
		for(int i = 0; i < cant; i++){
			fill(paleta[int(random(paleta.length))]);
			float des = sin(constrain(map(frame, 0+i*2, 10+i*2, 0, 1), 0, HALF_PI))*width;
			rect(0, i*hh-desy, des, hh+1);
			if(i == cant-1) rect(0, (i+1)*hh-desy, des, height);
			//rect(width-des, i*hh, des, hh);
		}if(desy > 0){
			fill(220, 140);
			textAlign(CENTER, CENTER);
			text("Manoloide - 2014", width/2, height*1.5-desy);
		}
		if(frame > 10+cant*2+80) exit();
	}
	if(grabar) saveFrame("####.png");
}
void keyPressed(){
	frameCount = 0;
	//seed = int(random(999999999));
}
void polyAnimado(float x, float y, float dim, int cant, float des, float ang, float vel){
	int cc = int(dim/des);
	stroke(0, 6);
	noFill();
	for(int i = 5; i > 0; i--){
		strokeWeight(i);
		poly(x, y, dim, cant, ang);
	}
	noStroke();
	fill(paleta[int(frameCount*vel-1)%paleta.length]);
	poly(x, y, dim, cant, ang);
	for(int i = 0; i <= cc; i++){
		noStroke();
		fill(paleta[int(i+frameCount*vel)%paleta.length]);
		float dd = dim-des*(i+1-(frameCount*vel)%1);
		if(dd > 0) poly(x, y, dd, cant, ang);
	}
	//fill(paleta[int(cc+frameCount*vel)%paleta.length]);
	//poly(x, y, des*((frameCount*vel)%1), cant, ang);
}


void poly(float x, float y, float dim, int cant, float ang){
	float r = dim/2;
	float da = TWO_PI/cant;
	beginShape();
	for(int i = 0; i < cant; i++){
		vertex(x+cos(ang+da*i)*r, y+sin(ang+da*i)*r);
	}
	endShape(CLOSE);
}


