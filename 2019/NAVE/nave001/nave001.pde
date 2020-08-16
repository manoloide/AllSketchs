// cambiar de chunk
// añadir world class solo noise global, ect
// añadir cubos por chunk
// añadir particulas
// añadir billboar
// añadir texture shader fog
// añadir movimiento mas spacial 3d
// añadir titulos "manoloide", "pressent:", "NODATA"
// generar naves
// añadir time in/out en los tiles para poder añadir animaciones de entrada y salida
// añadir mapa isometrico, fondo oscuro, dibujar doble puntos para senscion de luz
// añadir puntos en el mundo, y añadir indicador en el mapa para que te den ganas de juntarlos.
// guardar los puntos de la nave y trazar las linea en el mapa, probar gradient
// añadir zonas y definirlas con un color, hacer fade con el color de fondo, ejemplo rosa es zona amigable, azul es la oscuridad, amarillo es toxica pero hay dinero.
// probar hacer las naves por dentro, camara hud, vista top, 3d, 

// añadir intro animada interactiva, ir de los simple a lo complejo, probar arrancas con un punto e ir abriendolo






import peasy.PeasyCam;

ArrayList<Chunk> chunks;
Camera camera;
Ship ship;
float size = 6000;
int backColor = #FF8EFF;
PeasyCam cam;
PFont font;
PShader fogLines, fogColor;

int keyPress = key;
int seed = int(random(99999999));


void setup() {

  size(1280, 720, P3D);
  smooth(4);
  hint(ENABLE_STROKE_PERSPECTIVE);
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
  ship = new Ship(0, 0, 0);

  chunks = new ArrayList<Chunk>();
  for (int k = -1; k < 2; k++) {
    for (int j = -1; j < 2; j++) {
      for (int i = -1; i < 2; i++) {
        chunks.add(new Chunk(i, j, k));
      }
    }
  }
}


void draw() {

  background(backColor);

  fog();

  camera.update();

  for (int i = 0; i < chunks.size(); i++) {
    Chunk c = chunks.get(i);
    c.update();
    c.show();
  }

  ship.update();
  ship.show();
}

void keyPressed() {
  if (key == 'w') ship.up = true;
  if (key == 's') ship.down = true;
  if (key == 'a') ship.left = true;
  if (key == 'd') ship.right = true;
  if (key == 'c') saveImage();
}

void keyReleased() {
  if (key == 'w') ship.up = false;
  if (key == 's') ship.down = false;
  if (key == 'a') ship.left = false;
  if (key == 'd') ship.right = false;
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

void fog() {

  float fogNear = 3000;
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
