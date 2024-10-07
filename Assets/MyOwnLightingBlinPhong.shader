Shader "Custom/MyOwnLightningBlinPhong"
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
			#pragma surface surf MyOwnLightingBlinPhong

            sampler2D _MainTex;
            fixed4 _Color;
            fixed _LightBlash;

            half4 LightingMyOwnLightingBlinPhong (SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
            {
                half3 h = normalize(lightDir + viewDir);

                half diff = dot(normalize(lightDir), s.Normal);
                diff = diff * 0.5 + 0.5;

                half nh = max(0, dot(h, s.Normal));

                half spec = pow(nh, 100) * 10;

                if (diff > 0.87)
                    diff = 1;
                else if (diff > 0.6)
                    diff = 0.756;
                else if (diff > 0.3)
                    diff = 0.356;
                else
                    diff = 0;

                half4 c;
                c.rgb = ((s.Albedo.rgb * _LightColor0.rgb * diff) + (spec * _LightColor0.rgb)) * atten;
                    
                c.a = 1;
                c.rgb = 1;
                return c;
            }

            struct Input
            {
                float2 uv_MyTex;
                float3 viewDir;
            };


            void surf (Input IN, inout SurfaceOutput o) 
            {
                o.Albedo = _Color.rgb;
            }
        ENDCG
    }
}
