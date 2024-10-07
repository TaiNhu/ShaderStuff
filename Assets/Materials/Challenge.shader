Shader "Custom/Challenge"
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
			#pragma surface surf Lambert
            //MyOwnCartoonLightting

            sampler2D _MainTex;
            fixed4 _Color;
            fixed _LightBlash;

            //half4 LightingMyOwnCartoonLightting (SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
            //{
            //    half3 h = normalize(lightDir + viewDir);
            //    half nh = max(0, dot(s.Normal, h));
            //    half diff = max(0, dot(normalize(lightDir), s.Normal));
            //    half4 c;
            //    c.rgb = pow(nh, 48) * _LightColor0.rgb;
            //    c.a = 1;
            //    return c;
            //}


            struct Input
            {
                float2 uv_MyTex;
                float3 viewDir;
            };

            void surf (Input IN, inout SurfaceOutput o) 
            {
                half rim = dot(normalize(IN.viewDir), o.Normal);
                if (rim > 0.87)
                    rim = 1;
                else if (rim > 0.6)
                    rim = 0.756;
                else if (rim > 0.3)
                    rim = 0.356;
                else
                    rim = 0;
                o.Albedo = _Color.rgb * rim;
            }
        ENDCG
    }
}
