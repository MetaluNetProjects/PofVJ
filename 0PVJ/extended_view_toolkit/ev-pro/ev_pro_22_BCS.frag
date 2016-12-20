// (c)2011-2012 Cyrille Henry & Marian Weger
// part of EXTENDED VIEW TOOLKIT // gpl v3
#version 120

#extension GL_ARB_texture_rectangle : enable

uniform sampler2DRect MyTex;
uniform float Sl,Sr,St,Sb; // shade size
uniform float set_alpha; // toggle alpha set to 1
varying vec2 pos;
uniform float B = 0,C = 1,S = 1;
uniform bool contrastOn = false;

void main (void)
{

    vec4 color = texture2DRect(MyTex, gl_TexCoord[0].st);

    if (set_alpha == 1.) 
    {
        color.a = 1.;
	} 
    else {}

    color.a *=min(1.,pos.x/Sl);
    color.a *=min(1.,(1.-pos.x)/Sr);
    color.a *=min(1.,pos.y/St);
    color.a *=min(1.,(1.-pos.y)/Sb);
    
	if (contrastOn){
		const vec3 lumCoeff = vec3(0.2125,  0.7154, 0.0721);
		float l=min(1,5*length(color.rgb));

		color.rgb /= color.a;
		color.rgb += B; // brightness

		color.rgb = (color.rgb - 0.5) * C + 0.5 ;

		vec3 intens = vec3(dot(color.rgb,lumCoeff));
		color.rgb = mix(intens, color.rgb, S); // saturation
 	
        color.rgb *= color.a;
        color.rgb *= pow(l,0.1);
	}

    gl_FragColor = color;
}
