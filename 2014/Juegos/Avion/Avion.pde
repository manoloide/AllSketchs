ArrayList<Bullet> bullets;
ArrayList<Entity> entities;

float gravity = 0.9;

Camera camera;
Input input;
Player player;

void setup() {
	size(720, 480);

	camera = new Camera();
	input = new Input();
	player = new Player();

	bullets = new ArrayList<Bullet>();
	entities = new ArrayList<Entity>();
	entities.add(player);
}

void draw() {
	if(frameCount%60 == 0){
		entities.add(new SimpleEnemy());
	}
	camera.update(player.position);
	background(#A2E7BC);
	for(int i = 0; i < entities.size(); i++){
		Entity e = entities.get(i);
		e.update();
		if(e.remove) entities.remove(i--);
	}

	for(int i = 0; i < bullets.size(); i++){
		Bullet b = bullets.get(i);
		b.update();
		if(b.remove) bullets.remove(i--);
	}
}

class Bullet{
	boolean remove;
	Entity entity;
	float velocity, direction, timeLife;
	PVector position;	
	void update(){

	}
	void draw(){
	}
};

//15 4385069



class SimpleBullet extends Bullet{
	SimpleBullet(Entity e){
		entity = e;
		direction = e.direction;
		velocity = 10;
		timeLife = 5;
		position = new PVector(e.position.x, e.position.y);
	}
	void update(){
		timeLife -= 1./60;
		if(timeLife < 0) remove = true;
		position.x += cos(direction)*velocity;
		position.y += sin(direction)*velocity;
		draw();
	}
	void draw(){
		fill(#C11010);
		ellipse(position.x, position.y, 2, 2);
	}
};


class Entity{
	boolean remove;
	
	float velocity;
	float aceleracion;
	float desaceleracion;
	float velocityMaxima;

	float direction;
	float velocityRotacion;
	float aceleracionRotacion;
	float desaceleracionRotacion;
	float velocityRotacionMaxima;
	
	PVector position;
	void update(){
	}
	void draw(){
	}
};

class Player extends Entity{

	Player(){		
		velocity = 0;
		aceleracion = 0.05;
		desaceleracion = 0.86;
		velocityMaxima = 4;

		direction = 0;
		velocityRotacion = 0;
		aceleracionRotacion = 0.005;
		desaceleracionRotacion = 0.9;
		velocityRotacionMaxima = 0.16;
		position = new PVector(0, 0);
	}
	void update(){
		if(input.ARRIBA.press) velocity += aceleracion;
		else velocity *= desaceleracion;
		velocity = constrain(velocity, 0, velocityMaxima);
		if(input.IZQUIERDA.press) velocityRotacion -= aceleracionRotacion;
		else if(input.DERECHA.press) velocityRotacion += aceleracionRotacion;
		else velocityRotacion *= desaceleracionRotacion;
		velocityRotacion = constrain(velocityRotacion, -velocityRotacionMaxima, velocityRotacionMaxima);
		direction += velocityRotacion;
		velocity += aceleracion;
		position.x += cos(direction)*velocity;
		position.y += sin(direction)*velocity;
		if(input.ATACAR.press){
			bullets.add(new SimpleBullet(this));
		}
		draw();
	}
	void draw(){
		noStroke();
		fill(#A52EC4);
		ellipse(position.x, position.y, 20, 20);
		stroke(0);
		line(position.x, position.y, position.x+cos(direction)*10, position.y+sin(direction)*10);
	}
}

class SimpleEnemy extends Entity{

	SimpleEnemy(){		
		velocity = 0;
		aceleracion = 0.05;
		desaceleracion = 0.86;
		velocityMaxima = 3;

		direction = 0;
		velocityRotacion = 0;
		aceleracionRotacion = 0.005;
		desaceleracionRotacion = 0.9;
		velocityRotacionMaxima = 0.16;
		position = new PVector(0, 0);
	}
	void update(){
		/*
		if(input.ARRIBA.press) velocity += aceleracion;
		else velocity *= desaceleracion;
		velocity = constrain(velocity, 0, velocityMaxima);
		if(input.IZQUIERDA.press) velocityRotacion -= aceleracionRotacion;
		else if(input.DERECHA.press) velocityRotacion += aceleracionRotacion;
		else velocityRotacion *= desaceleracionRotacion;
		*/
		velocity = velocityMaxima;
		
		float angleObjective = atan2(player.position.y-position.y, player.position.x-position.x);
		float diffAngle = direction-angleObjective;

		if(diffAngle > 0) velocityRotacion -= aceleracionRotacion;
		if(diffAngle < 0) velocityRotacion += aceleracionRotacion;
		//if(diffAngle < velocityRotacionMaxima) velocityRotacion *= desaceleracionRotacion;
		
		//direction = angleObjective;

		velocityRotacion = constrain(velocityRotacion, -velocityRotacionMaxima, velocityRotacionMaxima);
		direction += velocityRotacion;
		velocity += aceleracion;
		position.x += cos(direction)*velocity;
		position.y += sin(direction)*velocity;
		if(frameCount%30 == 0){
			bullets.add(new SimpleBullet(this));
		}
		draw();
	}
	void draw(){
		noStroke();
		fill(#FF0808);
		ellipse(position.x, position.y, 12, 12);
		stroke(0);
		line(position.x, position.y, position.x+cos(direction)*6, position.y+sin(direction)*6);
	}	
}