ArrayList<Compra> compras;
PFont helve;
PopNew popNew;

void setup() {
	size(640, 480);
	helve = createFont("Helvetica Neue Bold", 60, true);
	textFont(helve);
	frame.setResizable(true);
	compras = new ArrayList<Compra>();
	loadCompras();
}

void draw() {
	background(36);
	//lista
	float total = 0;
	for(int i = 0; i < compras.size(); i++){
		Compra c = compras.get(i);
		fill(50);
		noStroke();
		rect(0, 24+i*20, width, 20);
		fill(250);
		stroke(54);
		line(0, 24+i*20, width,24+i*20);
		stroke(46);
		line(0, 24+(i+2/2)*20-1, width,24+(i+2/2)*20-1);
		textSize(16);
		textAlign(LEFT, TOP);
		text(c.dia.getString(), 10, 24+i*20+2);
		textAlign(CENTER, TOP);
		text(c.detalle, width/2, 24+i*20+2);
		textAlign(RIGHT, TOP);
		text(c.gasto, width-10, 24+i*20+2);
		total += c.gasto;
	}
	//
	stroke(0, 5);
	for(int i = 6; i > 0; i--){
		strokeWeight(i);
		line(0, 24, width, 24);
		line(0, height-100, width, height-100);
	}

	//top menu
	noStroke();
	fill(56);
	rect(0, 0, width, 24);

	//menu inferior
	rect(0, height-100, width, 100);
	fill(250);
	textAlign(RIGHT, TOP);
	textSize(60);
	text("$"+total,width-20, height-90);

	fill(90);
	ellipse(50, height-50, 78, 78);
	strokeCap(SQUARE);
	strokeWeight(8);
	stroke(200);
	line(25, height-50, 75, height-50);
	line(50, height-25, 50, height-75);
	strokeWeight(1);
	if(popNew == null){
		if(mousePressed && dist(mouseX, mouseY, 50, height-50) < 39){
			popNew = new PopNew();
		}
	}
	else {
		popNew.update();
		if(popNew.eliminar) popNew = null;
	}


}

void dispose(){
	saveCompras();
	println("adioosss");
}

void loadCompras(){
	JSONArray aux = loadJSONArray("gastos.json");
	for(int i = 0; i<aux.size(); i++){
		compras.add(new Compra(aux.getJSONObject(i)));
	}
}

void saveCompras(){
	JSONArray aux = new JSONArray();
	for(int i = 0; i<compras.size(); i++){
		aux.append(compras.get(i).getJSON());
	}
	saveJSONArray(aux, "gastos.json");
}

class Compra{
	Day dia;
	float gasto;
	String detalle;
	Compra(JSONObject jo){
		setJSON(jo);
	}
	Compra(Day dia, String detalle, float gasto){
		this.dia = dia;
		this.detalle = detalle;
		this.gasto = gasto;
	}
	JSONObject getJSON(){
		JSONObject aux = new JSONObject();
		aux.setJSONObject("dia", dia.getJSON());
		aux.setFloat("gasto", gasto);
		aux.setString("detalle", detalle);
		return aux;
	}
	void setJSON(JSONObject jo){
		dia = new Day(jo.getJSONObject("dia"));
		detalle = jo.getString("detalle");
		gasto = jo.getFloat("gasto");
	}
};

class Day{
	int day, month, year;
	Day(JSONObject jo){
		setJSON(jo);
	}
	Day(int day, int month, int year){
		this.day = day;
		this.month = month;
		this.year = year;
	}
	String getString(){
		return day+"/"+month+"/"+year;
	}
	JSONObject getJSON(){
		JSONObject aux = new JSONObject();
		aux.setInt("day", day);
		aux.setInt("month", month);
		aux.setInt("year", year);
		return aux;
	}

	void setJSON(JSONObject jo){
		day = jo.getInt("day");
		month = jo.getInt("month");
		year = jo.getInt("year");
	}
};

class PopNew{
	boolean eliminar;
	int bordes;
	PopNew(){
		bordes = 20;
	}
	void update(){
		if(mousePressed && mouseX < bordes || mouseX > width-bordes && mouseY < bordes || mouseY > height-bordes){
			eliminar = true;
		}
		draw();
	}
	void draw(){
		strokeWeight(bordes);
		stroke(0, 40);
		fill(40);
		rect(bordes, bordes, width-bordes*2, height-bordes*2);
	}
}