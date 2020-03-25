% driver_dms.m script file
%
% Purpose:
%
% File driver_dms applies the DSM algorithm to determine the complete
% Pareto front for the bound constrained optimization problem ZDT1, 
% described in E. Zitzler, K. Deb, and L. Thiele, "Comparison of 
% Multiobjective Evolutionary Algorithms: Empirical Results", 
% Evolutionary Computation 8(2): 173-195, 2000.
%
% The optimizer uses the default options specified in the file 
% parameters_dms.m. An output report is produced, both at the screen 
% and in the text file dms_report.txt (stored at the directory dms_0.3).
%
% DMS Version 0.3.
%
% Copyright (C) 2011 A. L. Cust�dio, J. F. A. Madeira, A. I. F. Vaz, 
% and L. N. Vicente.
%
% http://www.mat.uc.pt/dms
%
% This library is free software; you can redistribute it and/or
% modify it under the terms of the GNU Lesser General Public
% License as published by the Free Software Foundation; either
% version 2.1 of the License, or (at your option) any later version.
%
% This library is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% Lesser General Public License for more details.
%
% You should have received a copy of the GNU Lesser General Public
% License along with this library; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307, USA.
%
%
format compact;

% BK1 function
[Plist,Flist,alfa,func_eval] = dms(1,'BK1','dms_paretofront_BK1.txt',...
                                'BK1_dms.txt',[],-5 * ones(2,1), 10 * ones(2,1),[]);
clear;

% CL1 function
% params
F_p =  10;
E_p = 2*10^5;
L_p = 200;
sigma_p = 10;
lb = [F_p / sigma_p; sqrt(2) * F_p / sigma_p; sqrt(2) * F_p / sigma_p; F_p / sigma_p];
[Plist,Flist,alfa,func_eval] = dms(1,'CL1','dms_paretofront_BK1.txt',...
                                'CL1_dms.txt',[],lb, (3 * F_p / sigma_p) * ones(4,1),[]);
clear;

% Deb41 function
lb = [0.1; 0.0];
[Plist,Flist,alfa,func_eval] = dms(1,'Deb41','dms_paretofront_BK1.txt',...
                                'Deb41_dms.txt',[],lb, ones(2,1),[]);
clear;

% Deb512a function
[Plist,Flist,alfa,func_eval] = dms(1,'Deb512a','dms_paretofront_BK1.txt',...
                                'Deb512a_dms.txt',[], zeros(2, 1), ones(2,1),[]);
clear;

% Deb512b function
[Plist,Flist,alfa,func_eval] = dms(1,'Deb512b','dms_paretofront_BK1.txt',...
                                'Deb512b_dms.txt',[], zeros(2, 1), ones(2,1),[]);
clear;

% Deb512c function
[Plist,Flist,alfa,func_eval] = dms(1,'Deb512c','dms_paretofront_BK1.txt',...
                                'Deb512c_dms.txt',[], zeros(2, 1), ones(2,1),[]);
clear;

% Deb513 function
[Plist,Flist,alfa,func_eval] = dms(1,'Deb513','dms_paretofront_BK1.txt',...
                                'Deb513_dms.txt',[], zeros(2, 1), ones(2,1),[]);
clear;

% Deb521a function
[Plist,Flist,alfa,func_eval] = dms(1,'Deb521a','dms_paretofront_BK1.txt',...
                                'Deb521a_dms.txt',[], zeros(2, 1), ones(2,1),[]);
clear;

% Deb521b function
[Plist,Flist,alfa,func_eval] = dms(1,'Deb521b','dms_paretofront_BK1.txt',...
                                'Deb521b_dms.txt',[], zeros(2, 1), ones(2,1),[]);
clear;

% Deb53 function
[Plist,Flist,alfa,func_eval] = dms(1,'Deb53','dms_paretofront_BK1.txt',...
                                'Deb53_dms.txt',[], zeros(2, 1), ones(2,1),[]);
clear;

% DG01 function
[Plist,Flist,alfa,func_eval] = dms(1,'DG01','dms_paretofront_BK1.txt',...
                                'DG01_dms.txt',[], -10 * ones(1,1), 13 * ones(1,1),[]);
clear;

% DPAM1 function
[Plist,Flist,alfa,func_eval] = dms(1,'DPAM1','dms_paretofront_BK1.txt',...
                                'DPAM1_dms.txt',[], -0.3 * ones(10,1), 0.3 * ones(10,1),[]);
clear;

