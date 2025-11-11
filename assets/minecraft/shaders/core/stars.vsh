#version 150

#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:projection.glsl>
#moj_import <minecraft:globals.glsl>
#moj_import <marsh:utils.glsl>
#moj_import <marsh:stars.glsl>

in vec3 Position;
out vec4 vertexColor;

vec3[] COLORS = vec3[](
    vec3(0.200, 0.470, 0.323),
    vec3(0.147, 0.527, 0.319),
    vec3(0.092, 0.426, 0.405),
    vec3(0.121, 0.527, 0.498),
    vec3(0.095, 0.417, 0.560),
    vec3(0.038, 0.455, 0.560),
    vec3(0.062, 0.209, 0.246),
    vec3(0.077, 0.181, 0.307),
    vec3(0.104, 0.077, 0.307)
);

const vec3[] FACUS = vec3[](vec3(70, 85, 145), vec3(113, 219, 0));
const vec3[] QEUS = vec3[](vec3(234, 207, 255), vec3(187, 99, 255));

void main() {
    vec4 worldPos = ModelViewMat * vec4(Position, 1.0);

    int id = gl_VertexID / 4;
    int index = id % COLORS.length();

    float scale = 1.0;
    float offset = float(id) * 100.2;
    float alpha = twinkle(0.076, 0.167, 99, 120, float(id));

    vertexColor = vec4(COLORS[index], alpha);

    if (id == 27) vertexColor = vec4(rgb2Vec3(255, 215, 84), 0.35); // Marshmachell's planet
    if (id == 75) vertexColor = complexGradient(FACUS[0], FACUS[1], 20, 35); // Facus star
    if (id == 76) vertexColor = vec4(rgb2Vec3(42, 105, 21), 0.778); // Falanta's star
    if (id == 100) vertexColor = vec4(rgb2Vec3(246, 0, 255), 1.0); // DasDiamond58's star
    if (id == 21) vertexColor = vec4(rgb2Vec3(102, 19, 12), 1.0); // _trpplvn_'s star
    if (id == 137) vertexColor = vec4(rgb2Vec3(210, 105, 242), 1.0); // L0FFI's star
    if (id == 67) vertexColor = complexGradient(QEUS[0], QEUS[1], 20, 55); // Qeus star
    if (id == 4) vertexColor = vec4(rgb2Vec3(124, 194, 166), 1.0);

    if (id == 27) {worldPos = applyScale(worldPos, 3.0); worldPos = applyRadialAnim(worldPos, 7.7, 3.5, 0.47);}

    gl_Position = ProjMat * worldPos;
}