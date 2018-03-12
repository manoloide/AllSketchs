class Easing {
  //BACK
  static float BackIn(float t, float b, float c, float d) {
    float s = 1.70158f;
    return c*(t/=d)*t*((s+1)*t - s) + b;
  }
  static float  BackIn(float t, float b, float c, float d, float s) {
    return c*(t/=d)*t*((s+1)*t - s) + b;
  }
  static float  BackOut(float t, float b, float c, float d) {
    float s = 1.70158f;
    return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
  }
  static float  BackOut(float t, float b, float c, float d, float s) {
    return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
  }
  static float  BackInOut(float t, float b, float c, float d) {
    float s = 1.70158f;
    if ((t/=d/2) < 1) return c/2*(t*t*(((s*=(1.525f))+1)*t - s)) + b;
    return c/2*((t-=2)*t*(((s*=(1.525f))+1)*t + s) + 2) + b;
  }
  static float  BackInOut(float t, float b, float c, float d, float s) {  
    if ((t/=d/2) < 1) return c/2*(t*t*(((s*=(1.525f))+1)*t - s)) + b;
    return c/2*((t-=2)*t*(((s*=(1.525f))+1)*t + s) + 2) + b;
  }
  //BOUNCE
  static float  BounceIn(float t, float b, float c, float d) {
    return c - BounceOut (d-t, 0, c, d) + b;
  }
  static float  BounceOut(float t, float b, float c, float d) {
    if ((t/=d) < (1/2.75f)) {
      return c*(7.5625f*t*t) + b;
    } else if (t < (2/2.75f)) {
      return c*(7.5625f*(t-=(1.5f/2.75f))*t + .75f) + b;
    } else if (t < (2.5/2.75)) {
      return c*(7.5625f*(t-=(2.25f/2.75f))*t + .9375f) + b;
    } else {
      return c*(7.5625f*(t-=(2.625f/2.75f))*t + .984375f) + b;
    }
  }
  static float  BounceInOut(float t, float b, float c, float d) {
    if (t < d/2) return BounceIn (t*2, 0, c, d) * .5f + b;
    else return BounceOut (t*2-d, 0, c, d) * .5f + c*.5f + b;
  }
  //CIRC
  static float  CircIn(float t, float b, float c, float d) {
    return -c * ((float)Math.sqrt(1 - (t/=d)*t) - 1) + b;
  }
  static float  CircOut(float t, float b, float c, float d) {
    return c * (float)Math.sqrt(1 - (t=t/d-1)*t) + b;
  }
  static float  CirInOut(float t, float b, float c, float d) {
    if ((t/=d/2) < 1) return -c/2 * ((float)Math.sqrt(1 - t*t) - 1) + b;
    return c/2 * ((float)Math.sqrt(1 - (t-=2)*t) + 1) + b;
  }
  //CUBIC
  static float CubicIn (float t, float b, float c, float d) {
    return c*(t/=d)*t*t + b;
  }
  static float CubicOut (float t, float b, float c, float d) {
    return c*((t=t/d-1)*t*t + 1) + b;
  }
  static float CubicInOut (float t, float b, float c, float d) {
    if ((t/=d/2) < 1) return c/2*t*t*t + b;
    return c/2*((t-=2)*t*t + 2) + b;
  }
  //ELASTIC
  static float  ElasticIn(float t, float b, float c, float d ) {
    if (t==0) return b;  
    if ((t/=d)==1) return b+c;  
    float p=d*.3f;
    float a=c; 
    float s=p/4;
    return -(a*(float)Math.pow(2, 10*(t-=1)) * (float)Math.sin( (t*d-s)*(2*(float)Math.PI)/p )) + b;
  }
  static float  ElasticIn(float t, float b, float c, float d, float a, float p) {
    float s;
    if (t==0) return b;  
    if ((t/=d)==1) return b+c;  
    if (a < Math.abs(c)) { 
      a=c;  
      s=p/4;
    } else { 
      s = p/(2*(float)Math.PI) * (float)Math.asin (c/a);
    }
    return -(a*(float)Math.pow(2, 10*(t-=1)) * (float)Math.sin( (t*d-s)*(2*Math.PI)/p )) + b;
  }
  static float  ElasticOut(float t, float b, float c, float d) {
    if (t==0) return b;  
    if ((t/=d)==1) return b+c;  
    float p=d*.3f;
    float a=c; 
    float s=p/4;
    return (a*(float)Math.pow(2, -10*t) * (float)Math.sin( (t*d-s)*(2*(float)Math.PI)/p ) + c + b);
  }
  static float  ElasticOut(float t, float b, float c, float d, float a, float p) {
    float s;
    if (t==0) return b;  
    if ((t/=d)==1) return b+c;  
    if (a < Math.abs(c)) { 
      a=c;  
      s=p/4;
    } else { 
      s = p/(2*(float)Math.PI) * (float)Math.asin (c/a);
    }
    return (a*(float)Math.pow(2, -10*t) * (float)Math.sin( (t*d-s)*(2*(float)Math.PI)/p ) + c + b);
  }
  static float  ElasticInOut(float t, float b, float c, float d) {
    if (t==0) return b;  
    if ((t/=d/2)==2) return b+c; 
    float p=d*(.3f*1.5f);
    float a=c; 
    float s=p/4;
    if (t < 1) return -.5f*(a*(float)Math.pow(2, 10*(t-=1)) * (float)Math.sin( (t*d-s)*(2*(float)Math.PI)/p )) + b;
    return a*(float)Math.pow(2, -10*(t-=1)) * (float)Math.sin( (t*d-s)*(2*(float)Math.PI)/p )*.5f + c + b;
  }
  static float  ElasticInOut(float t, float b, float c, float d, float a, float p) {
    float s;
    if (t==0) return b;  
    if ((t/=d/2)==2) return b+c;  
    if (a < Math.abs(c)) { 
      a=c; 
      s=p/4;
    } else { 
      s = p/(2*(float)Math.PI) * (float)Math.asin (c/a);
    }
    if (t < 1) return -.5f*(a*(float)Math.pow(2, 10*(t-=1)) * (float)Math.sin( (t*d-s)*(2*(float)Math.PI)/p )) + b;
    return a*(float)Math.pow(2, -10*(t-=1)) * (float)Math.sin( (t*d-s)*(2*(float)Math.PI)/p )*.5f + c + b;
  }
  //EXPO
  static float  ExpoIn(float t, float b, float c, float d) {
    return (t==0) ? b : c * (float)Math.pow(2, 10 * (t/d - 1)) + b;
  }
  static float  ExpoOut(float t, float b, float c, float d) {
    return (t==d) ? b+c : c * (-(float)Math.pow(2, -10 * t/d) + 1) + b;
  }
  static float  ExpoInOut(float t, float b, float c, float d) {
    if (t==0) return b;
    if (t==d) return b+c;
    if ((t/=d/2) < 1) return c/2 * (float)Math.pow(2, 10 * (t - 1)) + b;
    return c/2 * (-(float)Math.pow(2, -10 * --t) + 2) + b;
  }
  //LINEAR
  static float LinearNone (float t, float b, float c, float d) {
    return c*t/d + b;
  }
  static float LinearIn (float t, float b, float c, float d) {
    return c*t/d + b;
  }
  static float LinearOut (float t, float b, float c, float d) {
    return c*t/d + b;
  }
  static float LinearInOut (float t, float b, float c, float d) {
    return c*t/d + b;
  }
  //QUAD
  static float QuadIn(float t, float b, float c, float d) {
    return c*(t/=d)*t + b;
  }
  static float  QuadOut(float t, float b, float c, float d) {
    return -c *(t/=d)*(t-2) + b;
  }
  static float  QuadInOut(float t, float b, float c, float d) {
    if ((t/=d/2) < 1) return c/2*t*t + b;
    return -c/2 * ((--t)*(t-2) - 1) + b;
  }
  //QUART
  static float  QuartIn(float t, float b, float c, float d) {
    return c*(t/=d)*t*t*t + b;
  }
  static float  QuartOut(float t, float b, float c, float d) {
    return -c * ((t=t/d-1)*t*t*t - 1) + b;
  }
  static float  QuartInOut(float t, float b, float c, float d) {
    if ((t/=d/2) < 1) return c/2*t*t*t*t + b;
    return -c/2 * ((t-=2)*t*t*t - 2) + b;
  }
  //QUINT
  static float QuintIn (float t, float b, float c, float d) {
    return c*(t/=d)*t*t*t*t + b;
  }
  static float QuintOut (float t, float b, float c, float d) {
    return c*((t=t/d-1)*t*t*t*t + 1) + b;
  }
  static float QuintInOut (float t, float b, float c, float d) {
    if ((t/=d/2) < 1) return c/2*t*t*t*t*t + b;
    return c/2*((t-=2)*t*t*t*t + 2) + b;
  }
  //SINE
  static float  SineIn(float t, float b, float c, float d) {
    return -c * (float)Math.cos(t/d * (Math.PI/2)) + c + b;
  }
  static float  SineOut(float t, float b, float c, float d) {
    return c * (float)Math.sin(t/d * (Math.PI/2)) + b;
  }
  static float  SineInOut(float t, float b, float c, float d) {
    return -c/2 * ((float)Math.cos(Math.PI*t/d) - 1) + b;
  }
}