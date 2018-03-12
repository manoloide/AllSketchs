/*
  -acotar busquedad a solo argentina
 -buscar datos de interes de los lugares encontrados
 -intentar usar api wikipedia
 */

PFont fchica, fchica2, fnormal, fgrande;

void setup() {
  size(1200, 600);
  fchica2 = createFont("Helvetica", 10);
  fchica = createFont("Helvetica Bold", 18);
  fnormal = createFont("Helvetica Bold", 40);
  fgrande = createFont("Helvetica Bold", 90);
  generar();
}

void draw() {
}

void keyPressed( ) {
  if (key == 's') {
    saveImage();
    println("Guardo");
  }
  else {
    println("Buscando...");
    generar();
  }
}

void generar() {
  int w = width/2;
  int h = height/2+30;
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
  fill(250);
  textAlign(LEFT, TOP);
  textFont(fgrande);
  int dd = 0;
  String titulo = "";
  if (ubicacion.size() > 1) titulo = ubicacion.getJSONObject(1).getString("long_name");
  else titulo = ubicacion.getJSONObject(0).getString("long_name");
  if (masAlto(titulo)) dd += 14;
  text(titulo, 24, 50);
  textFont(fnormal);
  if (ubicacion.size() > 3) titulo = ubicacion.getJSONObject(2).getString("long_name")+" - "+ubicacion.getJSONObject(3).getString("long_name");
  else if (ubicacion.size() > 2) titulo = ubicacion.getJSONObject(2).getString("long_name");
  text(titulo, 28, 126+dd);
  textFont(fchica); 
  if (masAlto(titulo)) dd += 8;
  text(lat+" + "+lon, 30, 160+dd);
  /*
  println("buscar informacion");
   titulo = ubicacion.getJSONObject(0).getString("long_name").replace(' ', '_');;
   JSONObject wiki = loadJSONObject("http://en.wikipedia.org/w/api.php?action=query&titles="+titulo+"&prop=info&imlimit=20&format=json");
   println(wiki);*/
  println("Termino.");
}

void saveImage(){
   int n = (new File(sketchPath+"/nuevas/")).listFiles().length-1;
    saveFrame("nuevas/"+nf(n,3)+".png"); 
}

PImage processar(PImage ori) {
  PImage aux = createImage(ori.width, ori.height, RGB);
  for (int i = 0; i < ori.pixels.length; i++) {
    color col = ori.pixels[i];
    int r = int(red(col));
    int g = int(green(col));
    int b = int(blue(col));
    int c = (r+g+b)/3;
    color gris = color(r+random(-10, 5));
    aux.pixels[i] = lerpColor(col, gris, 0.2);
  }
  return aux;
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
