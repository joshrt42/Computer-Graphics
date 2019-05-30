// Fragment shader

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_LIGHT_SHADER

uniform float cx;
uniform float cy;

// These values come from the vertex shader
varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;
varying vec4 vertTexCoord;

void main() {

	vec2 z = 3 * vertTexCoord.xy - 1.5;
	vec2 c = vec2(cx, cy);
	vec4 color = vec4(vertColor);
	for (int i = 0; i < 20; i++) {
		if (abs(z.x*z.x + z.y*z.y) <= 1.0) {
			color = vec4(1.0, 1.0, 1.0, 1.0);
		} else {
			color = vec4(1.0, 0.0, 0.0, 1.0);
		}
		float newZX = z.x*z.x - z.y*z.y + c.x;
		z.y = 2.0 * z.x * z.y + c.y;
		z.x = newZX;
	}

  	gl_FragColor = vec4(color);
}