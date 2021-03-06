#version 330

in vec3 aPosition;
in vec3 aNormal;
in vec2 aTexCoord;
in vec4 aTexWeight;

uniform mat4 uProjection;
uniform mat4 uView;
uniform mat4 uWorld;

uniform vec3 uCameraPosition;
uniform vec4 uClippingPlane;

out vec3 vNormal;
out vec3 vViewPath;
out vec2 vTexCoord;
out vec4 vTexWeight;

out float vDepth;
out float vClip;

void main()
{
	vec4 worldPos = uWorld * vec4(aPosition, 1.0);
	gl_Position = uProjection * uView * worldPos;

	//converte os valores da normal 
	//de coordenada de modelo
	//para coordenada de mundo.
	//ultimo parametro 0.0 pq �
	//uma dire��o
	vNormal = (uWorld * vec4(aNormal, 0.0)).xyz;

	vViewPath = uCameraPosition - worldPos.xyz;
	vTexCoord = aTexCoord;

	float t = aTexWeight.x + aTexWeight.y +
			  aTexWeight.z + aTexWeight.w;

	vTexWeight = aTexWeight / t;

	vDepth = gl_Position.z / gl_Position.w;
	vClip = dot(vec4(aPosition, 1.0), uClippingPlane);
}