clear all, close all, clc;

%% Ductile Material
S_y=42; %kpsi
S_ut=76; %kpsi

state=[6.884 3.441 0; 3.441 0 0 ;0 0 0]; %applied stress state in kpsi
statec=[13.183 5.190 0; 5.190 0 0 ;0 0 0]; %applied stress state with concentrators in kpsi

principle=flipud(eig(state)) %find the principal stress matrix
sig_1=principle(1,1);
sig_2=principle(2,1);
sig_3=principle(3,1);
N_n=S_y./sqrt(sig_1^2+sig_2^2+sig_3^2-(sig_1*sig_2+sig_2*sig_3+sig_1*sig_3)) %Factor of safety calculations based on distortion energy theorem
N_s=S_ut.*0.577./(abs(sig_1-sig_3)/2)

%% Brittle Material
S_ut2=42; %kpsi
S_uc2=140; %kpsi
principlec=flipud(eig(statec)) %find the principal stress matrix
sig_1c=principlec(1,1);
sig_2c=principlec(2,1);
sig_3c=principlec(3,1);
c1=0.5.*(abs(sig_1c-sig_2c)+(2.*S_ut2-S_uc2)./(-abs(S_uc2)).*(sig_1c+sig_2c));
c2=0.5.*(abs(sig_2c-sig_3c)+(2.*S_ut2-S_uc2)./(-abs(S_uc2)).*(sig_3c+sig_2c));
c3=0.5.*(abs(sig_3c-sig_1c)+(2.*S_ut2-S_uc2)./(-abs(S_uc2)).*(sig_1c+sig_3c));

if sig_1c>0 %Two cases based on the value of sigma_1
    N2=S_ut2./max([c1,c2,c3,sig_1c,sig_2c,sig_3c,0]) %Factor of safety calculations based on
else
    N2=abs(S_uc2)./sqrt(sig_1c^2+sig_2c^2+sig_3c^2-(sig_1c*sig_2c+sig_2c*sig_3c+sig_1c*sig_3c))
end



