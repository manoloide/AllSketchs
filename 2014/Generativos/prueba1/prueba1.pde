void setup(){
	size(600,800);
}

void draw(){
	background(#1B214B);
	noFill();
	stroke(#F0F0E8,40);
	int x = 500;//width/2;
	int y = 180;//40;
	strokeWeight(0.8);
	for(int i = 0; i< height*2; i+= 30){
		ellipse(x,y,i,i);
	}
	float a = TWO_PI/40;
	for(int i = 0; i < 40; i++){
		float ang = a*i;
		strokeWeight((i%4+1)/4);
		line(x+cos(ang)*15, y+sin(ang)*15,x+cos(ang)*height, y+sin(ang)*height);
	}
	noStroke();
	a = TWO_PI/40;
	for(int i = 0; i < 40; i++){
		float ang = a*i;
		for(int j = 0; j < 100; j++){
			float dis = random(15,height);
			float tam = random(dis/height) *100;
			float alp = dis%30;
			fill(#F7E7CE,alp);
			ellipse(x+cos(ang)*dis, y+sin(ang)*dis, tam, tam);
		}
	}
}