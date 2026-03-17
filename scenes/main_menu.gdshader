shader_type canvas_item;

uniform float speed = 0.1;

void fragment() {
	vec2 uv = vec2(UV.x + sin(speed * TIME), UV.y - cos(speed * TIME));
	COLOR = texture(TEXTURE, uv);
}