//creo un json object donde voy a guardar la configuracion
JSONObject config;

void setup() {
  //cargo el json con la configuracion
  config = loadJSONObject("config.json");
  //le asigno a la ventana lo valores que guarde en el json
  size(config.getInt("width"), config.getInt("height"));
  //hago que el tamaño de la ventana sea variable
  frame.setResizable(true);
  //configuro para dibujar el texto centrado y cambio el tamaño
  textAlign(CENTER, CENTER);
  textSize(60);
}

void draw() {
  background(40);
  fill(120);

  text(width+"x"+height, width/2, height/2);
}

//dispose es un evento que se llama antes de cerrar el programa
//aprovecho este momento para guardar los datos
//asi la proxima ves que lo abra tenia el tamaño de cuando cerre.
void dispose(){
  //remplazo los valores del width y height en el json 
  config.setInt("width",width);
  config.setInt("height",height);
  //guardo el json
  saveJSONObject(config,"config.json ");
}
