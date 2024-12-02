Shader "Custom/DotProduct2_URP"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _Range("Range", Range(0,1)) = 1
        _MainTex("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderPipeline" = "UniversalRenderPipeline" }
        Pass
        {
            Name "ForwardLit"
            Tags { "LightMode" = "UniversalForward" }

            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            // Properties
            TEXTURE2D(_MainTex); SAMPLER(sampler_MainTex);
            float4 _Color;
            float _Range;

            struct VertexInput
            {
                float4 position : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct FragmentInput
            {
                float4 position : SV_POSITION;
                float3 worldNormal : TEXCOORD0;
                float3 viewDir : TEXCOORD1;
                float2 uv : TEXCOORD2;
            };

            VertexInput vert(VertexInput v)
            {
                FragmentInput o;
                o.position = TransformObjectToHClip(v.position);
                o.worldNormal = TransformObjectToWorldNormal(v.normal);
                o.viewDir = GetCameraPositionWS() - TransformObjectToWorld(v.position).xyz;
                o.uv = v.uv;
                return o;
            }

            half4 frag(FragmentInput i) : SV_Target
            {
                // Normalize inputs
                float3 normal = normalize(i.worldNormal);
                float3 viewDir = normalize(i.viewDir);

                // Rim lighting
                half rim = 1.0 - saturate(dot(viewDir, normal));
                float rimColor = pow(rim, _Range);

                // Texture and transparency control
                float4 albedo = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.uv * _Range);
                albedo.rgb *= _Color.rgb;

                // Combine emission and albedo
                float3 emission = float3(rimColor, 0, 0); // Rim effect on red channel
                return float4(albedo.rgb + emission, albedo.a);
            }
            ENDHLSL
        }
    }
}