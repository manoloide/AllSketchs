int seed = 0;

void setup() {
	size(800, 600);
	generarMundo();
}

void draw() {
	
}

void keyPressed(){
	seed++;
	generarMundo();
}

void generarMundo(){
	int x = 0;
	int y = 0;
	int tt = 20;

	float noise1[][] = generarNoise(seed, width, height, 0.005);
	float noise2[][] = generarNoise(seed+1, width, height, 0.005);

	colorMode(HSB, 256);
	for(int j = 0; j < height; j++){
		for(int i = 0; i < width; i++){
			color col;
			int minAgua = 120;
			float val = noise1[i][j]*255;
			if(val > minAgua){
				col = color(minAgua+(170-minAgua), 200, 200-(-minAgua+val));
			}else{
				col = color(val, 200, 200);
			}
			set(i,j, col);
		}
	}
}

float[][] generarNoise(int seed, int w, int h, float def){
	noiseSeed(seed);
	float noi[][] = new float[w][h];
	for(int j = 0; j < h; j++){
		for(int i = 0; i < w; i++){
			noi[i][j] = noise(i*def, j*def);
		}
	}
	return noi;
}