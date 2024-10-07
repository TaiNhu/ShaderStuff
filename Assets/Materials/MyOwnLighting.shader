Shader "Custom/MyOwnLightning"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color ("Color", Color) = (1, 1, 1, 1)
        _LightBlash ("Light Blash", Range(0, 1)) = 0
    }
    SubShader
    {
        Tags { "Queue"="Geometry" }

        CGPROGRAM
			#pragma surface surf MyOwnLighting

            sampler2D _MainTex;
            fixed4 _Color;
            fixed _LightBlash;

            half4 LightingMyOwnLighting (SurfaceOutput s, half3 lightDir, half atten)
            {
                half NdotL = dot(normalize(lightDir), s.Normal);
                half4 c;
                //c.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten);
                c.rgb = s.Albedo.rgb * _LightColor0.rgb * (NdotL * atten);
                c.a = s.Albedo;
                return c;
            }

            struct Input
            {
                float2 uv_MyTex;
            };


            void surf (Input IN, inout SurfaceOutput o) 
            {
                o.Albedo = _Color.rgb;
            }
        ENDCG
    }
}
