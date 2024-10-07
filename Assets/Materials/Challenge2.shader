Shader "Holistic/ChallengePBR2" {
Properties{
		_Color("Color", Color) = (1,1,1,1)
        _MetallicTex ("Metallic (R)", 2D) = "white" {}
        _SpecColor("Specular", Color) = (1,1,1,1)
	}
	SubShader{
		Tags{
			"Queue" = "Geometry"
		}

		CGPROGRAM
		#pragma surface surf StandardSpecular

        sampler2D _MetallicTex;
        fixed4 _Color;

		struct Input {
			float2 uv_MetallicTex;
		};

		void surf(Input IN, inout SurfaceOutputStandardSpecular o) {
            o.Albedo = _Color.rgb * (1 - saturate(tex2D(_MetallicTex, IN.uv_MetallicTex).r));
            //o.Albedo = (0.4 - saturate(tex2D(_MetallicTex, IN.uv_MetallicTex).r));
            o.Smoothness = round(0.6-saturate(tex2D (_MetallicTex, IN.uv_MetallicTex).r)) * 10;
            o.Specular = (tex2D(_MetallicTex, IN.uv_MetallicTex).r + 0.1) * _SpecColor.rgb * 3;
		}
		ENDCG
	}
	FallBack "Diffuse"

}
