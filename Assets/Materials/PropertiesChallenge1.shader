Shader "Holistic/PropChallenge1" 
{
    Properties {
        _myColor ("Example Color", Color) = (1,1,1,1)
        _myRange ("Example Range", Range(1,10)) = 1
        _myTex ("Example Texture", 2D) = "white" {}
        _myNormal ("Example Normal", 2D) = "" {}
        _myCube ("Example Cube", CUBE) = "" {}
        _myFloat ("Example Float", Float) = 0.5
        _myVector ("Example Vector", Vector) = (0.5,1,1,1)
    }
    SubShader {

      CGPROGRAM
        #pragma surface surf Lambert
        
        fixed4 _myColor;
        half _myRange;
        sampler2D _myTex;
        samplerCUBE _myCube;
        float _myFloat;
        float4 _myVector;
        sampler2D _myNormal;

        struct Input {
            float2 uv_myTex;
            float2 uv_myNormal;
            float3 worldRefl; INTERNAL_DATA
        };
        
        void surf (Input IN, inout SurfaceOutput o) {
            o.Albedo = tex2D(_myTex, IN.uv_myTex).rgb;
            o.Normal = UnpackNormal(tex2D(_myNormal, IN.uv_myNormal)) * _myFloat;
            o.Normal *= float3(_myRange, _myRange, 1);
            o.Albedo = texCUBE (_myCube, WorldReflectionVector(IN, o.Normal)).rgb;
        }
      
      ENDCG
    }
    Fallback "Diffuse"
  }
