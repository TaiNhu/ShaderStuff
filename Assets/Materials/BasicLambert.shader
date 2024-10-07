Shader "Custom/BasicLambert"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _SpecColor ("Spec Color", Color) = (1,1,1,1)
        _Spec ("Specular", Range(0, 1)) = 0.5
        _Gloss("Gloss", Range(0, 1)) = 0.5
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {

        Tags {
            "Queue" = "Geometry"
        }
        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
            float3 viewDir;
        };

        fixed4 _Color;
        half _Spec;
        float _Gloss;


        void surf (Input IN, inout SurfaceOutput o)
        {
            //float rim = saturate(dot(normalize(IN.viewDir), o.Normal));
            o.Albedo = _Color.rgb;
            o.Gloss = _Gloss;
            o.Specular = _Spec;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
