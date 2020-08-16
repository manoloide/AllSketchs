PShape todos;
PShape pelos[];

void setup() {
	size(600,800);
	todos = loadShape("../pelos.svg");
	int cant = todos.getChildCount();
	println(cant);
	pelos = new PShape[cant];
	for (int i = 0; i < cant; ++i) {
		pelos[i] = todos.getChild("papa");
	}

}

void draw() {
	//pelos[0].setFill(color(random(256),random(256),random(256)));
	pelos[0].tint(200,100,30);
	shape(pelos[0], random(width)-width/2, random(height)-height/2);   
}