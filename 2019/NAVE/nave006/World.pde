
import toxi.math.noise.SimplexNoise;

class World {
  int backColor = #FF8EFF;
  int seed;
  float detAmp, desAmp;
  float detType, desType;
  float detZone, desZone;
  World() {
    backColor = getColor(getZone(ship.pos.x, ship.pos.y, ship.pos.z));
    generate();
  }
  void update() {
    int nbc = getColor(getZone(ship.pos.x, ship.pos.y, ship.pos.z));
    backColor = lerpColor(backColor, nbc, 0.3);
  }
  void show() {
  }
  void generate() {
    seed = int(random(999999999));
    detAmp = random(0.00006, 0.0001)*random(0.4, 1);
    desAmp = random(10000);
    detZone = random(0.00001)*random(0.4, 1);
    desZone = random(10000);
  }

  float getAmp(float x, float y, float z) { 
    float noi = (float) SimplexNoise.noise(desAmp+x*detAmp, desAmp+y*detAmp, desAmp+z*detAmp);
    return constrain(noi*4-2, 0, 0.5)*2;
  }

  float getType(float x, float y, float z) { 
    float type = (float) SimplexNoise.noise(desType+x*detType, desType+y*detType, desType+z*detType)*4;
    float mod = type%1;
    type -= mod*0.8;
    return type;
  }


  float getZone(float x, float y, float z) { 
    float zone = (float) SimplexNoise.noise(desZone+x*detZone, desZone+y*detZone, desZone+z*detZone)*6;
    //float mod = zone%1;
    // zone -= mod*0.8;
    return zone;
  }
}
