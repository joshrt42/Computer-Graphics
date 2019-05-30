// Fragment shader

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_LIGHT_SHADER

// These values come from the vertex shader
varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;
varying vec4 vertTexCoord;

void main() {

	float x = 20 * vertTexCoord.s - 10;
	float y = 20 * (1-vertTexCoord.t) - 10;

  float visible = 0.0;
  if (pow(x,2) + pow(y-1,2) < 10.0 && pow(x,2) + pow(y-1,2) > 6.0) {
  	visible = 1.0;
  } else if (pow(x-6.5,2) + pow(y-1,2) < 10.0 && pow(x-6.5,2) + pow(y-1,2) > 6.0) {
  	visible = 1.0;
  } else if (pow(x+6.5,2) + pow(y-1,2) < 10.0 && pow(x+6.5,2) + pow(y-1,2) > 6.0) {
  	visible = 1.0;
  } else if (pow(x-3.25,2) + pow(y+1.5,2) < 10.0 && pow(x-3.25,2) + pow(y+1.5,2) > 6.0) {
  	visible = 1.0;
  } else if (pow(x+3.25,2) + pow(y+1.5,2) < 10.0 && pow(x+3.25,2) + pow(y+1.5,2) > 6.0) {
  	visible = 1.0;
  }
  gl_FragColor = vec4(1-vertTexCoord.s, 0.1, vertTexCoord.t, visible);
}