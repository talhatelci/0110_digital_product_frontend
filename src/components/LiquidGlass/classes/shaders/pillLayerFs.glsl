uniform sampler2D uTexture;
uniform sampler2D uMask1;
uniform sampler2D uMask2;
uniform sampler2D uMask3;
uniform sampler2D uNoise;
uniform float uProgress;

varying vec2 vUv;

void main() {

  vec4 rainbowTexture = texture2D(uTexture, vUv);
  vec3 color = rainbowTexture.rgb;
  float alpha = 1.0;

  float scaleY = vUv.y;
  // if (vUv.y > (1.3 - uProgress)) discard;

  // float mask1 = texture2D(uMask1, vUv).r;
  // alpha *= smoothstep(0.1, 0.8, mask1);

  vec2 discardUv = vUv;
  discardUv.y += uProgress * 0.2;
  float discardMask = texture2D(uMask2, discardUv).r;
  discardMask = smoothstep(0.4, 0.6, discardMask);
  if (discardMask > 0.1) discard;

  vec2 mask2Uv = vUv;
  mask2Uv.y += uProgress * 0.34;
  float mask2 = texture2D(uMask2, mask2Uv).r;
  mask2 = smoothstep(0.6, 0.4, mask2);
  // color = vec3(mask2);
  // color = vec3(discardMask);
  alpha *= mask2;

  // if (alpha < 0.99) discard;
  
  // vec2 mask3Uv = vUv;
  // mask3Uv.y += 0.15;
  // float uv3X = 0.01;
  // float p3 = uProgress;
  // mask3Uv.x = mix(uv3X * p3, 1.0 - uv3X * p3, mask3Uv.x);
  // mask3Uv.y *= 1.0 - (p3) * 0.6;
  // mask3Uv.y += (p3) * 0.2;
  // float mask3 = texture2D(uMask3, mask3Uv).r;
  // alpha  *= smoothstep(0.8, 0.1, mask3);
  // alpha  *= 1.0 - mask3;

  // Noise
  // vec2 noiseUv = vUv;
  // noiseUv.x *= 3.0;
  // vec3 noise = texture2D(uNoise, noiseUv * 20.0).rgb;
  // color += (noise - 0.5) * 0.05;  


  vec3 bgColor = vec3(14.0 / 255.0);
  color = mix(bgColor, color, alpha);

  gl_FragColor = vec4(color, 1.0);
  #include <tonemapping_fragment>
  #include <colorspace_fragment>
}
