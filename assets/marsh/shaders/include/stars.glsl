vec3 getGradientColor(vec3 startColor, vec3 endColor, int steps, int position) {
    if (steps <= 0 || position < 0) return startColor;
    if (position >= steps) return endColor;
    
    float t = float(position) / float(steps);
    return mix(startColor, endColor, t);
}

vec4 complexGradient(vec3 startColor, vec3 endColor, int steps, float speed) {
    int gradientLength = steps + 1;
    float time = GameTime * speed * 1000.0;
    int forwardIndex = int(mod(time, float(gradientLength * 2 - 2)));
    
    int c = gradientLength - 1 - abs(forwardIndex - (gradientLength - 1));
    return vec4(getGradientColor(startColor, endColor, steps, c) / 510.0, 1.0);
}

float getTwinkleValue(float start, float end, float steps, float position) {
    if (steps <= 0.0 || position < 0.0) return start;
    if (position >= steps) return end;
    
    float t = position / steps;
    return mix(start, end, t);
}

float twinkle(float start, float end, float steps, float speed, float offset) {
    float intervalLength = steps + 1.0;
    float forwardPos = mod((GameTime + offset * 123.456) * speed * 1000.0, (intervalLength * 2.0 - 2.0));
    float c = forwardPos;
    if (forwardPos >= intervalLength) {
        c = intervalLength * 2.0 - 2.0 - forwardPos;
    }
    return getTwinkleValue(start, end, steps, c);
}

vec4 applyScale(vec4 worldPos, float scale) {
    int vertexInId = gl_VertexID % 4;
    vec2 offsets = vec2(0.0);

    if (vertexInId == 0) offsets = vec2(-0.1, -0.1);
    else if (vertexInId == 1) offsets = vec2(0.1, -0.1);
    else if (vertexInId == 2) offsets = vec2(0.1, 0.1);
    else if (vertexInId == 3) offsets = vec2(-0.1, 0.1);
    
    offsets *= scale;
    worldPos.xy += offsets;
    
    return worldPos;
}

vec4 applyRadialAnim(vec4 worldPos, float radius, float speed) {
    float time = GameTime * 100000.0 * speed;
    
    float angle = time * 0.001;
    vec2 orbitOffset = vec2(cos(angle), sin(angle)) * radius;
    worldPos.xy += orbitOffset;
    return worldPos;
}

vec4 applyRadialAnim(vec4 worldPos, float radiusX, float radiusY, float speed) {
    float time = GameTime * 100000.0 * speed;
    
    float angle = time * 0.001;
    vec2 orbitOffset = vec2(cos(angle) * radiusX, sin(angle) * radiusY);
    worldPos.xy += orbitOffset;
    return worldPos;
}