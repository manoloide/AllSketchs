ArrayList<Palabra> palabras;
JSONArray jpalabras;
String txt = "Processing is a programming language, development environment, and online community. Since 2001, Processing has promoted software literacy within the visual arts and visual literacy within technology. Initially created to serve as a software sketchbook and to teach computer programming fundamentals within a visual context, Processing evolved into a development tool for professionals. Today, there are tens of thousands of students, artists, designers, researchers, and hobbyists who use Processing for learning, prototyping, and production.";
void setup() {
  size(800, 600);
  palabras = new ArrayList<Palabra>();
  File f = new File("palabras.json");
  if (f.exists()) {
    jpalabras = loadJSONArray("palabras.json");
  } else {
    jpalabras = new JSONArray();
  }
  buscarPalabras();
  traduccirPalabra();
}

void draw() {
}

void dispose() {
  saveJSONArray(jpalabras, "palabras.json");
}

void keyPressed(){
  traduccirPalabra();
}

void buscarPalabras() {
  String words[] = txt.split("\\P{L}+");
  for (int i = 0; i < words.length; i++) {
    String palabra = words[i].toLowerCase();
    boolean existe = false;
    for (int j = 0; j < palabras.size (); j++) {
      Palabra p = palabras.get(j); 
      if (p.nombre.equals(palabra)) {
        existe = true;
        p.cant++;
        break;
      }
    }
    if (!existe) {
      palabras.add(new Palabra(palabra));
    }
  }
  for (int j = 0; j < palabras.size (); j++) {
    Palabra p = palabras.get(j); 
    println(p.nombre, p.cant);
  }
}

void traduccirPalabra() {
  Palabra p = palabras.get(int(random(palabras.size()))); 
  String tra = "";
  JSONObject oj = loadJSONObject("http://glosbe.com/gapi/translate?from=eng&dest=spa&format=json&phrase="+p.nombre);
  JSONArray res = oj.getJSONArray("tuc");
  //println(res);
  for(int i = 0; i < res.size(); i++){
    JSONObject tt = res.getJSONObject(i);
    //println(tt);
    if(tt.hasKey("phrase"))
      tra += tt.getJSONObject("phrase").getString("text") + " ";
  }
  println(p.nombre, tra);
}

class Palabra {
  int cant;
  String nombre;
  Palabra(String nombre) {
    this.nombre = nombre;
    cant = 1;
  }
}
