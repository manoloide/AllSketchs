void setup() {
  size(960, 960);
}


void draw() {
  float d = 60;
  float t = frameCount%d;
  float b = width*0.2;
  float c = width*0.6;
  float s = width*0.02;

  if (frameCount%(d*2) >= d) {
    t = d-t;
  }

  background(240);
  noStroke();
  fill(240, 20, 0);

  ellipse(BackEaseIn(t, b, c, d), height*0.1, s, s);
  ellipse(BackEaseOut(t, b, c, d), height*0.125, s, s);
  ellipse(BackEaseInOut(t, b, c, d), height*0.15, s, s);


  ellipse(BounceEaseIn(t, b, c, d), height*0.175, s, s);
  ellipse(BounceEaseOut(t, b, c, d), height*0.2, s, s);
  ellipse(BounceEaseInOut(t, b, c, d), height*0.225, s, s);

  ellipse(CircEaseIn(t, b, c, d), height*0.25, s, s);
  ellipse(CircEaseOut(t, b, c, d), height*0.275, s, s);
  ellipse(CircEaseInOut(t, b, c, d), height*0.3, s, s);

  ellipse(CubicEaseIn(t, b, c, d), height*0.325, s, s);
  ellipse(CubicEaseOut(t, b, c, d), height*0.35, s, s);
  ellipse(CubicEaseInOut(t, b, c, d), height*0.375, s, s);

  ellipse(ElasticEaseIn(t, b, c, d), height*0.4, s, s);
  ellipse(ElasticEaseOut(t, b, c, d), height*0.425, s, s);
  ellipse(ElasticEaseInOut(t, b, c, d), height*0.45, s, s);

  ellipse(ExpoEaseIn(t, b, c, d), height*0.475, s, s);
  ellipse(ExpoEaseOut(t, b, c, d), height*0.5, s, s);
  ellipse(ExpoEaseInOut(t, b, c, d), height*0.525, s, s);


  ellipse(LinearEaseIn(t, b, c, d), height*0.55, s, s);
  ellipse(LinearEaseOut(t, b, c, d), height*0.575, s, s);
  ellipse(LinearEaseInOut(t, b, c, d), height*0.6, s, s);

  ellipse(QuadEaseIn(t, b, c, d), height*0.625, s, s);
  ellipse(QuadEaseOut(t, b, c, d), height*0.65, s, s);
  ellipse(QuadEaseInOut(t, b, c, d), height*0.675, s, s);


  ellipse(QuintEaseIn(t, b, c, d), height*0.7, s, s);
  ellipse(QuintEaseOut(t, b, c, d), height*0.725, s, s);
  ellipse(QuintEaseInOut(t, b, c, d), height*0.75, s, s);

  ellipse(SineEaseIn(t, b, c, d), height*0.775, s, s);
  ellipse(SineEaseOut(t, b, c, d), height*0.8, s, s);
  ellipse(SineEaseInOut(t, b, c, d), height*0.825, s, s);
}

float BackEaseIn (float t, float b, float c, float d) {
  float s = 1.70158f;
  float postFix = t/=d;
  return c*(postFix)*t*((s+1)*t - s) + b;
}

float BackEaseOut(float t, float b, float c, float d) {  
  float s = 1.70158f;
  return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
}

float BackEaseInOut(float t, float b, float c, float d) {
  float s = 1.70158f;
  if ((t/=d/2) < 1) return c/2*(t*t*(((s*=(1.525f))+1)*t - s)) + b;
  float postFix = t-=2;
  return c/2*((postFix)*t*(((s*=(1.525f))+1)*t + s) + 2) + b;
}

float BounceEaseIn (float t, float b, float c, float d) {
  return c - BounceEaseOut (d-t, 0, c, d) + b;
}

float BounceEaseOut(float t, float b, float c, float d) {
  if ((t/=d) < (1/2.75f)) {
    return c*(7.5625f*t*t) + b;
  } else if (t < (2/2.75f)) {
    float postFix = t-=(1.5f/2.75f);
    return c*(7.5625f*(postFix)*t + .75f) + b;
  } else if (t < (2.5/2.75)) {
    float postFix = t-=(2.25f/2.75f);
    return c*(7.5625f*(postFix)*t + .9375f) + b;
  } else {
    float postFix = t-=(2.625f/2.75f);
    return c*(7.5625f*(postFix)*t + .984375f) + b;
  }
}

float BounceEaseInOut(float t, float b, float c, float d) {
  if (t < d/2) return BounceEaseIn (t*2, 0, c, d) * .5f + b;
  else return BounceEaseOut (t*2-d, 0, c, d) * .5f + c*.5f + b;
}

