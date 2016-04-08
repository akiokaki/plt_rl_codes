

% for Strong player
% EWA
% pooled estimation
%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
global endowment subjects lesionData

datafile = 'C:\Users\AkioKakishima\Google Drive\Reinforcement_Learning\EWA\Akio.csv';
data = textread(datafile, '', 'delimiter', ',', 'emptyvalue', NaN);

endowment = 5;  % strong player only
data = data(data(:,6) == endowment,:); 


% load lesion groups
idx = 1;
for lesion = 1:4
    lesionData = data(data(:,2) == lesion,:); 

    % get all subjects, except those excluded
    subjects = unique(lesionData(:, 1));
    excluded = [20];   
    subjects = subjects(~ismember(subjects, excluded));
    totalNumPlayers = length(subjects);
    
    for q1 = -5:5:5
        for q2 = -3:3:3
            for q4 = -6:4:6
                %for q9 = 0:10:30
                 %   for q8 = -5:10:15

                        [q,fval]= fminsearch(@EWA_FreeIniA, [q1 q2 0 q4 0, 0 0 q8 q9 0]);

                        % learning parameters
                        lesion
                        fval
                        lambda = exp(q(1))
                        rho = 1/(1+exp(q(2)))
                        delta = 1/(1+exp((q(3))))
                        IniN=(1/(1-rho))/(1+exp(q(4)))
                        phi = exp(q(5))
                        IniA=  [0, q(6),q(7),q(8),q(9),q(10)]
                        %in your case, IniA would only have three values--
                        %one for each shape/cue
                        result(idx,:) = [lesion, fval, lambda,rho,delta,IniN,phi,IniA, q];
                        save 'mainEWA_S_FreeIniA_space.mat' result;
                        idx = idx +1
                    %end
                %end
            end
        end
    end
end

                
