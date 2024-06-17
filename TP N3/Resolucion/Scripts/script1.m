clc; close all; clear all;

p1 =1;
p2 = -3;
K = 5;
T2 = 2;

G = zpk([],[p1 p2],K)

%C = zpk([-3],[],0.57668)
% C = zpk([-2],[],0.72224)

%Kc = 0.57668;
%a = 3;
%M = 1;
%T = 0.1;
%lineal = 1;

% Kc = 0.72224;
% a = 2;
% M = 1;
% T = 0.1;
% lineal = 1;
% 
% M=Kc;
% T=K*Kc/100;
% lineal = 0;

