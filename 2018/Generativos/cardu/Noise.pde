class Noise{
   float det, des;
   Noise(float det, float des){
      this.det = det;
      this.des = des;
   }
   float get(float x, float y){
      return (float) SimplexNoise.noise(des+x*det, des+y*det);
   }
   float get(float x, float y, float z){
      return (float) SimplexNoise.noise(des+x*det, des+y*det, des+z*det);
   }
}
