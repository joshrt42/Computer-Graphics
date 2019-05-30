// Fragment shader

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXLIGHT_SHADER

// Set in Processing
uniform sampler2D texture;

// These values come from the vertex shader
varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;
varying vec4 vertTexCoord;


void main() {

  	vec4 diffuse_color = texture2D(texture, vertTexCoord.xy);
  	for (float x = -10.0; x < 10.0; x++) {
  		for (float y = -10.0; y < 10.0; y++) {
  			diffuse_color += texture2D(texture, vertTexCoord.xy + vec2(x/200.0,y/200.0));
  		}
  	}

  	diffuse_color/= 441.0;






  float diffuse = clamp(dot (vertNormal, vertLightDir),0.0,1.0);




  gl_FragColor = vec4(diffuse * diffuse_color.rgb, 1.0);
}