% DTLZ1 function
[Plist,Flist,alfa,func_eval] = dms(1,'DTLZ1','dms_paretofront_BK1.txt',...
                                'DTLZ1_dms.txt',[], zeros(7,1), ones(7,1),[]);
clear;

% DTLZ1n2 function
[Plist,Flist,alfa,func_eval] = dms(1,'DTLZ1n2','dms_paretofront_BK1.txt',...
                                'DTLZ1n2_dms.txt',[], zeros(2,1), ones(2,1),[]);
clear;

% DTLZ2 function
[Plist,Flist,alfa,func_eval] = dms(1,'DTLZ2','dms_paretofront_BK1.txt',...
                                'DTLZ2_dms.txt',[], zeros(12,1), ones(12,1),[]);
clear;

% DTLZn2 function
[Plist,Flist,alfa,func_eval] = dms(1,'DTLZ2n2','dms_paretofront_BK1.txt',...
                                'DTLZ2n2_dms.txt',[], zeros(2,1), ones(2,1),[]);
clear;

% DTLZ3 function
[Plist,Flist,alfa,func_eval] = dms(1,'DTLZ3','dms_paretofront_BK1.txt',...
                                'DTLZ3_dms.txt',[], zeros(12,1), ones(12,1),[]);
clear;

% DTLZ3n2 function
[Plist,Flist,alfa,func_eval] = dms(1,'DTLZ3n2','dms_paretofront_BK1.txt',...
                                'DTLZ3n2_dms.txt',[], zeros(2,1), ones(2,1),[]);
clear;

% DTLZ4 function
[Plist,Flist,alfa,func_eval] = dms(1,'DTLZ4','dms_paretofront_BK1.txt',...
                                'DTLZ4_dms.txt',[], zeros(12,1), ones(12,1),[]);
clear;

% DTLZ4n2 function
[Plist,Flist,alfa,func_eval] = dms(1,'DTLZ4n2','dms_paretofront_BK1.txt',...
                                'DTLZ4n2_dms.txt',[], zeros(2,1), ones(2,1),[]);
clear;

% DTLZ5 function
[Plist,Flist,alfa,func_eval] = dms(1,'DTLZ5','dms_paretofront_BK1.txt',...
                                'DTLZ5_dms.txt',[], zeros(12,1), ones(12,1),[]);
clear;

% DTLZ5n2 function
[Plist,Flist,alfa,func_eval] = dms(1,'DTLZ5n2','dms_paretofront_BK1.txt',...
                                'DTLZ5n2_dms.txt',[], zeros(2,1), ones(2,1),[]);
clear;

% DTLZ6 function
[Plist,Flist,alfa,func_eval] = dms(1,'DTLZ6','dms_paretofront_BK1.txt',...
                                'DTLZ6_dms.txt',[], zeros(22,1), ones(22,1),[]);
clear;

% DTLZ6n2 function
[Plist,Flist,alfa,func_eval] = dms(1,'DTLZ6n2','dms_paretofront_BK1.txt',...
                                'DTLZ6n2_dms.txt',[], zeros(2,1), ones(2,1),[]);
clear;

% ex005 function
[Plist,Flist,alfa,func_eval] = dms(1,'ex005','dms_paretofront_BK1.txt',...
                                'ex005_dms.txt',[], [-1;1], [2;2], []);
clear;

% Far1 function
[Plist,Flist,alfa,func_eval] = dms(1,'Far1','dms_paretofront_BK1.txt',...
                                'Far1_dms.txt',[], -1 * ones(2,1), ones(2,1),[]);
clear;
% FES1 function
[Plist,Flist,alfa,func_eval] = dms(1,'FES1','dms_paretofront_BK1.txt',...
                                'FES1_dms.txt',[], zeros(10,1), ones(10,1),[]);
clear;

% FES2 function
[Plist,Flist,alfa,func_eval] = dms(1,'FES2','dms_paretofront_BK1.txt',...
                                'FES2_dms.txt',[], zeros(10,1), ones(10,1),[]);
clear;

% FES3 function
[Plist,Flist,alfa,func_eval] = dms(1,'FES3','dms_paretofront_BK1.txt',...
                                'FES3_dms.txt',[], zeros(10,1), ones(10,1),[]);
clear;

% Fonseca function
[Plist,Flist,alfa,func_eval] = dms(1,'Fonseca','dms_paretofront_BK1.txt',...
                                'Fonseca_dms.txt',[], -4 * ones(2,1), 4 * ones(2,1),[]);
