#version 150

#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:matrix.glsl>
#moj_import <minecraft:globals.glsl>

uniform sampler2D Sampler0;
uniform sampler2D Sampler1;

in vec4 texProj0;
in float sphericalVertexDistance;
in float cylindricalVertexDistance;

const vec3[] COLORS = vec3[](
    vec3(0.117647, 0.788235, 0.000000),
    vec3(0.282353, 0.909804, 0.172549),
    vec3(0.125490, 0.588235, 0.043137),
    vec3(0.549020, 1.000000, 0.470588),
    vec3(0.345098, 0.721569, 0.282353),
    vec3(0.200000, 0.850980, 0.086275),
    vec3(0.450980, 0.937255, 0.321569),
    vec3(0.082353, 0.666667, 0.015686),
    vec3(0.627451, 0.956863, 0.588235),
    vec3(0.274510, 0.803922, 0.196078),
    vec3(0.164706, 0.737255, 0.054902),
    vec3(0.392157, 0.882353, 0.250980),
    vec3(0.031373, 0.521569, 0.000000),
    vec3(0.705882, 0.980392, 0.654902),
    vec3(0.231373, 0.772549, 0.129412),
    vec3(1.0, 1.0, 1.0)
);

const mat4 SCALE_TRANSLATE = mat4(
    0.5, 0.0, 0.0, 0.25,
    0.0, 0.5, 0.0, 0.25,
    0.0, 0.0, 1.0, 0.0,
    0.0, 0.0, 0.0, 1.0
);

mat4 end_portal_layer(float layer) {
    float centerX = 0.0;
    float centerY = 0.0;

    // Основное вращение (быстрое)
    mat2 rotate = mat2_rotate_z(radians(GameTime * 5000.0));

    // Масштабирование и трансляция из оригинала
    mat2 scale = mat2((4.5 - layer / 4.0) * 2.0);
    
    mat4 translate = mat4(
        1.0, 0.0, 0.0, 17.0 / layer + centerX,
        0.0, 1.0, 0.0, (2.0 + layer / 1.5) * (GameTime * 5.5) + centerY,
        0.0, 0.0, 1.0, 0.0,
        0.0, 0.0, 0.0, 1.0
    );

    return mat4(scale * rotate) * translate * SCALE_TRANSLATE;
}

out vec4 fragColor;

void main() {
    vec3 color = textureProj(Sampler0, texProj0).rgb * COLORS[0];
    for (int i = 0; i < PORTAL_LAYERS; i++) {
        color += textureProj(Sampler1, texProj0 * end_portal_layer(float(i + 1))).rgb * COLORS[i];
        fragColor = apply_fog(vec4(color, 1.0), sphericalVertexDistance, cylindricalVertexDistance, FogEnvironmentalStart, FogEnvironmentalEnd, FogRenderDistanceStart, FogRenderDistanceEnd, FogColor);
    }
}