Shader "Custom/Shad4"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _NormalMap ("Normal Map", 2D) = "bump" {}
        _Smoothness ("Smoothness", Range(0.0, 1.0)) = 0.5
        _Metallic ("Metallic", Range(0.0, 1.0)) = 0.0
        _FresnelColor ("Fresnel Color", Color) = (0,1,1,1)
        _FresnelWidth ("Fresnel Width", Range(0, 2)) = 0.5
        _FresnelPower ("Fresnel Power", Range(1, 10)) = 1
        _Freq("Frequency", Range(0,5)) = 3
        _Speed("Speed",Range(0,100)) = 10
        _Amp("Amplitude",Range(0,1)) = 0.5
       
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Standard vertex:vert

        sampler2D _MainTex;
        sampler2D _NormalMap;
        half _Smoothness;
        half _Metallic;
        fixed4 _FresnelColor;
        float _FresnelWidth;
        float _FresnelPower;
        

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_NormalMap;
            float3 vertColor;
            float3 viewDir; // ray coming out of the camera into the pixel
        };
        float _Freq;
        float _Speed;
        float _Amp;

        struct appdata {
            float4 vertex: POSITION;
            float3 normal: NORMAL;
            float4 texcoord: TEXCOORD0;
            float4 texcoord1: TEXCOORD1;
            float4 texcoord2: TEXCOORD2;
        };
        void vert(inout appdata_full v, out Input o)
        {
            UNITY_INITIALIZE_OUTPUT(Input, o);
            float t = _Time * _Speed;
            float waveHeight = cos(t + v.vertex.x * _Amp) * _Amp;
            v.vertex.y = v.vertex.y + waveHeight;
            v.normal = normalize(float3(v.normal.x, v.normal.y, v.normal.z));
            
        }

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
            o.Normal = tex2D(_NormalMap, IN.uv_NormalMap);
            o.Metallic = _Metallic;
            o.Smoothness = _Smoothness;

            // fresnel
            float fresnelDot = dot(o.Normal, normalize(IN.viewDir));
            fresnelDot = saturate(fresnelDot); // clamp to 0,1
            float fresnel = max(0.0, _FresnelWidth - fresnelDot); // fresnelDot is zero when normal is 90 deg angle from view dir

            o.Emission = _FresnelColor * pow(fresnel, _FresnelPower);
        }
        ENDCG
    }
    FallBack "Diffuse"
}