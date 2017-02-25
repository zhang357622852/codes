#ifdef GL_ES
precision mediump float;
#endif

varying vec4 v_fragmentColor;
varying vec2 v_texCoord;
uniform sampler2D u_texture;

void main()
{
    gl_FragColor = texture2D(u_texture, v_texCoord) * v_fragmentColor;
	gl_FragColor.r = gl_FragColor.r;
	gl_FragColor.g = gl_FragColor.g;
	gl_FragColor.b = gl_FragColor.b;
	gl_FragColor.a = gl_FragColor.a;
}
