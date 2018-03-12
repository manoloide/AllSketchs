ArrayList comidas;
Ser s;

void setup() {
  size(400, 400);
  smooth();
  
  s = new Ser(200,200);
  comidas = new ArrayList();
}

void draw() {
  background(30, 30, 120);
  s.act();
  //act comida
  for(int i = 0; i < comidas.size(); i++){
     Comida pro = (Comida) comidas.get(i);
     pro.act(); 
  }
}

void mousePressed(){
  comidas.add(new Comida(mouseX,mouseY)); 
}
