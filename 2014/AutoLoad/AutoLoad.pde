Text texto;

void setup() {
  size(200, 400);
  texto = new Text("textoPrueba.txt");
}

void draw() {
  long timeee = System.nanoTime() ;
  background(40);
  fill(250);
  for(int i = 0; i < texto.val.length; i++){
    text(texto.val[i], 20, 20+20*i);
  }
  texto.update();
  println(System.nanoTime() -timeee);
}

class Text {
  String[] val;
  String src;
  long modificado;
  Text(String src) {
    this.src = src;
    cargarTexto();
    val = loadStrings(src);
  }
  void update(){
     if(frameCount%1  == 0){
        File file = new File(sketchPath(src));
        if(modificado != file.lastModified()){
          cargarTexto();
        }
        
     } 
  }
  void cargarTexto(){
    File file = new File(sketchPath(src));
    modificado = file.lastModified();
    val = loadStrings(file);
  }
}