clear;

% I1 function
[Plist,Flist,alfa,func_eval] = dms(1,'I1','dms_paretofront_BK1.txt',...
                                'I1_dms.txt',[], zeros(8,1), ones(8,1),[]);
clear;

% I2 function
[Plist,Flist,alfa,func_eval] = dms(1,'I2','dms_paretofront_BK1.txt',...
                                'I2_dms.txt',[], zeros(8,1), ones(8,1),[]);
clear;

% I3 function
[Plist,Flist,alfa,func_eval] = dms(1,'I3','dms_paretofront_BK1.txt',...
                                'I3_dms.txt',[], zeros(8,1), ones(8,1),[]);
clear;

% I4 function
[Plist,Flist,alfa,func_eval] = dms(1,'I4','dms_paretofront_BK1.txt',...
                                'I4_dms.txt',[], zeros(8,1), ones(8,1),[]);
clear;

% I5 function
[Plist,Flist,alfa,func_eval] = dms(1,'I5','dms_paretofront_BK1.txt',...
                                'I5_dms.txt',[], zeros(8,1), ones(8,1),[]);
clear;

% IKK1 function
[Plist,Flist,alfa,func_eval] = dms(1,'IKK1','dms_paretofront_BK1.txt',...
                                'IKK1_dms.txt',[], -50 * ones(2,1), 50 * ones(2,1),[]);
clear;

% IM1 function
[Plist,Flist,alfa,func_eval] = dms(1,'IM1','dms_paretofront_BK1.txt',...
                                'IM1_dms.txt',[], ones(2,1), [4; 2], []);
clear;

% Jin1 function
[Plist,Flist,alfa,func_eval] = dms(1,'Jin1','dms_paretofront_BK1.txt',...
                                'Jin1_dms.txt',[], zeros(2,1), ones(2, 1), []);
clear;


% Jin2 function
[Plist,Flist,alfa,func_eval] = dms(1,'Jin2','dms_paretofront_BK1.txt',...
                                'Jin2_dms.txt',[], zeros(2,1), ones(2, 1), []);
clear;

% Jin3 function
[Plist,Flist,alfa,func_eval] = dms(1,'Jin3','dms_paretofront_BK1.txt',...
                                'Jin3_dms.txt',[], zeros(2,1), ones(2, 1), []);
clear;

% Jin4 function
[Plist,Flist,alfa,func_eval] = dms(1,'Jin4','dms_paretofront_BK1.txt',...
                                'Jin4_dms.txt',[], zeros(2,1), ones(2, 1), []);
clear;

% Kursawe function
[Plist,Flist,alfa,func_eval] = dms(1,'Kursawe','dms_paretofront_BK1.txt',...
                                'Kursawe_dms.txt',[], -5 * ones(3,1), 5 * ones(3, 1), []);
clear;

% L1ZDT4 function
[Plist,Flist,alfa,func_eval] = dms(1,'L1ZDT4','dms_paretofront_BK1.txt',...
                                'L1ZDT4_dms.txt',[], cat(1, [0], - 5 * ones(9,1)), cat(1, [1], 5 * ones(9, 1)), []);
clear;

% L2ZDT1 function
[Plist,Flist,alfa,func_eval] = dms(1,'L2ZDT1','dms_paretofront_BK1.txt',...
                                'L2ZDT1_dms.txt',[], zeros(30,1), ones(30, 1), []);
clear;

% L2ZDT2 function
[Plist, Flist, alfa, func_eval] = dms(1, 'L2ZDT2', 'dms_paretofront_BK1.txt',...
                                'L2ZDT2_dms.txt', [], zeros(30, 1), ones(30, 1), []);
clear;

% L2ZDT3 function
[Plist,Flist,alfa,func_eval] = dms(1,'L2ZDT3','dms_paretofront_BK1.txt',...
                                'L2ZDT3_dms.txt',[], zeros(30,1), ones(30, 1), []);
clear;

% L2ZDT4 function
[Plist,Flist,alfa,func_eval] = dms(1,'L2ZDT4','dms_paretofront_BK1.txt',...
                                'L2ZDT4_dms.txt',[], zeros(30,1), ones(30, 1), []);
clear;

% L2ZDT6 function
[Plist,Flist,alfa,func_eval] = dms(1,'L2ZDT6','dms_paretofront_BK1.txt',...
                                'L2ZDT6_dms.txt',[], zeros(10,1), ones(10, 1), []);
