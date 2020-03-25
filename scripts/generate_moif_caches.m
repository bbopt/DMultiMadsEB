% driver_moif.m script file
%
% Purpose:
%
% File driver_moif applies the DSM algorithm to determine the complete
% Pareto front for the bound constrained optimization problem ZDT1, 
% described in E. Zitzler, K. Deb, and L. Thiele, "Comparison of 
% Multiobjective Evolutionary Algorithms: Empirical Results", 
% Evolutionary Computation 8(2): 173-195, 2000.
%
% The optimizer uses the default options specified in the file 
% parameters_moif.m. An output report is produced, both at the screen 
% and in the text file moif_report.txt (stored at the directory moif_0.3).
%
% moif Version 0.3.
%
% Copyright (C) 2011 A. L. Cust�dio, J. F. A. Madeira, A. I. F. Vaz, 
% and L. N. Vicente.
%
% http://www.mat.uc.pt/moif
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
format compact;

% BK1 function
[Plist,Flist,alfa,func_eval] = moif(1,@BK1,...
                                'BK1_moif.txt',[],-5 * ones(2,1), 10 * ones(2,1));
clear;

% CL1 function
% params
F_p =  10;
E_p = 2*10^5;
L_p = 200;
sigma_p = 10;
lb = [F_p / sigma_p; sqrt(2) * F_p / sigma_p; sqrt(2) * F_p / sigma_p; F_p / sigma_p];
[Plist,Flist,alfa,func_eval] = moif(1,@CL1,...
                                'CL1_moif.txt',[],lb, (3 * F_p / sigma_p) * ones(4,1));
clear;

% Deb41 function
lb = [0.1; 0.0];
[Plist,Flist,alfa,func_eval] = moif(1,@Deb41,...
                                'Deb41_moif.txt',[],lb, ones(2,1));
clear;

% Deb512a function
[Plist,Flist,alfa,func_eval] = moif(1,@Deb512a,...
                                'Deb512a_moif.txt',[], zeros(2, 1), ones(2,1));
clear;

% Deb512b function
[Plist,Flist,alfa,func_eval] = moif(1,@Deb512b,...
                                'Deb512b_moif.txt',[], zeros(2, 1), ones(2,1));
clear;

% Deb512c function
[Plist,Flist,alfa,func_eval] = moif(1,@Deb512c, ...
                                'Deb512c_moif.txt',[], zeros(2, 1), ones(2,1));
clear;

% Deb513 function
[Plist,Flist,alfa,func_eval] = moif(1,@Deb513,...
                                'Deb513_moif.txt',[], zeros(2, 1), ones(2,1));
clear;

% Deb521a function
[Plist,Flist,alfa,func_eval] = moif(1,@Deb521a,...
                                'Deb521a_moif.txt',[], zeros(2, 1), ones(2,1));
clear;

% Deb521b function
[Plist,Flist,alfa,func_eval] = moif(1,@Deb521b,...
                                'Deb521b_moif.txt',[], zeros(2, 1), ones(2,1));
clear;

% Deb53 function
[Plist,Flist,alfa,func_eval] = moif(1,@Deb53,...
                                'Deb53_moif.txt',[], zeros(2, 1), ones(2,1));
clear;

% DG01 function
[Plist,Flist,alfa,func_eval] = moif(1,@DG01,...
                                'DG01_moif.txt',[], -10 * ones(1,1), 13 * ones(1,1));
clear;

% DPAM1 function
[Plist,Flist,alfa,func_eval] = moif(1, @DPAM1,...
                                'DPAM1_moif.txt',[], -0.3 * ones(10,1), 0.3 * ones(10,1));
clear;

% DTLZ1 function
[Plist,Flist,alfa,func_eval] = moif(1,@DTLZ1,...
                                'DTLZ1_moif.txt',[], zeros(7,1), ones(7,1));
clear;

% DTLZ1n2 function
[Plist,Flist,alfa,func_eval] = moif(1,@DTLZ1n2,...
                                'DTLZ1n2_moif.txt',[], zeros(2,1), ones(2,1));
clear;

% DTLZ2 function
[Plist,Flist,alfa,func_eval] = moif(1,@DTLZ2,...
                                'DTLZ2_moif.txt',[], zeros(12,1), ones(12,1));
clear;

% DTLZn2 function
[Plist,Flist,alfa,func_eval] = moif(1,@DTLZ2n2,...
                                'DTLZ2n2_moif.txt',[], zeros(2,1), ones(2,1));
