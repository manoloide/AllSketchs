// añadir texture shader, fixed fog
// añadir movimiento mas spacial 3d
// generar naves
// añadir disparos
// añadir time in/out en los tiles para poder añadir animaciones de entrada y salida
// añadir mapa isometrico, fondo oscuro, dibujar doble puntos para senscion de luz
// añadir puntos en el mundo, y añadir indicador en el mapa para que te den ganas de juntarlos.
// guardar los puntos de la nave y trazar las linea en el mapa, probar gradient
// añadir zonas y definirlas con un color, hacer fade con el color de fondo, ejemplo rosa es zona amigable, azul es la oscuridad, amarillo es toxica pero hay dinero.
// probar hacer las naves por dentro, camara hud, vista top, 3d, 
// escape abre el menu, volumen, y settings
// añadir intro animada interactiva, ir de los simple a lo complejo, probar arrancas con un punto e ir abriendolo






import peasy.PeasyCam;

ArrayList<Chunk> chunks;
Camera camera;
Map map;
Ship ship;
Particles particles;
World world;

float time;
float size = 6000;
int backColor = #FF8EFF;

PeasyCam cam;
PFont font;
PShader fogLines, fogColor;

int keyPress = key;


void setup() {

  //size(displayWidth, displayHeight, P3D);
  fullScreen(P3D);
  smooth(0);
  hint(ENABLE_STROKE_PERSPECTIVE);
  imageMode(CENTER);
  rectMode(CENTER);

  backColor = #FF7AFF;
  fogLines = loadShader("fogLines.glsl");
  fogColor = loadShader("fogColor.glsl");

  font = createFont("fonts/Chivo-Light.ttf", 200, true);
  textFont(font);
  textAlign(CENTER, CENTER);
  textSize(200);


  camera = new Camera();
  cam = new PeasyCam(this, 400);
  map = new Map();
  ship = new Ship(0, 0, 0);
  particles = new Particles();
  world = new World();

  chunks = new ArrayList<Chunk>();
  //chunks.add(new Chunk(0, 0, 0));
  for (int k = -1; k < 2; k++) {
    for (int j = -1; j < 2; j++) {
      for (int i = -1; i < 2; i++) {
        chunks.add(new Chunk(i, j, k));
      }
    }
  }
}


void draw() {

  time = millis()*0.001;


  backColor = getColor(world.getZone(ship.pos.x, ship.pos.y, ship.pos.z));
  background(backColor);
  fog();
  //lights();
  camera.update();


  for (int i = 0; i < chunks.size(); i++) {
    Chunk c = chunks.get(i);
    c.update();
    c.show();
  }

  ship.update();
  ship.show();

  //particles.update();
  //particles.show();



  //TITLES
  String titles[] = {"Manoloide", "presents:", "NODATA"};
  textSize(70);
  fill(0);
  for (int i = 0; i < 3; i++) {
    text(titles[i], 0, -220, (-i-1)*size);
  }



  //map.update();
  //map.show();
}

void keyPressed() {
  if (key == 'w') ship.up = true;
  if (key == 's') ship.down = true;
  if (key == 'a') ship.left = true;
  if (key == 'd') ship.right = true;
  if (key == 'c') saveImage();
  if (key == 'g') world.generate();
  if (key == 'm') map.active();
}

void keyReleased() {
  if (key == 'w') ship.up = false;
  if (key == 's') ship.down = false;
  if (key == 'a') ship.left = false;
  if (key == 'd') ship.right = false;
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+world.seed+".png");
}

//https://coolors.co/ff8eff-f7f718-92ccbc-0c0002-1544a3
int colors[] = {#ff8eff, #f7f718, #92ccbc, #0c0002, #1544a3};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v); 
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, pow(v%1, 1.2));
}

void fog() {

  float fogNear = 2000;
  float fogFar = 8000;

  fogLines.set("fogColor", red(backColor)/256., green(backColor)/256., blue(backColor)/256.);
  fogLines.set("fogNear", fogNear); 
  fogLines.set("fogFar", fogFar);
  shader(fogLines, LINES);
  fogColor.set("fogColor", red(backColor)/256., green(backColor)/256., blue(backColor)/256.);
  fogColor.set("fogNear", fogNear); 
  fogColor.set("fogFar", fogFar);
  shader(fogColor);
}
