// NOTE: Shader automatically converted from Godot Engine 4.1.dev1's StandardMaterial3D.

shader_type spatial;
render_mode blend_mix,depth_draw_opaque,cull_back,diffuse_burley,specular_schlick_ggx,unshaded,depth_prepass_alpha;
uniform sampler2D texture_albedo : source_color,filter_linear_mipmap,repeat_enable;
uniform vec3 uv1_scale = vec3(1.0,1.0,1.0);

void vertex() {
	UV=UV*uv1_scale.xy;
}

void fragment() {
	vec2 base_uv = UV;
	vec4 albedo_tex = texture(texture_albedo,base_uv);
	ALBEDO = albedo_tex.rgb;
	ALPHA *= albedo_tex.a;
	DEPTH = 1.0;
}
