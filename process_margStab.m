fileID = fopen('linear_stability/lin_case_10__alphaBJSJ_1.000__delt_5.0000e-03__ic_BJSJ.txt','r');

N = 7; %number of dhats
M = 50; %number of points

LW = 'linewidth';
wid = 2;
LS = 'linestyle';
sty = '-';
FS = 'fontsize';

figure(2)
% read the first 8 lines and do nothing to them
for k=1:8
    tline = fgets(fileID);
end
% next reading will be on 9th line.
% display form 9th line forward:
if N>0
    dat = fscanf(fileID, '%f, %f');
    for i=1:M
        a1(i) = dat(2*i - 1);
        Ra1(i) = dat(2*i);
    end

    if N>1
        for k=1:1
            tline = fgets(fileID);
        end
        dat = fscanf(fileID, '%f, %f');
        for i=1:M
            a2(i) = dat(2*i - 1);
            Ra2(i) = dat(2*i);
        end

        if N>2
            for k=1:1
                tline = fgets(fileID);
            end
            dat = fscanf(fileID, '%f, %f');
            for i=1:M
                a3(i) = dat(2*i - 1);
                Ra3(i) = dat(2*i);
            end

            if N>3
                for k=1:1
                    tline = fgets(fileID);
                end
                dat = fscanf(fileID, '%f, %f');
                for i=1:M
                    a4(i) = dat(2*i - 1);
                    Ra4(i) = dat(2*i);
                end

                if N>4
                    for k=1:1
                        tline = fgets(fileID);
                    end
                    dat = fscanf(fileID, '%f, %f');
                    for i=1:M
                        a5(i) = dat(2*i - 1);
                        Ra5(i) = dat(2*i);
                    end

                    if N>5
                        for k=1:1
                            tline = fgets(fileID);
                        end
                        dat = fscanf(fileID, '%f, %f');
                        for i=1:M
                            a6(i) = dat(2*i - 1);
                            Ra6(i) = dat(2*i);
                        end

                        if N>6
                            for k=1:1
                                tline = fgets(fileID);
                            end
                            dat = fscanf(fileID, '%f, %f');
                            for i=1:M
                                a7(i) = dat(2*i - 1);
                                Ra7(i) = dat(2*i);
                            end

                            if N>7
                                for k=1:1
                                    tline = fgets(fileID);
                                end
                                dat = fscanf(fileID, '%f, %f');
                                for i=1:M
                                    a8(i) = dat(2*i - 1);
                                    Ra8(i) = dat(2*i);
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

figure(2)
hold on
ax = gca;
ax.ColorOrderIndex = 1;
% subplot(1,2,1)

if N>0
    plot(a1,Ra1,LW,wid,LS,sty);

    if N>1
        plot(a2,Ra2,LW,wid,LS,sty);

        if N>2
            plot(a3,Ra3,LW,wid,LS,sty);

            if N>3
                plot(a4,Ra4,LW,wid,LS,sty);

                if N>4
                    plot(a5,Ra5,LW,wid,LS,sty);

                    if N>5
                        plot(a6,Ra6,LW,wid,LS,sty);

                        if N>6
                            plot(a7,Ra7,LW,wid,LS,sty);

                            if N>7
                                plot(a8,Ra8,LW,wid,LS,sty);

                            end
                        end
                    end
                end
            end
        end
    end
end


%set(gca,FS,30,'FontName', 'Times New Roman')
grid on
%axis square
%xlabel('Porous Wavenumber, {\it a_m}',FS,30,'FontName', 'Times New Roman')
%ylabel(' Porous Rayleigh Number, {\it Ra_m}',FS,30,'FontName', 'Times New Roman')
%title('Varying $$\hat{d}$$', 'Interpreter', 'Latex', FS,30,'FontName', 'Times New Roman')
axis([0 25 0 35])
%lgd = legend({'dhat = .23', 'dhat = .16', 'dhat = .17', 'dhat = .18', 'dhat = .19'},FS,20, 'location', 'eastoutside');
%
%
% set(gca,FS,25,'FontName', 'Times New Roman')
% grid on
% axis square
% xlabel('Porous Wavenumber, {\it a_m}',FS,25,'FontName', 'Times New Roman')
% ylabel(' Fluid Rayleigh Number, {\it Ra_f}',FS,25,'FontName', 'Times New Roman')
% title('Varying $$\hat{d}$$', 'Interpreter', 'Latex', FS,25,'FontName', 'Times New Roman')
% %lgd = legend({'dhat = .15', 'dhat = .16', 'dhat = .17', 'dhat = .18', 'dhat = .19'},FS,20, 'location', 'eastoutside');

fclose(fileID);
