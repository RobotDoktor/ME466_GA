clear all, close all, clc;

%% Force Balance
h=sqrt((3987.6/2)^2+(1122.4*2/3)^2);
theta=atand(1122.4*2/3/(3987.6/2));
arm=[3114.33 745 2117.53];
f_dir=arm/norm(arm); %unit vector for of piston force direction
f_pos=[-1172.58 1415 1750.95]; %position vector of piston pivot relative to midpoint of bed hinge
w_pos=[-h*cosd(theta+30) 0 h*sind(theta+30)]; %position vector of weight relative to midpoint of bed hinge
mass=23000; %in kg
W=[0 0 -mass*9.8/2];

T_W=cross(w_pos,W); %torque due to bed weight
T_F=cross(f_pos, f_dir); %torque vector due to piston force divided by force magnitude
F=-T_W(2)/T_F(2)

%% Buckling
d_shaft=0.0254;
a_shaft=pi*d_shaft^2/4;

%% Pressure
pressure_i=F/a_shaft
pressure_ext=101*10^3;
thickness=0.2;
r_in=d_shaft/2;
r_out=r_in+thickness;
r=r_out-r_in;

axial_stress=(pressure_i*r_in^2-pressure_ext*r_out^2)/(r_out^2-r_in^2)
tangential_stress=(pressure_i*r_in^2-pressure_ext*r_out^2)/(r_out^2-r_in^2)+(r_in^2*r_out^2*(pressure_i-pressure_ext))/(r*(r_out^2-r_in^2))
