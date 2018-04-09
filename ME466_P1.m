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
S_y=303*10^6; %Pa
S_ut=365*10^6; %Pa

d_shaft=[0.01 0.02 0.03 0.04];


%% Pressure

for i=1:length(d_shaft)

a_shaft=pi.*d_shaft(i).^2./4;
pressure_i=F./a_shaft;
pressure_ext=0;
thickness=0.005;
r_in=d_shaft(i)./2;
r_out=r_in+thickness;
r=(r_out+r_in)./2;

% axial_stress=(pressure_i.*r_in.^2-pressure_ext.*r_out.^2)/(r_out.^2-r_in.^2)
% tangential_stress=(pressure_i.*r_in.^2-pressure_ext.*r_out.^2)./(r_out.^2-r_in.^2)+(r_in.^2.*r_out.^2.*(pressure_i-pressure_ext))./(r.*(r_out.^2-r_in.^2))
% radial_stress=(pressure_i.*r_in.^2-pressure_ext.*r_out.^2)./(r_out.^2-r_in.^2)-(r_in.^2.*r_out.^2.*(pressure_i-pressure_ext))./(r.*(r_out.^2-r_in.^2))
axial_stress=pressure_i.*r_in.^2./(r_out.^2-r_in.^2)
tangential_stress=r_in.^2.*pressure_i./(r_out.^2-r_in.^2).*(1+r_out.^2./r.^2)
radial_stress=r_in.^2.*pressure_i./(r_out.^2-r_in.^2).*(1-r_out.^2./r.^2)



state=[radial_stress 0 0; 0 tangential_stress 0; 0 0 axial_stress];
omega1=flipud(eig(state))
omega_1p=sqrt(omega1(1,1)^2+omega1(2,1)^2+omega1(3,1)^2-(omega1(1,1).*omega1(2,1)+omega1(2,1).*omega1(3,1)+omega1(1,1).*omega1(3,1)));

N_n=S_y./omega_1p; %Factor of safety calculations based on distortion energy theorem
N_s=S_ut.*0.577./(abs(omega1(1,1)-omega1(3,1))./2);
FoS(i)=min(N_n,N_s)
i=i+1;
end

figure
plot(d_shaft,FoS)
title('Relationship between Pressure factor of safety and piston diameter')
xlabel('Piston Diameter (m)')
ylabel('Factor of Safety')
