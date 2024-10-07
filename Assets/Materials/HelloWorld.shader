Shader "FirstShader/HelloWorld"
{
	Properties {
		_myColour ("Albedo color", Color) = (1, 1, 1, 1)
		_myEmission ("Emission color", Color) = (1, 1, 1, 1)
		_MainTex ("Texture", 2D) = "white" {}
	}

	SubShader {
		CGPROGRAM
			#pragma surface surf Lambert
			struct Input {
				float2 uv_MainTex;
			};
			fixed4 _myColour;
			fixed4 _myEmission;
			sampler2D _MainTex;
			void surf (Input IN, inout SurfaceOutput o)
			{
				o.Albedo = IN.uv_MainTex.y;
			}
		ENDCG
	}

	FallBack "Diffuse"
}
