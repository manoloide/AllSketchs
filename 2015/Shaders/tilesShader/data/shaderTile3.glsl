#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER
uniform sampler2D texture;
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform vec2 iResolution;
uniform float iGlobalTime;
uniform vec2 cameraPosition;

uniform sampler2D tiles;
uniform vec2 tilesResolution;
uniform float tileSize; 

void main(void)
{
	vec2 uv = gl_FragCoord.xy / iResolution.xy;
	float sx = gl_FragCoord.x;
	float sy = iResolution.y-gl_FragCoord.y;
	vec2 sp = vec2(sx, sy);
	vec2 pixel = 1./iResolution;
	//vec4 col = texture2D(texture, uv);
	vec2 t = (floor((sp-0.5)-mod(sp+0.5, tileSize))/tilesResolution.xy)/tileSize;


	vec4 tile = texture2D(tiles, t);
	/*
	if(mod(uv.x, tileSize*pixel.x*2.0) < tileSize*pixel.x){
		col += vec4(1.0, 0.0, 0.0, 0.0);
	}
	if(mod(uv.y, tileSize*pixel.y*2.0) < tileSize*pixel.y){
		col += vec4(0.0, 1.0, 0.0, 0.0);
	}
	*/
	/*
	if(mod(sx, tileSize*2.0) < tileSize){
		col += vec4(1.0, 0.0, 0.0, 0.0);
	}
	if(mod(sy, 2.0*tileSize) < tileSize){
		col += vec4(0.0, 1.0, 0.0, 0.0);
	}
	*/
	

	gl_FragColor = tile;//vec4(tx, ty, ty, 1.0);//col;//vec4(col.r*tx, col.g*ty, col.b, col.a);
}