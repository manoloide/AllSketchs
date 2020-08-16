uniform float iGlobalTime;
uniform vec2 iResolution;
uniform sampler2D texture;
 
const float blurSize = 1.0/640.0;

uniform float intensity = 1.3;

void main()
{
   vec4 sum = vec4(0);
   vec2 texcoord = gl_FragCoord.xy/iResolution.xy;
 
   sum += texture2D(texture, vec2(texcoord.x - 4.0*blurSize, texcoord.y)) * 0.05;
   sum += texture2D(texture, vec2(texcoord.x - 3.0*blurSize, texcoord.y)) * 0.09;
   sum += texture2D(texture, vec2(texcoord.x - 2.0*blurSize, texcoord.y)) * 0.12;
   sum += texture2D(texture, vec2(texcoord.x - blurSize, texcoord.y)) * 0.15;
   sum += texture2D(texture, vec2(texcoord.x, texcoord.y)) * 0.16;
   sum += texture2D(texture, vec2(texcoord.x + blurSize, texcoord.y)) * 0.15;
   sum += texture2D(texture, vec2(texcoord.x + 2.0*blurSize, texcoord.y)) * 0.12;
   sum += texture2D(texture, vec2(texcoord.x + 3.0*blurSize, texcoord.y)) * 0.09;
   sum += texture2D(texture, vec2(texcoord.x + 4.0*blurSize, texcoord.y)) * 0.05;
 
   sum += texture2D(texture, vec2(texcoord.x, texcoord.y - 4.0*blurSize)) * 0.05;
   sum += texture2D(texture, vec2(texcoord.x, texcoord.y - 3.0*blurSize)) * 0.09;
   sum += texture2D(texture, vec2(texcoord.x, texcoord.y - 2.0*blurSize)) * 0.12;
   sum += texture2D(texture, vec2(texcoord.x, texcoord.y - blurSize)) * 0.15;
   sum += texture2D(texture, vec2(texcoord.x, texcoord.y)) * 0.16;
   sum += texture2D(texture, vec2(texcoord.x, texcoord.y + blurSize)) * 0.15;
   sum += texture2D(texture, vec2(texcoord.x, texcoord.y + 2.0*blurSize)) * 0.12;
   sum += texture2D(texture, vec2(texcoord.x, texcoord.y + 3.0*blurSize)) * 0.09;
   sum += texture2D(texture, vec2(texcoord.x, texcoord.y + 4.0*blurSize)) * 0.05;
 
   gl_FragColor = sum*(intensity+cos(iGlobalTime)*0.2+0.1) + texture2D(texture, texcoord);
 
}