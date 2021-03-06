#ifdef GL_ES
// Set default precision to medium
precision mediump int;
precision mediump float;
#endif

uniform int u_txt;
uniform vec3 u_lightDir;

varying vec4 v_xyz;
varying vec4 v_rgb;
varying vec3 v_eyeDir;
varying float v_z;

//! [0]
void main()
{

	    
    
    if(u_txt==1)
	{
		gl_FragColor =v_rgb;
	}
	else if(u_txt==2)
	{
		
		float specularFactor =0.5;
		vec3 ec_pos=v_xyz.xyz;
		vec3 ec_normal = normalize(cross(dFdx(ec_pos),dFdy(ec_pos)));
		float v = abs(dot(ec_normal, u_lightDir));
		float spec = max(v, 0.0)*specularFactor/2.0+
					 max(-v, 0.0)*specularFactor/2.0+
					 (1.0-specularFactor);
		gl_FragColor = vec4(vec3(v_rgb*spec),1.0); 
		

	}
	else if(u_txt==4)
	{
		
  		vec4 specularColor1=vec4 (0.1,0.08,0.05,1.0);
  		vec4 specularColor2=vec4 (0.1,0.1,0.05,1.0);
  		vec4 glassColor=vec4(0.5,0.5,0.6,0.15);
  		float specularFactor1=2.0;
  		float specularFactor2=2.0;
  		vec3 ec_pos=vec3(v_xyz[0],v_xyz[1],v_xyz[2]);
  		vec3 ec_normal = normalize(cross(dFdx(ec_pos),dFdy(ec_pos)));
  	    vec3 reflectDir = -reflect(u_lightDir, ec_normal);
  	    float spec = max(dot(v_eyeDir, reflectDir), 0.0);
  	    spec = spec * spec;
  		vec4 color = glassColor + specularFactor1 * spec * specularColor1;
  	    spec = pow(spec, 8.0) * specularFactor2;
  		color += spec * specularColor2;
  		gl_FragColor = min(color, vec4(1.0));
	}
	else if(u_txt==5)
	{
		gl_FragColor = vec4(v_z,v_z,v_z,1.0); 
	}
	else
	{
		gl_FragColor=vec4(0.0,0.0,0.0,1.0);	
	}
    
    
}
//! [0]

