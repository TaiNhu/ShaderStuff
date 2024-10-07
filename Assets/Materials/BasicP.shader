Shader "Custom/BasicP"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _SpecColor ("Spec Color", Color) = (1,1,1,1)
        _Metalic ("Metalic", Range(0, 1)) = 0.5
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _MetallicTex ("Metallic", 2D) = "white" {}
    }
    SubShader
    {

        Tags {
            "Queue" = "Geometry"
        }
        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf StandardSpecular

        sampler2D _MainTex;
        sampler2D _MetallicTex;

        struct Input
        {
            float2 uv_MainTex;
            float3 viewDir;
        };

        fixed4 _Color;
        half _Metalic;


        void surf (Input IN, inout SurfaceOutputStandardSpecular o)
        {
            //float rim = saturate(dot(normalize(IN.viewDir), o.Normal));
            o.Albedo = _Color.rgb;
            o.Smoothness = tex2D(_MetallicTex, IN.uv_MainTex);
            o.Specular = _SpecColor;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