float CircEaseIn (float t, float b, float c, float d) {
  return -c * (sqrt(1 - (t/=d)*t) - 1) + b;
}

float CircEaseOut(float t, float b, float c, float d) {
  return c * sqrt(1 - (t=t/d-1)*t) + b;
}

float CircEaseInOut(float t, float b, float c, float d) {
  if ((t/=d/2) < 1) return -c/2 * (sqrt(1 - t*t) - 1) + b;
  return c/2 * (sqrt(1 - t*(t-=2)) + 1) + b;
}

float CubicEaseIn (float t, float b, float c, float d) {
  return c*(t/=d)*t*t + b;
}

float CubicEaseOut(float t, float b, float c, float d) {
  return c*((t=t/d-1)*t*t + 1) + b;
}

float CubicEaseInOut(float t, float b, float c, float d) {
  if ((t/=d/2) < 1) return c/2*t*t*t + b;
  return c/2*((t-=2)*t*t + 2) + b;
}

float ElasticEaseIn (float t, float b, float c, float d) {
  if (t==0) return b;  
  if ((t/=d)==1) return b+c;  
  float p=d*.3f;
  float a=c; 
  float s=p/4;
  float postFix =a*pow(2, 10*(t-=1)); // this is a fix, again, with post-increment operators
  return -(postFix * sin((t*d-s)*(2*PI)/p )) + b;
}

float ElasticEaseOut(float t, float b, float c, float d) {
  if (t==0) return b;  
  if ((t/=d)==1) return b+c;  
  float p=d*.3f;
  float a=c; 
  float s=p/4;
  return (a*pow(2, -10*t) * sin( (t*d-s)*(2*PI)/p ) + c + b);
}

float ElasticEaseInOut(float t, float b, float c, float d) {
  if (t==0) return b;  
  if ((t/=d/2)==2) return b+c; 
  float p=d*(.3f*1.5f);
  float a=c; 
  float s=p/4;

  if (t < 1) {
    float postFix =a*pow(2, 10*(t-=1)); // postIncrement is evil
    return -.5f*(postFix* sin( (t*d-s)*(2*PI)/p )) + b;
  } 
  float postFix =  a*pow(2, -10*(t-=1)); // postIncrement is evil
  return postFix * sin( (t*d-s)*(2*PI)/p )*.5f + c + b;
}


float ExpoEaseIn (float t, float b, float c, float d) {
  return (t==0) ? b : c * pow(2, 10 * (t/d - 1)) + b;
}

float ExpoEaseOut(float t, float b, float c, float d) {
  return (t==d) ? b+c : c * (-pow(2, -10 * t/d) + 1) + b;
}

float ExpoEaseInOut(float t, float b, float c, float d) {
  if (t==0) return b;
  if (t==d) return b+c;
  if ((t/=d/2) < 1) return c/2 * pow(2, 10 * (t - 1)) + b;
  return c/2 * (-pow(2, -10 * --t) + 2) + b;
}

float LinearEaseNone (float t, float b, float c, float d) {
  return c*t/d + b;
}

float LinearEaseIn (float t, float b, float c, float d) {
  return c*t/d + b;
}

float LinearEaseOut(float t, float b, float c, float d) {  
  return c*t/d + b;
}

float LinearEaseInOut(float t, float b, float c, float d) {
  return c*t/d + b;
}

float QuadEaseIn (float t, float b, float c, float d) {
  return c*(t/=d)*t + b;
}

float QuadEaseOut(float t, float b, float c, float d) {
  return -c *(t/=d)*(t-2) + b;
}

float QuadEaseInOut(float t, float b, float c, float d) {
  if ((t/=d/2) < 1) return ((c/2)*(t*t)) + b;
  return -c/2 * (((t-2)*(--t)) - 1) + b;
}


float QuintEaseIn (float t, float b, float c, float d) {
  return c*(t/=d)*t*t*t*t + b;
}

float QuintEaseOut(float t, float b, float c, float d) {
  return c*((t=t/d-1)*t*t*t*t + 1) + b;
}

float QuintEaseInOut(float t, float b, float c, float d) {
  if ((t/=d/2) < 1) return c/2*t*t*t*t*t + b;
  return c/2*((t-=2)*t*t*t*t + 2) + b;
}

float SineEaseIn (float t, float b, float c, float d) {
  return -c * cos(t/d * (PI/2)) + c + b;
}

float SineEaseOut(float t, float b, float c, float d) {  
  return c * sin(t/d * (PI/2)) + b;
}

float SineEaseInOut(float t, float b, float c, float d) {
  return -c/2 * (cos(PI*t/d) - 1) + b;
}