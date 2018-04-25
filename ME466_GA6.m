clc, clear all, close all, format short g

P_max=750; %lbs
P_min=0;
preload=.65;
l=2.5; %in
d_bolt=0.5; %in

F_i=0.65
l_thd=2.*d_bolt+0.25
l_s=l-l_thd
j=d_bolt./l
C=
P_b=C.*P_max
P_m=P_max-P_b
F_b=F_i-P_b

