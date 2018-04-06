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

%%