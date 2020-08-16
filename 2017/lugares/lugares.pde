/*
  -acotar busquedad a solo argentina
 -buscar datos de interes de los lugares encontrados
 -intentar usar api wikipedia
 */

void setup() {
  size(1280, 720);
  //pixelDensity(2);
  generar();
}

void draw() {
}

void keyPressed( ) {
  if (key == 's') {
    saveImage();
    println("Guardo");
  } else {
    println("Buscando...");
    generar();
  }
}

void generar() {
  int w = width;
  int h = (height+30);
  String codekey = "AIzaSyBruIg8UYRGAMoG6vOpyO88ngjMATAuCn8";
  float lat, lon;
  lat = lon = 0;
  int zoom = 15;
  PImage ori = null;
  while (ori == null || ori.get (1, 1) == -1776930) {

    lat = random(-90, 90);
    lon = random(-180, 180);
    //argentina
    /*lat = random(-55, -21);
     lon = random(-66, -53);
     */
    zoom = int(random(15, 19));
    String src = "http://maps.google.com/maps/api/staticmap?center="+lat+","+lon;
    ori = loadImage(src+"&zoom="+zoom+"&size="+w+"x"+h+"&maptype=satellite&sensor=true&scale=2&key="+codekey, "png");
  }
  println("encontro Imagen", zoom);
  image(ori, 0, 0);
  JSONObject datos = loadJSONObject("https://maps.googleapis.com/maps/api/geocode/json?address="+lat+","+lon+"&sensor=false&language=es&key="+codekey);
  println(datos.getString("status"));
  if (!datos.getString("status").equals("OK")) {
    generar();
    return;
  }
  JSONArray ubicacion = datos.getJSONArray("results").getJSONObject(0).getJSONArray("address_components");
  /*
  println("buscar informacion");
   titulo = ubicacion.getJSONObject(0).getString("long_name").replace(' ', '_');;
   JSONObject wiki = loadJSONObject("http://en.wikipedia.org/w/api.php?action=query&titles="+titulo+"&prop=info&imlimit=20&format=json");
   println(wiki);*/
  println("Termino.");
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

boolean masAlto(String str) {
  int des = 0;
  String letras = "gjpqy";
  int min = -1;
  for (int i = 0; i < letras.length(); i++) {
    char letra = letras.charAt(i);
    int pos = str.indexOf(letra);
    if (pos > 0) {
      if (pos < min || min == -1) min = pos;
    }
  }
  if (min != -1) return true;
  return false;
}