clear;

% DTLZ3 function
[Plist,Flist,alfa,func_eval] = moif(1,@DTLZ3,...
                                'DTLZ3_moif.txt',[], zeros(12,1), ones(12,1));
clear;

% DTLZ3n2 function
[Plist,Flist,alfa,func_eval] = moif(1,@DTLZ3n2,...
                                'DTLZ3n2_moif.txt',[], zeros(2,1), ones(2,1));
clear;

% DTLZ4 function
[Plist,Flist,alfa,func_eval] = moif(1,@DTLZ4,...
                                'DTLZ4_moif.txt',[], zeros(12,1), ones(12,1));
clear;

% DTLZ4n2 function
[Plist,Flist,alfa,func_eval] = moif(1,@DTLZ4n2,...
                                'DTLZ4n2_moif.txt',[], zeros(2,1), ones(2,1));
clear;

% DTLZ5 function
[Plist,Flist,alfa,func_eval] = moif(1,@DTLZ5,...
                                'DTLZ5_moif.txt',[], zeros(12,1), ones(12,1));
clear;

% DTLZ5n2 function
[Plist,Flist,alfa,func_eval] = moif(1,@DTLZ5n2,...
                                'DTLZ5n2_moif.txt',[], zeros(2,1), ones(2,1));
clear;

% DTLZ6 function
[Plist,Flist,alfa,func_eval] = moif(1,@DTLZ6,...
                                'DTLZ6_moif.txt',[], zeros(22,1), ones(22,1));
clear;

% DTLZ6n2 function
[Plist,Flist,alfa,func_eval] = moif(1,@DTLZ6n2,...
                                'DTLZ6n2_moif.txt',[], zeros(2,1), ones(2,1));
clear;

% ex005 function
[Plist,Flist,alfa,func_eval] = moif(1,@ex005,...
                                'ex005_moif.txt',[], [-1;1], [2;2]);
clear;

% Far1 function
[Plist,Flist,alfa,func_eval] = moif(1,@Far1,...
                                'Far1_moif.txt',[], -1 * ones(2,1), ones(2,1));
clear;
% FES1 function
[Plist,Flist,alfa,func_eval] = moif(1,@FES1,...
                                'FES1_moif.txt',[], zeros(10,1), ones(10,1));
clear;

% FES2 function
[Plist,Flist,alfa,func_eval] = moif(1,@FES2,...
                                'FES2_moif.txt',[], zeros(10,1), ones(10,1));
clear;

% FES3 function
[Plist,Flist,alfa,func_eval] = moif(1,@FES3,...
                                'FES3_moif.txt',[], zeros(10,1), ones(10,1));
clear;

% Fonseca function
[Plist,Flist,alfa,func_eval] = moif(1,@Fonseca,...
                                'Fonseca_moif.txt',[], -4 * ones(2,1), 4 * ones(2,1));
clear;

% I1 function
[Plist,Flist,alfa,func_eval] = moif(1,@I1,...
                                'I1_moif.txt',[], zeros(8,1), ones(8,1));
clear;

% I2 function
[Plist,Flist,alfa,func_eval] = moif(1,@I2,...
                                'I2_moif.txt',[], zeros(8,1), ones(8,1));
clear;

% I3 function
[Plist,Flist,alfa,func_eval] = moif(1,@I3,...
                                'I3_moif.txt',[], zeros(8,1), ones(8,1));
clear;

% I4 function
[Plist,Flist,alfa,func_eval] = moif(1,@I4,...
                                'I4_moif.txt',[], zeros(8,1), ones(8,1));
clear;

% I5 function
[Plist,Flist,alfa,func_eval] = moif(1,@I5,...
                                'I5_moif.txt',[], zeros(8,1), ones(8,1));
clear;

% IKK1 function
[Plist,Flist,alfa,func_eval] = moif(1,@IKK1,...
                                'IKK1_moif.txt',[], -50 * ones(2,1), 50 * ones(2,1));
clear;

% IM1 function
[Plist,Flist,alfa,func_eval] = moif(1,@IM1,...
                                'IM1_moif.txt',[], ones(2,1), [4; 2]);
clear;

% Jin1 function
[Plist,Flist,alfa,func_eval] = moif(1,@Jin1,...
                                'Jin1_moif.txt',[], zeros(2,1), ones(2, 1));
clear;


