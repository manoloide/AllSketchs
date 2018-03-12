float diferencia = 10;
float t = 100;
void setup() {
  size( 1366,768);
  smooth();
  ellipseMode( CENTER );
  noStroke();
  rectMode (CENTER);
}
void draw() {
  background( 255 );
  boolean negro = true;
  
  for ( int i=300 ; i>0 ; i-=10) {

    
    float posX = map( i , 200, 0 , width/2 , mouseX );
    
    float posX2 = map( i , 200, 0 , width/2 , mouseX+diferencia );
    float posY = map( i , 200, 0 , height/2  , mouseY );

    if ( negro ) {
      fill( 255,0,0 , t);
    }
    else {
      fill( 255 , t);
    }
    
    
   ellipse ( posX, posY, i, i );
   if ( negro ) {
      fill( 0, 172, 232, t);
    }
    else {
      fill( 255 , t);
    }
    
   ellipse ( posX2,posY, i, i)  ;
    
    negro = !negro;
  }
}