clear;

% L3ZDT1 function
[Plist,Flist,alfa,func_eval] = dms(1,'L3ZDT1','dms_paretofront_BK1.txt',...
                                'L3ZDT1_dms.txt',[], zeros(30,1), ones(30, 1), []);
clear;

% L3ZDT2 function
[Plist,Flist,alfa,func_eval] = dms(1,'L3ZDT2','dms_paretofront_BK1.txt',...
                                'L3ZDT2_dms.txt',[], zeros(30,1), ones(30, 1), []);
clear;

% L3ZDT3 function
[Plist,Flist,alfa,func_eval] = dms(1,'L3ZDT3','dms_paretofront_BK1.txt',...
                                'L3ZDT3_dms.txt',[], zeros(30,1), ones(30, 1), []);
clear;

% L3ZDT4 function
[Plist,Flist,alfa,func_eval] = dms(1,'L3ZDT4','dms_paretofront_BK1.txt',...
                                'L3ZDT4_dms.txt',[], zeros(30,1), ones(30, 1), []);
clear;

% L3ZDT6 function
[Plist,Flist,alfa,func_eval] = dms(1,'L3ZDT6','dms_paretofront_BK1.txt',...
                                'L3ZDT6_dms.txt',[], zeros(10,1), ones(10, 1), []);
clear;

% LE1 function
[Plist,Flist,alfa,func_eval] = dms(1,'LE1','dms_paretofront_BK1.txt',...
                                'LE1_dms.txt',[], zeros(2,1), ones(2, 1), []);
clear;

% lovison1 function
[Plist,Flist,alfa,func_eval] = dms(1,'lovison1','dms_paretofront_BK1.txt',...
                                'lovison1_dms.txt',[], zeros(2,1), 3 * ones(2, 1), []);
clear;

% lovison2 function
[Plist,Flist,alfa,func_eval] = dms(1,'lovison2','dms_paretofront_BK1.txt',...
                                'lovison2_dms.txt',[], -0.5 * ones(2, 1), [0; 0.5], []);
clear;

% lovison3 function
[Plist,Flist,alfa,func_eval] = dms(1,'lovison3','dms_paretofront_BK1.txt',...
                                'lovison3_dms.txt',[], [0;-4], [6; 4], []);
clear;

% lovison4 function
[Plist,Flist,alfa,func_eval] = dms(1,'lovison4','dms_paretofront_BK1.txt',...
                                'lovison4_dms.txt',[], [0;-1], [6; 1], []);
clear;

% lovison5 function
[Plist,Flist,alfa,func_eval] = dms(1,'lovison5','dms_paretofront_BK1.txt',...
                                'lovison5_dms.txt',[], -1 * ones(3, 1), 4 * ones(3, 1), []);
% clear;

% lovison6 function
[Plist,Flist,alfa,func_eval] = dms(1,'lovison6','dms_paretofront_BK1.txt',...
                                'lovison6_dms.txt',[], -1 * ones(3, 1), 4 * ones(3, 1), []);
clear;
% clear;

% LRS1 function
[Plist,Flist,alfa,func_eval] = dms(1,'LRS1','dms_paretofront_BK1.txt',...
                                'LRS1_dms.txt',[], -50 * ones(2, 1), 50 * ones(2, 1), []);
clear;

% MHHM1 function
[Plist,Flist,alfa,func_eval] = dms(1,'MHHM1','dms_paretofront_BK1.txt',...
                                'MHHM1_dms.txt',[], zeros(1, 1), ones(1, 1), []);
clear;

% MHHM2 function
[Plist,Flist,alfa,func_eval] = dms(1,'MHHM2','dms_paretofront_BK1.txt',...
                                'MHHM2_dms.txt',[], zeros(2, 1), ones(2, 1), []);
clear;

% MLF1 function
[Plist,Flist,alfa,func_eval] = dms(1,'MLF1','dms_paretofront_BK1.txt',...
                                'MLF1_dms.txt',[], zeros(1, 1), 20 * ones(1, 1), []);
clear;

% MLF2 function
[Plist,Flist,alfa,func_eval] = dms(1,'MLF2','dms_paretofront_BK1.txt',...
                                'MLF2_dms.txt',[], -2 * ones(2, 1), 2 * ones(2, 1), []);
clear;