% Jin2 function
[Plist,Flist,alfa,func_eval] = moif(1,@Jin2,...
                                'Jin2_moif.txt',[], zeros(2,1), ones(2, 1));
clear;

% Jin3 function
[Plist,Flist,alfa,func_eval] = moif(1,@Jin3,...
                                'Jin3_moif.txt',[], zeros(2,1), ones(2, 1));
clear;

% Jin4 function
[Plist,Flist,alfa,func_eval] = moif(1,@Jin4,...
                                'Jin4_moif.txt',[], zeros(2,1), ones(2, 1));
clear;

% Kursawe function
[Plist,Flist,alfa,func_eval] = moif(1,@Kursawe,...
                                'Kursawe_moif.txt',[], -5 * ones(3,1), 5 * ones(3, 1));
clear;

% L1ZDT4 function
[Plist,Flist,alfa,func_eval] = moif(1,@L1ZDT4,...
                                'L1ZDT4_moif.txt',[], cat(1, [0], - 5 * ones(9,1)), cat(1, [1], 5 * ones(9, 1)));
clear;

% L2ZDT1 function
[Plist,Flist,alfa,func_eval] = moif(1,@L2ZDT1,...
                                'L2ZDT1_moif.txt',[], zeros(30,1), ones(30, 1));
clear;

%L2ZDT2 function
[Plist, Flist, alfa, func_eval] = moif(1, @L2ZDT2,...
                                    'L2ZDT2_moif.txt', [], zeros(30, 1), ones(30, 1));
clear;

% L2ZDT3 function
[Plist,Flist,alfa,func_eval] = moif(1,@L2ZDT3,...
                                'L2ZDT3_moif.txt',[], zeros(30,1), ones(30, 1));
clear;

% L2ZDT4 function
[Plist,Flist,alfa,func_eval] = moif(1,@L2ZDT4,...
                                'L2ZDT4_moif.txt',[], zeros(30,1), ones(30, 1));
clear;

% L2ZDT6 function
[Plist,Flist,alfa,func_eval] = moif(1,@L2ZDT6,...
                                'L2ZDT6_moif.txt',[], zeros(10,1), ones(10, 1));
clear;

% L3ZDT1 function
[Plist,Flist,alfa,func_eval] = moif(1,@L3ZDT1,...
                                'L3ZDT1_moif.txt',[], zeros(30,1), ones(30, 1));
clear;

% L3ZDT2 function
[Plist,Flist,alfa,func_eval] = moif(1,@L3ZDT2,...
                                'L3ZDT2_moif.txt',[], zeros(30,1), ones(30, 1));
clear;

% L3ZDT3 function
[Plist,Flist,alfa,func_eval] = moif(1,@L3ZDT3,...
                                'L3ZDT3_moif.txt',[], zeros(30,1), ones(30, 1));
clear;

% L3ZDT4 function
[Plist,Flist,alfa,func_eval] = moif(1,@L3ZDT4,...
                                'L3ZDT4_moif.txt',[], zeros(30,1), ones(30, 1));
clear;

% L3ZDT6 function
[Plist,Flist,alfa,func_eval] = moif(1,@L3ZDT6,...
                                'L3ZDT6_moif.txt',[], zeros(10,1), ones(10, 1));
clear;

% LE1 function
[Plist,Flist,alfa,func_eval] = moif(1,@LE1,...
                                'LE1_moif.txt',[], zeros(2,1), ones(2, 1));
clear;

% lovison1 function
[Plist,Flist,alfa,func_eval] = moif(1,@lovison1,...
                                'lovison1_moif.txt',[], zeros(2,1), 3 * ones(2, 1));
clear;

% lovison2 function
[Plist,Flist,alfa,func_eval] = moif(1,@lovison2,...
                                'lovison2_moif.txt',[], -0.5 * ones(2, 1), [0; 0.5]);
clear;

% lovison3 function
[Plist,Flist,alfa,func_eval] = moif(1,@lovison3,...
                                'lovison3_moif.txt',[], [0;-4], [6; 4]);
clear;

% lovison4 function
[Plist,Flist,alfa,func_eval] = moif(1,@lovison4,...
                                'lovison4_moif.txt',[], [0;-1], [6; 1]);
clear;

% lovison5 function
[Plist,Flist,alfa,func_eval] = moif(1,@lovison5,...
                                'lovison5_moif.txt',[], -1 * ones(3, 1), 4 * ones(3, 1));
