#ifdef GL_ES
// Set default precision to medium
precision mediump int;
precision mediump float;
#endif

uniform int u_txt;

varying vec4 v_xyz;
varying vec4 v_rgb;
varying vec3 v_eyeDir;

//! [0]
void main()
{

	    
    
    if(u_txt==1)
	{
		gl_FragColor =v_rgb;
	}
	else if(u_txt==2)
	{
		
		float specularFactor =0.8;
		vec3 ec_pos=v_xyz.xyz;
		vec3 ec_normal = normalize(cross(dFdx(ec_pos),dFdy(ec_pos)));
		vec3 lightDir = vec3(0.4, 0.48, 0.51);
		float spec = max(dot(ec_normal, lightDir), 0.0)*specularFactor/2.0+
					 max(dot(ec_normal, -lightDir), 0.0)*specularFactor/2.0+
					 (1.0-specularFactor);
		gl_FragColor = vec4(vec3(v_rgb*spec),1.0); 
		

	}
    else if(u_txt==3)
	{
			vec3 ec_pos=vec3(v_xyz[0],v_xyz[1],v_xyz[2]);
			vec3 ec_normal = normalize(cross(dFdx(ec_pos),dFdy(ec_pos)));
			gl_FragColor = vec4((1.0+ec_normal)*0.5,1.0);
			
			
	}
	else if(u_txt==4)
	{
		vec3 lightDir = vec3(0.4, 0.48, 0.51);
  		vec4 specularColor1=vec4 (0.1,0.08,0.05,1.0);
  		vec4 specularColor2=vec4 (0.1,0.1,0.05,1.0);
  		vec4 glassColor=vec4(0.5,0.5,0.6,0.15);
  		float specularFactor1=2.0;
  		float specularFactor2=2.0;
  		vec3 ec_pos=vec3(v_xyz[0],v_xyz[1],v_xyz[2]);
  		vec3 ec_normal = normalize(cross(dFdx(ec_pos),dFdy(ec_pos)));
  	    vec3 reflectDir = -reflect(lightDir, ec_normal);
  	    float spec = max(dot(v_eyeDir, reflectDir), 0.0);
  	    spec = spec * spec;
  		vec4 color = glassColor + specularFactor1 * spec * specularColor1;
  	    spec = pow(spec, 8.0) * specularFactor2;
  		color += spec * specularColor2;
  		gl_FragColor = min(color, vec4(1.0));
	}
	else
	{
		vec3 base3 = vec3(0.99, 0.96, 0.89);
		vec3 base2 = vec3(0.92, 0.91, 0.83);
		vec3 base00 = vec3(0.40, 0.48, 0.51);
		vec3 va = vec3(0.0, 0.0, 1.0);
		vec3 vb = vec3(-0.57, -0.57, 0.57);
		vec3 ec_pos=vec3(v_xyz[0]/v_xyz[3],v_xyz[1]/v_xyz[3],v_xyz[2])/v_xyz[3];
		vec3 ec_normal = normalize(cross(dFdx(ec_pos), dFdy(ec_pos)));
		ec_normal = normalize(ec_normal);
		float a = dot(ec_normal, va);
		float b = dot(ec_normal, vb);
		gl_FragColor = vec4(((a*base2 + (1.0-a)*base00) + (b*base3 + (1.0-b)*base00))*0.5, 1.0); 
	}
    
    
}
//! [0]

