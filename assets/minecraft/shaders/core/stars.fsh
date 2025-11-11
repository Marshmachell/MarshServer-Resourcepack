#version 150

#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:globals.glsl>

in vec4 vertexColor;

out vec4 fragColor;

void main() {
    fragColor = vertexColor * 2.0;
}