% MOP1 function
[Plist,Flist,alfa,func_eval] = dms(1,'MOP1','dms_paretofront_BK1.txt',...
                                'MOP1_dms.txt',[], -10^(-5) * ones(1, 1), 10^(5) * ones(1, 1), []);
clear;

% MOP2 function
[Plist,Flist,alfa,func_eval] = dms(1,'MOP2','dms_paretofront_BK1.txt',...
                                'MOP2_dms.txt',[], -4 * ones(4, 1), 4 * ones(4, 1), []);
clear;

% MOP3 function
[Plist,Flist,alfa,func_eval] = dms(1,'MOP3','dms_paretofront_BK1.txt',...
                                'MOP3_dms.txt',[], -pi * ones(2, 1), pi * ones(2, 1), []);
clear;

% MOP4 function
[Plist,Flist,alfa,func_eval] = dms(1,'MOP4','dms_paretofront_BK1.txt',...
                                'MOP4_dms.txt',[], -5 * ones(3, 1), 5 * ones(3, 1), []);
clear;

% MOP5 function
[Plist,Flist,alfa,func_eval] = dms(1,'MOP5','dms_paretofront_BK1.txt',...
                                'MOP5_dms.txt',[], -30 * ones(2, 1), 30 * ones(2, 1), []);
clear;

% MOP6 function
[Plist,Flist,alfa,func_eval] = dms(1,'MOP6','dms_paretofront_BK1.txt',...
                                'MOP6_dms.txt',[], zeros(2, 1), ones(2, 1), []);
clear;

% MOP7 function
[Plist,Flist,alfa,func_eval] = dms(1,'MOP7','dms_paretofront_BK1.txt',...
                                'MOP7_dms.txt',[], -400 * ones(2, 1), 400 * ones(2, 1), []);
clear;

% OKA1 function
lb = [6 * sin(pi/12); -2 * pi * sin(pi/12)];
ub = [6 * sin(pi/12) + 2 * pi * cos(pi/12); 6 * cos(pi/12)];
[Plist,Flist,alfa,func_eval] = dms(1,'OKA1','dms_paretofront_BK1.txt',...
                                'OKA1_dms.txt',[], lb, ub, []);
clear;

% OKA2 function
[Plist,Flist,alfa,func_eval] = dms(1,'OKA2','dms_paretofront_BK1.txt',...
                                'OKA2_dms.txt',[], [-pi; -5; -5], [pi; 5; 5], []);
clear;

% QV1 function
[Plist,Flist,alfa,func_eval] = dms(1,'QV1','dms_paretofront_BK1.txt',...
                                'QV1_dms.txt',[], -5.12 * ones(10, 1), 5.12 * ones(10, 1), []);
clear;

% Sch1 function
[Plist,Flist,alfa,func_eval] = dms(1,'Sch1','dms_paretofront_BK1.txt',...
                                'Sch1_dms.txt',[], zeros(1, 1), 5 * ones(1, 1), []);
clear;

% SK1 function
[Plist,Flist,alfa,func_eval] = dms(1,'SK1','dms_paretofront_BK1.txt',...
                                'SK1_dms.txt',[], [- 10] , [10], []);
clear;

% SK2 function
[Plist,Flist,alfa,func_eval] = dms(1,'SK2','dms_paretofront_BK1.txt',...
                                'SK2_dms.txt',[], -10 * ones(4, 1), 10 * ones(4, 1), []);
clear;

% SP1 function
[Plist,Flist,alfa,func_eval] = dms(1,'SP1','dms_paretofront_BK1.txt',...
                                'SP1_dms.txt',[], -1 * ones(2, 1), 5 * ones(2, 1), []);
clear;

% SSFYY1 function
[Plist,Flist,alfa,func_eval] = dms(1,'SSFYY1','dms_paretofront_BK1.txt',...
                                'SSFYY1_dms.txt',[], -100 * ones(2, 1), 100 * ones(2, 1), []);
clear;

% SSFYY2 function
[Plist,Flist,alfa,func_eval] = dms(1,'SSFYY2','dms_paretofront_BK1.txt',...
                                'SSFYY2_dms.txt',[], -100 * ones(1, 1), 100 * ones(1, 1), []);
clear;

% TKLY1 function
[Plist,Flist,alfa,func_eval] = dms(1,'TKLY1','dms_paretofront_BK1.txt',...
                                'TKLY1_dms.txt',[], [0.1; 0; 0; 0], ones(4, 1), []);
clear;

