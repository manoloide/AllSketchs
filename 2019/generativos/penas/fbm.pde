float random2 (float x, float y) {
  float d = x*12.9898+y*78.233;
  return (abs(sin(d)*43758.5453123))%1;
}


float noise2 (float x, float y) {
  float ix = floor(x);
  float iy = floor(y);
  float fx = x%1;
  float fy = y%1;

  // Four corners in 2D of a tile
  float a = random2(ix, iy);
  float b = random2(ix+1, iy);
  float c = random2(ix, iy+1);
  float d = random2(ix+1, iy+1);

  float ux = fx * fx * (3.0 - 2.0 * fx);
  float uy = fy * fy * (3.0 - 2.0 * fy);

  return lerp(a, b, pow(ux, 1.2)) +
    (c - a)* uy * (1.0 - ux) +
    (d - b) * ux * uy;
}

float fbm (float x, float y) {
  int oct = 4;
  float val = -0.1;
  float amp = .44;
  for (int i = 0; i < oct; i++) {
    val += amp * abs(noise2(x, y));
    x *= 2.2;
    y *= 1.8;
    amp *= .4;
  }
  return val;
}

float ridge(float h, float offset) {
  h = abs(h);     // create creases
  h = offset - h; // invert so creases are at top
  h = h * h;      // sharpen creases
  return h;
}

float ridgedMF(float x, float y) {
  int oct = 4;
  float lacunarity = 2.0;
  float gain = 0.5;
  float offset = 0.9;

  float sum = 0.0;
  float freq = 1.0, amp = 0.5;
  float prev = 1.0;
  for (int i = 0; i < oct; i++) {
    float n = ridge(fbm(x*freq, y*freq), offset);
    sum += n*amp;
    sum += n*amp*prev;  // scale by previous octave
    prev = n;
    freq *= lacunarity;
    amp *= gain;
  }
  return sum;
}
