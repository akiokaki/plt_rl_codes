% this function estimate the MLE at group level.
% strong player 
% pooled 1st period observations using IniA(q)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function y = EWA_FreeIniA(q)

global endowment subjects lesionData

data = lesionData;
y = 0;
totalNumPlayers = length(subjects);

% loop over subjects
for id = 1:totalNumPlayers
    xtmp = data(data(:,1) == subjects(id), :);              
    x =[ xtmp(:,9) xtmp(:,10)];

    % x is the n by 2 time sereies, x(:,1) is MyInvestment, x(:,2) is
    % OppInvestment, n is the total period

    epsilon = 0.00000001;

    % assign payoff matrices
    r=10;
    if endowment == 5
        e_m=5;
        e_o=4;
        % 0,1,2,3,4 respectively.
        U_m = [e_m,   e_m,   e_m,     e_m,     e_m; 
            r+e_m-1, e_m-1,  e_m-1,   e_m-1,   e_m-1;
            r+e_m-2,r+e_m-2, e_m-2,   e_m-2,   e_m-2;
            r+e_m-3,r+e_m-3, r+e_m-3, e_m-3,   e_m-3;
            r+e_m-4,r+e_m-4, r+e_m-4, r+e_m-4, e_m-4;
            r+e_m-5,r+e_m-5,r+e_m-5,  r+e_m-5, r+e_m-5] ;

        U_o = [e_o,e_o,e_o,e_o,e_o,e_o;
            r+e_o-1, e_o-1,   e_o-1,  e_o-1,    e_o-1, e_o-1;
            r+e_o-2, r+e_o-2, e_o-2,  e_o-2,    e_o-2, e_o-2;
            r+e_o-3, r+e_o-3, r+e_o-3, e_o-3,   e_o-3, e_o-3;
            r+e_o-4, r+e_o-4, r+e_o-4, r+e_o-4, e_o-4, e_o-4] ;
    else
        e_m=4;
        e_o=5;
        % 0,1,2,3,4 respectively.
        U_o = [e_o, e_o, e_o, e_o, e_o; 
            r+e_o-1, e_o-1,  e_o-1,   e_o-1,   e_o-1;
            r+e_o-2,r+e_o-2, e_o-2,   e_o-2,   e_o-2;
            r+e_o-3,r+e_o-3, r+e_o-3, e_o-3,   e_o-3;
            r+e_o-4,r+e_o-4, r+e_o-4, r+e_o-4, e_o-4;
            r+e_o-5,r+e_o-5,r+e_o-5,  r+e_o-5, r+e_o-5] ;

        U_m = [e_m,e_m,e_m,e_m,e_m,e_m;
            r+e_m-1, e_m-1,   e_m-1,  e_m-1,    e_m-1, e_m-1;
            r+e_m-2, r+e_m-2, e_m-2,  e_m-2,    e_m-2, e_m-2;
            r+e_m-3, r+e_m-3, r+e_m-3, e_m-3,   e_m-3, e_m-3;
            r+e_m-4, r+e_m-4, r+e_m-4, r+e_m-4, e_m-4, e_m-4] ;
    end


    %%%
    % % learning parameters for fminunc
    lambda = exp(q(1));
    rho = 1/(1+exp(q(2)));
    delta = 1/(1+exp((q(3))));
    IniN=(1/(1-rho))/(1+exp(q(4)));
    phi = exp(q(5)); 
   

    %N's
    N=ones(length(x),1);
    N(1)=IniN;
    for i=2:length(x)
        N(i)=N(i-1)*rho + 1;
    end

    %%%% Attractions   %%%%%%%%%%%%%%%%%%%%%%%
    if endowment ==5
%         IniA = exp([0, q(6:10)]);
        IniA = [0, q(6:10)];
    else
%         IniA = exp([q(6),0, q(7:9)]);
        IniA = [q(6), 0, q(7:9)];
    end
    A = zeros(80, endowment+1);
    A(1,:) = IniA;
    
    % load strategies 
    S_m = zeros(length(x),e_m+1);
    S_o = zeros(length(x),e_o+1);
    t = 1;
    while t<=length(x)
        S_m(t, x(t,1)+1)=1;         % +1, because investmet belongs to 0-5, while S varies from 1-6
        S_o(t, x(t,2)+1)=1;
        t = t+1;
    end
    % update attractions
    t=1;
    while t<length(x)
        A(t+1,:) = (A(t,:) * N(t) * phi + ( delta + (1-delta)*S_m(t,:)) .* (U_m*S_o(t,:)')')/N(t+1);
        t = t+1;
    end

    %%%% probabilities
    % note that prob of action k is equal to 1/( sum_k( exp(lambda * (a_k-a_i)))
    t = 1;
    while t<= length(x)
        i = 1;
        while i <= e_m+1
           P(t,i)= 1/sum(exp( (A(t,:)-A(t,i)) * lambda));
           i = i+1;
        end
        t = t+ 1;
    end
    
    %%%%%%

    % should use P(t) to match with S_m(t+1)
    tmpP = sum((P(1:length(x),:).*S_m(1:length(x),:))')';

    % MLE function
    y = y-1*sum ( log(tmpP+epsilon));
  
end

