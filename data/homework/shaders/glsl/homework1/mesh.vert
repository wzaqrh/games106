#version 450

layout (location = 0) in vec4 inPos;
layout (location = 1) in vec3 inNormal;
layout (location = 2) in vec2 inUV;
layout (location = 3) in vec3 inColor;

layout (set = 0, binding = 0) uniform UBO 
{
	mat4 projection;
	mat4 view;
	vec3 camPos;
} ubo;

layout(push_constant) uniform PushConsts {
	mat4 model;
} primitive;

layout (location = 0) out vec2 outUV;
layout (location = 1) out vec3 outColor;
layout (location = 2) out vec3 outNormal;
layout (location = 3) out vec3 outWorldPos;

void main() 
{
	outColor = inColor;
	outUV = inUV;

	outNormal = mat3(primitive.model) * inNormal;

	vec4 worldPos = primitive.model * inPos;
	outWorldPos = worldPos.xyz;
	gl_Position =  ubo.projection * ubo.view * worldPos;
}