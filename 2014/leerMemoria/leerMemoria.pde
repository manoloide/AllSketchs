void setup() {
}


void draw() {
  long maxMemory = Runtime.getRuntime().maxMemory();
  long freeMemory = Runtime.getRuntime().freeMemory();
  
  
  
  println("maxMemory: "+maxMemory);
  println("freeMemory: "+freeMemory);
}
