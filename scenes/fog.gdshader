shader_type canvas_item;

uniform float ratio = 4;
uniform float width = 1280;
uniform float height = 720;

void fragment() {
	vec2 grid_uv = vec2(trunc(UV.x * width / ratio) * ratio / width, trunc(UV.y * height / ratio) * ratio / height);
	
	COLOR = texture(TEXTURE, grid_uv);
}