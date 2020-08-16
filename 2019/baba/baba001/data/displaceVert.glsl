
#define PROCESSING_TEXLIGHT_SHADER

uniform mat4 modelview;
uniform mat4 transform;
uniform mat3 normalMatrix;
uniform mat4 texMatrix;

uniform int lightCount;
uniform vec4 lightPosition[8];
uniform vec3 lightNormal[8];
uniform vec3 lightAmbient[8];
uniform vec3 lightDiffuse[8];
uniform vec3 lightSpecular[8];
uniform vec3 lightFalloff[8];
uniform vec2 lightSpot[8];

attribute vec4 vertex;
attribute vec4 color;
attribute vec3 normal;
attribute vec2 texCoord;

attribute vec4 ambient;
attribute vec4 specular;
attribute vec4 emissive;
attribute float shininess;

varying vec4 vertColor;
varying vec4 vertTexCoord;

const float zero_float = 0.0;
const float one_float = 1.0;
const vec3 zero_vec3 = vec3(0);

uniform sampler2D displacementMap;
uniform float displaceStrength;
uniform float time;

float falloffFactor(vec3 lightPos, vec3 vertPos, vec3 coeff) {
  vec3 lpv = lightPos - vertPos;
  vec3 dist = vec3(one_float);
  dist.z = dot(lpv, lpv);
  dist.y = sqrt(dist.z);
  return one_float / dot(dist, coeff);
}

float spotFactor(vec3 lightPos, vec3 vertPos, vec3 lightNorm, float minCos, float spotExp) {
  vec3 lpv = normalize(lightPos - vertPos);
  vec3 nln = -one_float * lightNorm;
  float spotCos = dot(nln, lpv);
  return spotCos <= minCos ? zero_float : pow(spotCos, spotExp);
}

float lambertFactor(vec3 lightDir, vec3 vecNormal) {
  return max(zero_float, dot(lightDir, vecNormal));
}

float blinnPhongFactor(vec3 lightDir, vec3 vertPos, vec3 vecNormal, float shine) {
  vec3 np = normalize(vertPos);
  vec3 ldp = normalize(lightDir - np);
  return pow(max(zero_float, dot(ldp, vecNormal)), shine);
}

void main() {
  // Calculating texture coordinates, with r and q set both to one
  vertTexCoord = texMatrix * vec4(texCoord, 1.0, 1.0);

  vec4 dv = texture2D( displacementMap, vertTexCoord.st ); // rgba color of displacement map
  float df = 0.30*dv.r + 0.59*dv.g + 0.11*dv.b; // brightness calculation to create displacement float from rgb values
  vec4 newVertexPos = vertex + vec4(normal * df * displaceStrength, 0.0); // regular vertex position + direction * displacementMap * displaceStrength

  // Vertex in clip coordinates
  gl_Position = transform * newVertexPos;
    
  // Vertex in eye coordinates
  vec3 ecVertex = vec3(modelview * vertex);
  
  // Normal vector in eye coordinates
  vec3 ecNormal = normalize(normalMatrix * normal);
  
  if (dot(-one_float * ecVertex, ecNormal) < zero_float) {
    // If normal is away from camera, choose its opposite.
    // If we add backface culling, this will be backfacing
    ecNormal *= -one_float;
  }

  // Light calculations
  vec3 totalAmbient = vec3(0, 0, 0);
  vec3 totalDiffuse = vec3(0, 0, 0);
  vec3 totalSpecular = vec3(0, 0, 0);
  for (int i = 0; i < 8; i++) {
    if (lightCount == i) break;
    
    vec3 lightPos = lightPosition[i].xyz;
    bool isDir = zero_float < lightPosition[i].w;
    float spotCos = lightSpot[i].x;
    float spotExp = lightSpot[i].y;
    
    vec3 lightDir;
    float falloff;
    float spotf;
      
    if (isDir) {
      falloff = one_float;
      lightDir = -one_float * lightNormal[i];
    } else {
      falloff = falloffFactor(lightPos, ecVertex, lightFalloff[i]);
      lightDir = normalize(lightPos - ecVertex);
    }
  
    spotf = spotExp > zero_float ? spotFactor(lightPos, ecVertex, lightNormal[i],
                                              spotCos, spotExp)
                                 : one_float;
    
    if (any(greaterThan(lightAmbient[i], zero_vec3))) {
      totalAmbient += lightAmbient[i] * falloff;
    }
    
    if (any(greaterThan(lightDiffuse[i], zero_vec3))) {
      totalDiffuse += lightDiffuse[i] * falloff * spotf *
                       lambertFactor(lightDir, ecNormal);
    }
    
    if (any(greaterThan(lightSpecular[i], zero_vec3))) {
      totalSpecular += lightSpecular[i] * falloff * spotf *
                       blinnPhongFactor(lightDir, ecVertex, ecNormal, shininess);
    }
  }
  
  // Calculating final color as result of all lights (plus emissive term).
  // Transparency is determined exclusively by the diffuse component.
  vertColor = (vec4(totalAmbient, 0) * ambient +
              vec4(totalDiffuse, 1) * color +
              vec4(totalSpecular, 0) * specular +
              vec4(emissive.rgb, 0)) * color * 1.5;
              
}
