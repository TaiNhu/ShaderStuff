Shader "Custom/HandDrawn"
{
	Properties {
		_myColour ("Albedo color", Color) = (1, 1, 1, 1)
		_myEmission ("Emission color", Color) = (1, 1, 1, 1)
		_MainTex ("Texture", 2D) = "white" {}
		_ShadowRange ("Shadow range", Range(0, 1)) = 0
		_LineSpecrate ("Specrate", float) = 80 
		_LineWidth ("Line Width", Range(0, 1)) = 0.95
		_LineWidthPow("Pow Line", float) = 1
	}

	SubShader {
		CGPROGRAM
			#pragma surface surf HandDrawn
			fixed4 _myColour;
			fixed4 _myEmission;
			sampler2D _MainTex;
			float _ShadowRange;
			half _LineSpecrate;
			half _LineWidth;
			half _LineWidthPow;
			half2 _uv;
			half _edge;
			half4 LightingHandDrawn (SurfaceOutput s, half3 lightDir, half atten)
			{
				half rim = dot(normalize(lightDir), s.Normal);
				half stepRim = step(_ShadowRange, rim);
				half4 c;
				c.rgb = step(0.5, pow(abs(sin((_uv.x - _uv.y) * _LineSpecrate)), _LineWidthPow)) * (1 - stepRim);
				if (rim < 0.06)
					c.rgb += step(0.5, pow(abs(sin((_uv.x + _uv.y) * _LineSpecrate)), _LineWidthPow)) * (1 - stepRim);
				c.rgb = min(1, c.rgb);
				c.rgb -= 1;
				c.rgb = abs(c.rgb);
				if (rim > _ShadowRange + 0.25) rim = 1;
				else if (rim > _ShadowRange + 0.1) rim = 0.755;
				else if (rim > _ShadowRange) rim = 0.45;
				else rim = 0.3;
				c.rgb *= _LightColor0.rgb * max(0.3, rim);
				c.rgb *= _edge;
				c.a = s.Alpha;
				return c;
			}
			struct Input {
				float2 uv_MainTex;
				float3 viewDir;
			};

			void surf (Input IN, inout SurfaceOutput o)
			{
				half rim = dot(normalize(IN.viewDir), o.Normal);
				if (rim < 0.3) rim = 0;
				else rim = 1;
				o.Albedo = _myColour.rgb * rim;
				_uv = IN.uv_MainTex;
				_edge = rim;
			}
		ENDCG
	}

	FallBack "Diffuse"
}