% clear;

% lovison6 function
[Plist,Flist,alfa,func_eval] = moif(1,@lovison6,...
                                'lovison6_moif.txt',[], -1 * ones(3, 1), 4 * ones(3, 1));
clear;
% clear;

% LRS1 function
[Plist,Flist,alfa,func_eval] = moif(1,@LRS1,...
                                'LRS1_moif.txt',[], -50 * ones(2, 1), 50 * ones(2, 1));
clear;

% MHHM1 function
[Plist,Flist,alfa,func_eval] = moif(1,@MHHM1,...
                                'MHHM1_moif.txt',[], zeros(1, 1), ones(1, 1));
clear;

% MHHM2 function
[Plist,Flist,alfa,func_eval] = moif(1,@MHHM2,...
                                'MHHM2_moif.txt',[], zeros(2, 1), ones(2, 1));
clear;

% MLF1 function
[Plist,Flist,alfa,func_eval] = moif(1,@MLF1,...
                                'MLF1_moif.txt',[], zeros(1, 1), 20 * ones(1, 1));
clear;

% MLF2 function
[Plist,Flist,alfa,func_eval] = moif(1,@MLF2,...
                                'MLF2_moif.txt',[], -2 * ones(2, 1), 2 * ones(2, 1));
clear;

% MOP1 function
[Plist,Flist,alfa,func_eval] = moif(1,@MOP1,...
                                'MOP1_moif.txt',[], -10^(-5) * ones(1, 1), 10^(5) * ones(1, 1));
clear;

% MOP2 function
[Plist,Flist,alfa,func_eval] = moif(1,@MOP2,...
                                'MOP2_moif.txt',[], -4 * ones(4, 1), 4 * ones(4, 1));
clear;

% MOP3 function
[Plist,Flist,alfa,func_eval] = moif(1,@MOP3,...
                                'MOP3_moif.txt',[], -pi * ones(2, 1), pi * ones(2, 1));
clear;

% MOP4 function
[Plist,Flist,alfa,func_eval] = moif(1,@MOP4,...
                                'MOP4_moif.txt',[], -5 * ones(3, 1), 5 * ones(3, 1));
clear;

% MOP5 function
[Plist,Flist,alfa,func_eval] = moif(1,@MOP5,...
                                'MOP5_moif.txt',[], -30 * ones(2, 1), 30 * ones(2, 1));
clear;

% MOP6 function
[Plist,Flist,alfa,func_eval] = moif(1,@MOP6,...
                                'MOP6_moif.txt',[], zeros(2, 1), ones(2, 1));
clear;

% MOP7 function
[Plist,Flist,alfa,func_eval] = moif(1,@MOP7,...
                                'MOP7_moif.txt',[], -400 * ones(2, 1), 400 * ones(2, 1));
clear;

% OKA1 function
lb = [6 * sin(pi/12); -2 * pi * sin(pi/12)];
ub = [6 * sin(pi/12) + 2 * pi * cos(pi/12); 6 * cos(pi/12)];
[Plist,Flist,alfa,func_eval] = moif(1,@OKA1,...
                                'OKA1_moif.txt',[], lb, ub);
clear;

% OKA2 function
[Plist,Flist,alfa,func_eval] = moif(1,@OKA2,...
                                'OKA2_moif.txt',[], [-pi; -5; -5], [pi; 5; 5]);
clear;

% QV1 function
[Plist,Flist,alfa,func_eval] = moif(1,@QV1,...
                                'QV1_moif.txt',[], -5.12 * ones(10, 1), 5.12 * ones(10, 1));
clear;

% Sch1 function
[Plist,Flist,alfa,func_eval] = moif(1,@Sch1,...
                                'Sch1_moif.txt',[], zeros(1, 1), 5 * ones(1, 1));
clear;

% SK1 function
[Plist,Flist,alfa,func_eval] = moif(1,@SK1,...
                                'SK1_moif.txt',[], [- 10] , [10]);
clear;

% SK2 function
[Plist,Flist,alfa,func_eval] = moif(1,@SK2,...
                                'SK2_moif.txt',[], -10 * ones(4, 1), 10 * ones(4, 1));
clear;

% SP1 function
[Plist,Flist,alfa,func_eval] = moif(1,@SP1,...
                                'SP1_moif.txt',[], -1 * ones(2, 1), 5 * ones(2, 1));
clear;

