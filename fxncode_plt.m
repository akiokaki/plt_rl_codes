%Idea here is to make sure the program runs well for one subject, 
%in one condition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function y = fxncode_plt(q)

global data

y = 0;
    
    epsilon = 0.00000001;
    lambda = exp(q(1));
    alpha = q(2);  
    
    %%%% Matrix for cues presented %%%%%%%%%%%%%
    pres = [data(:,8), data(:,9)];
    
    %%%% Vector for cues picked %%%%%%%%%%%%%%%%
    picked = data(:,10);
    
    %%%% Create vector for points earned %%%%%%%
    points = data(:,6);
    
    %%%% Set values for cues %%%%%%%%%%%%%%%%%%%%%%%
    Q0 = zeros(120,1);
    Q33 = zeros(120,1);
    Q66 = zeros(120,1);
    
% update values of cues
    t=1;
	while t<120
		switch (picked(t,1)) 
			case 0
				Q0(t+1,:) = Q0(t,:) + alpha * (points(t,1)- Q0(t,:));
				Q33(t+1,:) = Q33(t,:);
				Q66(t+1,:) = Q66(t,:);
			case 33
				Q33(t+1,:) = Q33(t,:) + alpha * (points(t,1)- Q33(t,:));
				Q0(t+1,:) = Q0(t,:);
				Q66(t+1,:) = Q66(t,:);
			case 66
				Q66(t+1,:) = Q66(t,:) + alpha * (points(t,1)- Q66(t,:));
				Q0(t+1,:) = Q0(t,:);			
				Q33(t+1,:) = Q33(t,:);
			otherwise
				Q0(t+1,:) = Q0(t,:);
				Q33(t+1,:) = Q33(t,:);
				Q66(t+1,:) = Q66(t,:);
		end
	t = t+1;
	end

    %%%% probabilities
    % note that prob of action k is equal to 1/( sum_k( exp(lambda * (a_k-a_i)))
%    t = 1;
%    while t<= 120
%        i = 1;
%        while i <= e_m+1
%           P(t,i)= 1/sum(exp( (A(t,:)-A(t,i)) * lambda));
%           i = i+1;
%        end
%        t = t+ 1;
%    end
    
    %%%%%%

    % should use P(t) to match with S_m(t+1)
%    tmpP = sum((P(1:length(x),:).*S_m(1:length(x),:))')';

    % MLE function
%    y = y-1*sum ( log(tmpP+epsilon));
end