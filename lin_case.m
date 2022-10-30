%clc
tic

% CONSTANTS
N=2^5;                   %number of poly. used to find evals
M=50;                   %number of values along wave-number range
et = 0.7;                %khat value
alphaBJSJ =1.000;       %BJSJ coefficient
delt = 5.00e-03;   %sqrt of Darcy number
caseNo = 20;             %case number (for organization in notes)

%Jone: gam = 0.5, porMed = 1.0;
%BJ__: gam = 0.0, porMed = 1.0;
%BJSJ: gam = 0.5, porMed = 0.0;

%gam = 0.5;              %0.5 for including the dw/dx_gam term (J/BJSJ cond), 0 exluding it (BJ condition)
%porMed = 0.0;           %1 for include Por. medium term (J/BJ condition), 0 for BJSJ
ic = 'BJSJ';            %interface condition (J..., BJ.., BJSJ)
linVnon = 'lin';
gam = zeros(1,1);
porMed = zeros(1,1);

if ic == 'Jone'
	gam = 0.5; porMed = 1.0;
elseif ic == 'BJ__'
	gam = 0.0; porMed = 1.0;
elseif ic == 'BJSJ'
    gam = 0.5; porMed = 0.0;
end

a = zeros(1,1);         %pre-allocating things bc matlab is finicky
minEigen=zeros(N,1);

%opening file
fname = sprintf('testing_lin_stab.txt');
save(fname)
fid = fopen( fname, 'wt' );

%putting variables in the file for sake of posterity
formatSpec = 'et = %.1f \nalphaBJSJ = %.3f \ndelt = %2.4e \ngam = %1.1f \nporMed = %1.1f \nM = %1i\n\n';
fprintf(fid,formatSpec,et,alphaBJSJ,delt,gam,porMed,M);

%Varying d hat values
numDhat = 1;        %number of dhat values we're testing
dhatVal(1) = 0.2;

for DHATV = 1:numDhat
    for i=1:M
        a(DHATV,i) = (25.0/M)*i;
    end
end

% SYSTEM
for DHATV = 1:numDhat
    dhat = dhatVal(DHATV);  %dhat value

    coef1 = alphaBJSJ*dhat/delt;
    coef2 = coef1*(dhat^2);
    coef3 = -1*(dhat^4)/(delt^2);
    coef4 = (dhat^4)/(delt*et)^2;
    fprintf(fid,'dhat = %.3f\n',dhat);  %printing dhat val to file

    for i=1:M
        alph = a(DHATV,i);

        A = chebop(-1,1);
        A.op = @(x,wf,af,tf,wm,tm) [4.*diff(af,2)- (dhat^2).*alph^2.*af  ;...
            4*diff(tf,2)-(dhat^2).*alph^2.*tf - 1.*wf;...
            4*diff(wf,2)-(dhat^2).*alph^2.*wf - 1.*af ;...
            4*diff(wm,2)-alph^2.*wm;...
            4*diff(tm,2)-alph^2.*tm - 1.*wm];

        A.rbc =@(wf,af,tf,wm,tm) [wf; diff(wf,1); tf; wm; tm];

        A.lbc =@(wf,af,tf,wm,tm) [ wf - dhat.*wm  ;...
            dhat.*tf - (et.^2).*tm;...
            diff(tf,1) + et.*diff(tm,1);...
            2.*diff(wf,2) + gam.*(dhat^2).*alph^2.*wf - coef1.*diff(wf,1) - porMed.*coef2.*diff(wm,1);...
            (coef3).*diff(wm,1) + 4.*diff(wf,3)-3.*(dhat^2).*alph^2.*diff(wf,1)];

        B = chebop(-1,1);
        B.op = @(x,wf,af,tf,wm,tm) [-1.0*(dhat^2).*alph^2.*coef4.*tf; 0.*wf; 0.*wf; ...
            1.*alph^2.*tm; 0.*wm  ];


        eigen = eigs(A,B,N);
        eigen = complex(eigen);
        minEigen(i) = min(real(eigen));

        prog = (i + M*(DHATV-1))/(M*numDhat);  %progress update on screen
        fprintf('p: %.3f\n', prog)
        formatSpec = '%f, %f\n';
        fprintf(fid,formatSpec,alph,minEigen(i)); % a_m, Ra_m value to file
    end

    fprintf(fid,'\n\n');

%     FS = 'fontsize'; MS = 'linewidth';
%     figure(1)
%     plot(a(DHATV,:),minEigen,MS,2), grid on, axis square
%     set(gca,FS,16)
%     hold on
end

% axis([0 25 0 45])
% xlabel('Porous Wavenumber, a_m',FS,16)
% ylabel('Porous Rayleigh Number, Ra_m',FS,16)
% title('Varying dhat', FS, 16)

fclose(fid);
toc
