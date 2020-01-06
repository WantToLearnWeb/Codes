Shader "Custom/Rotate"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_AngularVelocity ("Angular Velocity", Range(1, 10)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

			float _AngularVelocity;
			static float2 center = { 0.5, 0.5 };

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
				float2 uv = i.uv;
				float2 dt = uv - center;
				float theta = _AngularVelocity * _Time.y;

				float2x2 rotate =
				{
					cos(theta), sin(theta),
					-sin(theta), cos(theta)
				};

				dt = mul(rotate, dt);
				uv = center + dt;

				fixed4 col = tex2D(_MainTex, uv);
                return col;
            }
            ENDCG
        }
    }
}
