%Idea here is to make sure the program runs well for one subject, 
%in one condition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
global data subjects

data = xlsread('C:\Users\AkioKakishima\Google Drive\Reinforcement_Learning\EWA\excel_file.xlsx','Sheet2');

%datafile = xlsread('C:\Users\AkioKakishima\Google Drive\Reinforcement_Learning\EWA\excel_file.xlsx','Sheet2');
%data = textread(datafile, '', 'delimiter', ',', 'emptyvalue', NaN);

idx = 1;
    subjects = 1007;
    for q1 = -5:5:5
        for q2 = 0.0000001:0.05:1.0000001
            [q,fval]= fminsearch(@fxncode_plt, [q1 q2 0 0 0]);

            % learning parameters
            fval;
            lambda = exp(q(1));
            alpha = exp(q(2));
            IniQ=  [q(3), q(4), q(5)];
            result(idx,:) = [fval, lambda,alpha, q]
            %single subject, single block
            save 'singleS_singleB.mat' result;
            idx = idx +1;
        end
    end
                
