SVG svg;

void setup(){
   size(1280, 720);
   
   svg = new SVG(width, height);
}

void draw(){
  
  for(int i = 0; i < 100; i++){
     svg.line(random(width), random(height), random(width), random(height));
     
  }
  
  
  
}
