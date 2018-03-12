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
	vec2 pixel = 1./iResolution;
	vec4 col = texture2D(texture, uv);
	vec2 uvTile = vec2(gl_FragCoord.x-0.5-mod(gl_FragCoord.x, tileSize), gl_FragCoord.y-0.5-mod(gl_FragCoord.y, tileSize));//(uv.y-mod(uv.y, pixel.y)));
	uvTile = uvTile / tilesResolution.xy;
	vec4 tile = texture2D(tiles, uvTile);

	if(mod(uv.x, tileSize*pixel.x*2.0) < tileSize*pixel.x){
		col += vec4(1.0, 0.0, 0.0, 0.0);
	}
	if(mod(uv.y, tileSize*pixel.y*2.0) < tileSize*pixel.y){
		col += vec4(0.0, 1.0, 0.0, 0.0);
	}
	
	if(mod(gl_FragCoord.x, tileSize*2.0) < tileSize){
		col += vec4(1.0, 0.0, 0.0, 0.0);
	}
	if(mod(gl_FragCoord.y, 2.0*tileSize) < tileSize){
		col += vec4(0.0, 1.0, 0.0, 0.0);
	}

	gl_FragColor = col;
	//gl_FragColor = vec4(uv.x, 1.0-uv.y, 0.0, 1.0);
	/*
	
	if(mod(iGlobalTime, 4.0) < 0.0){
		gl_FragColor = col;
	}else{
		gl_FragColor = tile;
	}
	*/

}