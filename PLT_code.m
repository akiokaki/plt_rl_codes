clear
global block subjects blockData

%behavioral data
data = xlsread('C:\Users\AkioKakishima\Google Drive\Reinforcement_Learning\EWA\excel_file.xlsx','Sheet2');

%define variables
blockData = data;
block = data(:,7)

% get all subjects, except those excluded
subjects = unique(blockData(:, 1));
excluded = [1009 1015 1023 1024 1025 1026 1027 1030 1034 1035];   
subjects = subjects(~ismember(subjects, excluded));

idx = 1;
%Loop below process for all 40 subjects from #1007, #1008...#1056
for subjects = 1007:1056;
   
    %Separate experiment by blocks, because each block used different
    %shapes
    for block = 1:1:4 
        %Restrict the range of parameter lambda (ie the inverse
        %temperature) so that it's above 0 and upto 5(which is arbitrarily
        %fixed)
        for q1 = 0:5
            %restrict alpha to be between 0 and 1 
            for q2 = 0:1
                [q,fval]= fmincon(@ideas, [q1 q2 0 ]);
                        % learning parameters
                        subjects
                        block
                        fval
                        alpha = q(2)
                        lambda = q(1)
                        
                        result(idx,:) = [subjects, block, fval, alpha, lambda, q];
                        save 'PLT_code.mat' result;
                        idx = idx +1
            end
        end
    end
end
