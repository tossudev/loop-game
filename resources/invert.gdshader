shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float target_value : hint_range(0.0, 1.0) = 1.0;

void fragment() {
	//float value = cos(TIME);
	
	vec4 color = vec4(texture(SCREEN_TEXTURE, SCREEN_UV).rgb, texture(TEXTURE, UV).a);
	vec3 invert = 1.0 - color.rgb;
	
	float v = target_value;
	
	vec3 final = vec3(mix(color.r, invert.r, v), mix(color.r, invert.r, v), mix(color.r, invert.r, v));
	
	COLOR = vec4(final, color.a);
}
