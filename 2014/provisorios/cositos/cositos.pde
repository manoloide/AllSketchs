import manoloide.Color.Paleta;
int seed = int(random(9999999));
Paleta paleta;
void setup() {
	size(600 , 600);
	paleta = new Paleta(#CF000F, #D5C8C0, #9C8F87, #F9BF3B, #661736);
	generar();
}

void draw() {
	saveFrame("#####");
}

void generar(){
	randomSeed(seed);
	noiseSeed(seed);
	background(paleta.rcol());
	for(int i = 0; i < 10000; i++){
		float x = random(width);
		float y = random(height);
		strokeWeight(2);
		float val = noise(x*0.005, y*0.005); 
		if(val > 0.6){
			stroke(paleta.rcol());
			line(x, y, x+40, y+40);
		}
	}
	randomSeed(seed);
	noiseSeed(seed);
	for(int i = 0; i < 10000; i++){
		float x = random(width);
		float y = random(height);
		noStroke();
		float val = noise(x*0.005, y*0.005); 
		if(val > 0.6){
			fill(paleta.rcol());
			ellipse(x, y, 8*val, 8*val);
		}
	}
}

void keyPressed(){
	if(key == 's') saveFrame(seed+".png");
	else {
		seed = int(random(9999999));
		thread("generar");
	}
}