% SSFYY1 function
[Plist,Flist,alfa,func_eval] = moif(1,@SSFYY1,...
                                'SSFYY1_moif.txt',[], -100 * ones(2, 1), 100 * ones(2, 1));
clear;

% SSFYY2 function
[Plist,Flist,alfa,func_eval] = moif(1,@SSFYY2,...
                                'SSFYY2_moif.txt',[], -100 * ones(1, 1), 100 * ones(1, 1));
clear;

% TKLY1 function
[Plist,Flist,alfa,func_eval] = moif(1,@TKLY1,...
                                'TKLY1_moif.txt',[], [0.1; 0; 0; 0], ones(4, 1));
clear;

% VFM1 function
[Plist,Flist,alfa,func_eval] = moif(1,@VFM1,...
                                'VFM1_moif.txt',[], -2 * ones(2, 1), 2 * ones(2, 1));
clear;

% VU1 function
[Plist,Flist,alfa,func_eval] = moif(1,@VU1,...
                                'VU1_moif.txt',[], -3 * ones(2, 1), 3 * ones(2, 1));
clear;

% VU2 function
[Plist,Flist,alfa,func_eval] = moif(1,@VU2,...
                                'VU2_moif.txt',[], -3 * ones(2, 1), 3 * ones(2, 1));
clear;

% WFG1 function
[Plist,Flist,alfa,func_eval] = moif(1,@WFG1,...
                                'WFG1_moif.txt',[], zeros(8, 1), 2 * (1:8)');
clear;

% WFG2 function
[Plist,Flist,alfa,func_eval] = moif(1,@WFG2,...
                                'WFG2_moif.txt',[], zeros(8, 1), 2 * (1:8)');
clear;

% WFG3 function
[Plist,Flist,alfa,func_eval] = moif(1,@WFG3,...
                                'WFG3_moif.txt',[], zeros(8, 1), 2 * (1:8)');
clear;

% WFG4 function
[Plist,Flist,alfa,func_eval] = moif(1,@WFG4,...
                                'WFG4_moif.txt',[], zeros(8, 1), 2 * (1:8)');
clear;

% WFG5 function
[Plist,Flist,alfa,func_eval] = moif(1,@WFG5,...
                                'WFG5_moif.txt',[], zeros(8, 1), 2 * (1:8)');
clear;

% WFG6 function
[Plist,Flist,alfa,func_eval] = moif(1,@WFG6,...
                                'WFG6_moif.txt',[], zeros(8, 1), 2 * (1:8)');
clear;

% WFG7 function
[Plist,Flist,alfa,func_eval] = moif(1,@WFG7,...
                                'WFG7_moif.txt',[], zeros(8, 1), 2 * (1:8)');
clear;

% WFG8 function
[Plist,Flist,alfa,func_eval] = moif(1,@WFG8,...
                                'WFG8_moif.txt',[], zeros(8, 1), 2 * (1:8)');
clear;

% WFG9 function
[Plist,Flist,alfa,func_eval] = moif(1,@WFG9,...
                                'WFG9_moif.txt',[], zeros(8, 1), 2 * (1:8)');
clear;

% ZDT1 function
[Plist,Flist,alfa,func_eval] = moif(1,@ZDT1,...
                                'ZDT1_moif.txt',[], zeros(30, 1), ones(30, 1));
clear;

% ZDT2 function
[Plist,Flist,alfa,func_eval] = moif(1,@ZDT2,...
                                'ZDT2_moif.txt',[], zeros(30, 1), ones(30, 1));
clear;

% ZDT3 function
[Plist,Flist,alfa,func_eval] = moif(1,@ZDT3,...
                                'ZDT3_moif.txt',[], zeros(30, 1), ones(30, 1));
clear;

% ZDT4 function
[Plist,Flist,alfa,func_eval] = moif(1,@ZDT4,...
                                'ZDT4_moif.txt',[], cat(1, [0], -5 * ones(9, 1)), cat(1, [1], 5 * ones(9, 1)));
clear;

% ZDT6 function
[Plist,Flist,alfa,func_eval] = moif(1,@ZDT6,...
                                'ZDT6_moif.txt',[], zeros(10, 1), ones(10, 1));
clear;

% ZLT1 function
[Plist,Flist,alfa,func_eval] = moif(1,@ZLT1,...
                                'ZLT1_moif.txt',[], -1000 * ones(10, 1), 1000 * ones(10, 1));
clear;

% End of driver_moif.
