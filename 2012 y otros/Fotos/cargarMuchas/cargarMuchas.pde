import java.io.*;

PImage img[];
int cant;

File directorio = new File(".");

void setup() {
  size(640, 480);
  //
  String[] listaArchivos = directorio.list();
  try {
    println ("Directorio actual: " + System.getProperty("user.dir"));
  }
  catch(Exception e) {
    e.printStackTrace();
  }


}

void draw() {
}

