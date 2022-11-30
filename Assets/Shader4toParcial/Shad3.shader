Shader "Custom/Shad3"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _NormalMap ("Normal Map", 2D) = "bump" {}
        
        
        _FresnelColor ("Fresnel Color", Color) = (1,0,0,0)
        _FresnelWidth ("Fresnel Width", Range(0, 2)) = 2   
        
        _ExtrudeAmount ("Extrude Amount", Range(0.0001, 0.55)) = 0.0001
    }
    SubShader
    {
        Tags { 
            "Queue"="Geometry"
            "RenderType" = "Opaque"
        
        }
        LOD 200
        CGPROGRAM
        #pragma surface surf Standard vertex:vert

        sampler2D _MainTex;
        sampler2D _NormalMap;
        
        half _Metallic;
        fixed4 _FresnelColor;
        float _FresnelWidth;
        float _FresnelPower;
        float _ExtrudeAmount;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_NormalMap;
            float3 viewDir; // ray coming out of the camera into the pixel
        };
        //fixed4 frag(v2f i): SV_Target

        void vert(inout appdata_full v)
        {
            v.vertex.xyz += (v.normal * abs(frac(_Time.y * (1 / (_ExtrudeAmount * 5)))))/15;

        }

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
            o.Normal = tex2D(_NormalMap, IN.uv_NormalMap);
            o.Metallic = 1;
            
            
            // fresnel
            float fresnelDot = dot(o.Normal, normalize(IN.viewDir));
            fresnelDot = saturate(fresnelDot); // clamp to 0,1
            float fresnel = max(0.0, pow(_ExtrudeAmount, 0)/ _ExtrudeAmount - fresnelDot); // fresnelDot is zero when normal is 90 deg angle from view dir

//            o.Emission = _FresnelColor * pow(fresnel, _FresnelPower) * (_ExtrudeAmount * 2);
            o.Emission = _FresnelColor * pow(fresnel, 10) * abs(frac(_Time.y * (1 / (_ExtrudeAmount * 5))));
        }
        ENDCG
            Pass
        {
                              

            Tags {"RenderType" = "Fade"}
            ZWrite On
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _ExtrudeAmount;
            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                
            
            //i.uv.x += _Time.y;
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
            // apply fog
            UNITY_APPLY_FOG(i.fogCoord, col);
            return col;
        }
        ENDCG
        }
    }
    FallBack "Diffuse"
}