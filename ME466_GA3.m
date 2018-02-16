clear all, close all, clc;

S_y=42; %kpsi
S_ut=76; %kpsi
%state=[7.955 1.990 0;1.990 0 0 ;0 0 0];
%state=[0 2.521 0;2.521 0 0 ;0 0 0];
%state=[6.884 3.441 0; 3.441 0 0 ;0 0 0];
state=[0 2.677 0; 2.677 0 0 ;0 0 0];
%statec=[13.183 5.190 0; 5.190 0 0 ;0 0 0];
statec=[0 3.726 0; 3.726 0 0 ;0 0 0];
principal=flipud(eig(state))
sig_1=principal(1,1);
sig_2=principal(2,1);
sig_3=principal(3,1);
N_n=S_y./sqrt(sig_1^2+sig_2^2+sig_3^2-(sig_1*sig_2+sig_2*sig_3+sig_1*sig_3))
N_s=S_ut.*0.577./(abs(sig_1-sig_3)/2)

S_ut2=42; %kpsi
S_uc2=140; %kpsi
principalc=flipud(eig(statec))
sig_1c=principalc(1,1);
sig_2c=principalc(2,1);
sig_3c=principalc(3,1);
c1=0.5.*(abs(sig_1c-sig_2c)+(2.*S_ut2-S_uc2)./(-abs(S_uc2)).*(sig_1c+sig_2c));
c2=0.5.*(abs(sig_2c-sig_3c)+(2.*S_ut2-S_uc2)./(-abs(S_uc2)).*(sig_3c+sig_2c));
c3=0.5.*(abs(sig_3c-sig_1c)+(2.*S_ut2-S_uc2)./(-abs(S_uc2)).*(sig_1c+sig_3c));

if sig_1c>0
    N2=S_ut2./max([c1,c2,c3,sig_1c,sig_2c,sig_3c,0])
else
    N2=abs(S_uc2)./sqrt(sig_1c^2+sig_2c^2+sig_3c^2-(sig_1c*sig_2c+sig_2c*sig_3c+sig_1c*sig_3c))
end



