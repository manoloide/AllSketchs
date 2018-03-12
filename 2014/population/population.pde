JSONArray countryList, population;

void setup() {
	size(800, 600);
	countryList = loadJSONArray("countrylist.json");
	String id = "";
	int tw = 200;
	int cw = int(width/tw);
	int bw = (width -(tw*cw));
	println(cw);
	for(int j = 0; j <  cw; j++){
		boolean encontro = false;
		population = null;
		while(population == null){
			try {
				id = countryList.getJSONObject(int(random(countryList.size()))).getString("Code");
				println(id);
				population = loadJSONArray("http://api.worldbank.org/"+id+"/countries/ar/indicators/SP.POP.TOTL?date=1900:2013&format=json");
				if(population.size() < 2) population = null;
			} catch (Exception e) {
				population = null;
			}
		}
		population = population.getJSONArray(1);
		int val[] = new int[population.size()];
		for(int i = 0; i < population.size(); i++){
			val[i] = population.getJSONObject(i).getInt("value");
		}
		val = reverse(val);
		background(#171212);
		grafico("Population - "+id, bw+tw*j, 20, tw, height-60, val, #992EED);
	}
}

void draw() {
}

void grafico(String name, float x, float y, float w, float h, int[] valores, color col){
	float min = valores[0];
	float max = valores[1];
	int cant = valores.length;
	for(int i = 1; i < cant; i++){
		min = min(min, valores[i]);
		max = max(max, valores[i]);
	}
	float diff = max-min;
	min -= diff*0.1;
	max += diff*0.1;
	textAlign(LEFT, TOP);
	textSize(32);
	fill(col);
	text(name, x, y);
	noFill();
	stroke(col);
	float des = 44;
	rect(x, y+des, w, h-des);
	for(int i = 0; i < cant; i++){
		float xx = x+(i+0.5)*(w/(cant));
		float yy = y+map(valores[i], min, max, h-des, 0)+des;
		ellipse(xx, yy, 4, 4);
		line(xx, yy+2, xx, y+h);
	}
}
