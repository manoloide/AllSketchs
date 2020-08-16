class InjectShader {
  boolean error, loaded;
  ReloadFile f1, f2;
  PShader shader;
  InjectShader(String fragFile) {
    f1 = new ReloadFile(fragFile);
    reloadShader();
  }
  InjectShader(String fragFile, String vertFile) {
    f1 = new ReloadFile(fragFile);
    f2 = new ReloadFile(vertFile);
    reloadShader();
  }

  void update() {
    if (f1 != null) {
      f1.update();
      if (f1.reload ) {
        reloadShader();
      }
    }
    if (f2 != null) {
      f2.update();
      if (f2.reload ) {
        reloadShader();
      }
    }
  }

  void reloadShader() {
    println("reload");
    try { 
      PShader aux = null;
      if (f2 == null) {
        aux = loadShader(f1.src);
      } else {
        aux = loadShader(f1.src, f2.src);
      }
      error = false;
      loaded = true;
      shader = aux;
    }
    catch (RuntimeException e) {    
      if (!error) { 
        error = true;
        println("\n");
        println("loadShader() returned the following error: \n");
        e.printStackTrace();
      }
      loaded = false;
    }
  }
}

class ReloadFile {
  boolean reload;
  long timeModi;
  File file;
  String src;
  ReloadFile(String src) {
    this.src = src;
    file = new File(sketchPath(src));
    timeModi = file.lastModified();
  }
  void update() {
    reload = false;
    File aux = new File(file.getPath());
    if (timeModi != aux.lastModified()) {
      timeModi = aux.lastModified();
      reload = true;
    }
  }
}  

