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
			#pragma surface surf Lambert
			struct Input {
				float2 uv_MainTex;
				float3 viewDir;
			};
			fixed4 _myColour;
			fixed4 _myEmission;
			sampler2D _MainTex;
			float _ShadowRange;
			half _LineSpecrate;
			half _LineWidth;
			half _LineWidthPow;

			void surf (Input IN, inout SurfaceOutput o)
			{
				half rim = dot(normalize(IN.viewDir), o.Normal);
				half stepRim = step(_ShadowRange, rim);
				o.Albedo = sin((IN.uv_MainTex.x + IN.uv_MainTex.y) * _LineSpecrate) * (1 - stepRim);
				o.Albedo += cos((IN.uv_MainTex.x - IN.uv_MainTex.y) * _LineSpecrate) * (1 - stepRim);
				o.Albedo = pow(abs(sin((IN.uv_MainTex.x + IN.uv_MainTex.y) * _LineSpecrate)), _LineWidthPow) * (1 - stepRim);
				o.Albedo += pow(abs(sin((+IN.uv_MainTex.x - IN.uv_MainTex.y) * _LineSpecrate)), _LineWidthPow) * (1 - stepRim);
				o.Albedo -= 1;
				o.Albedo = abs(o.Albedo);
				o.Albedo *= _myColour.rgb * rim;
			}
		ENDCG
	}

	FallBack "Diffuse"
}