% VFM1 function
[Plist,Flist,alfa,func_eval] = dms(1,'VFM1','dms_paretofront_BK1.txt',...
                                'VFM1_dms.txt',[], -2 * ones(2, 1), 2 * ones(2, 1), []);
clear;

% VU1 function
[Plist,Flist,alfa,func_eval] = dms(1,'VU1','dms_paretofront_BK1.txt',...
                                'VU1_dms.txt',[], -3 * ones(2, 1), 3 * ones(2, 1), []);
clear;

% VU2 function
[Plist,Flist,alfa,func_eval] = dms(1,'VU2','dms_paretofront_BK1.txt',...
                                'VU2_dms.txt',[], -3 * ones(2, 1), 3 * ones(2, 1), []);
clear;

% WFG1 function
[Plist,Flist,alfa,func_eval] = dms(1,'WFG1','dms_paretofront_BK1.txt',...
                                'WFG1_dms.txt',[], zeros(8, 1), 2 * (1:8)', []);
clear;

% WFG2 function
[Plist,Flist,alfa,func_eval] = dms(1,'WFG2','dms_paretofront_BK1.txt',...
                                'WFG2_dms.txt',[], zeros(8, 1), 2 * (1:8)', []);
clear;

% WFG3 function
[Plist,Flist,alfa,func_eval] = dms(1,'WFG3','dms_paretofront_BK1.txt',...
                                'WFG3_dms.txt',[], zeros(8, 1), 2 * (1:8)', []);
clear;

% WFG4 function
[Plist,Flist,alfa,func_eval] = dms(1,'WFG4','dms_paretofront_BK1.txt',...
                                'WFG4_dms.txt',[], zeros(8, 1), 2 * (1:8)', []);
clear;

% WFG5 function
[Plist,Flist,alfa,func_eval] = dms(1,'WFG5','dms_paretofront_BK1.txt',...
                                'WFG5_dms.txt',[], zeros(8, 1), 2 * (1:8)', []);
clear;

% WFG6 function
[Plist,Flist,alfa,func_eval] = dms(1,'WFG6','dms_paretofront_BK1.txt',...
                                'WFG6_dms.txt',[], zeros(8, 1), 2 * (1:8)', []);
clear;

% WFG7 function
[Plist,Flist,alfa,func_eval] = dms(1,'WFG7','dms_paretofront_BK1.txt',...
                                'WFG7_dms.txt',[], zeros(8, 1), 2 * (1:8)', []);
clear;

% WFG8 function
[Plist,Flist,alfa,func_eval] = dms(1,'WFG8','dms_paretofront_BK1.txt',...
                                'WFG8_dms.txt',[], zeros(8, 1), 2 * (1:8)', []);
clear;

% WFG9 function
[Plist,Flist,alfa,func_eval] = dms(1,'WFG9','dms_paretofront_BK1.txt',...
                                'WFG9_dms.txt',[], zeros(8, 1), 2 * (1:8)', []);
clear;

% ZDT1 function
[Plist,Flist,alfa,func_eval] = dms(1,'ZDT1','dms_paretofront_BK1.txt',...
                                'ZDT1_dms.txt',[], zeros(30, 1), ones(30, 1), []);
clear;

% ZDT2 function
[Plist,Flist,alfa,func_eval] = dms(1,'ZDT2','dms_paretofront_BK1.txt',...
                                'ZDT2_dms.txt',[], zeros(30, 1), ones(30, 1), []);
clear;

% ZDT3 function
[Plist,Flist,alfa,func_eval] = dms(1,'ZDT3','dms_paretofront_BK1.txt',...
                                'ZDT3_dms.txt',[], zeros(30, 1), ones(30, 1), []);
clear;

% ZDT4 function
[Plist,Flist,alfa,func_eval] = dms(1,'ZDT4','dms_paretofront_BK1.txt',...
                                'ZDT4_dms.txt',[], cat(1, [0], -5 * ones(9, 1)), cat(1, [1], 5 * ones(9, 1)), []);
clear;

% ZDT6 function
[Plist,Flist,alfa,func_eval] = dms(1,'ZDT6','dms_paretofront_BK1.txt',...
                                'ZDT6_dms.txt',[], zeros(10, 1), ones(10, 1), []);
clear;

% ZLT1 function
[Plist,Flist,alfa,func_eval] = dms(1,'ZLT1','dms_paretofront_BK1.txt',...
                                'ZLT1_dms.txt',[], -1000 * ones(10, 1), 1000 * ones(10, 1), []);
clear;

% End of driver_dms.
