%Idea here is to make sure the program runs well for one subject, 
%in one condition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function y = fxncode_plt(q)

global data

y = 0;
    %%% Reiterate variables
	%epsilon makes sure the MLE function doesn't hit below 0
    epsilon = 0.00000001;
    lambda = exp(q(1));
    alpha = q(2);  
 
    
    %%% Matrix for cues presented 
    pres = [data(:,8), data(:,9)];
	
	%%% Alternatively, vector for cues presented
	% if cond = 1 or 3 then 33/0
	% if cond = 2 or 5 then 66/0
	% if cond = 4 or 6 then 66/33
    Cond = data(:,2);
	
    %%% Vector for cues picked by subject
    picked = data(:,10);
    
    %%% Create vector for points earned
    points = data(:,6);
    
    %%% Set values for cues
    Q0 = zeros(120,1);
    Q33 = zeros(120,1);
    Q66 = zeros(120,1);
     
	Q0(1,1)= 1;
    Q33(1,1)= 1;
    Q66(1,1) = 1;
    
	%%% Update values of cues
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

    %%% Probabilities
    % note that prob of action k is equal to 1/( sum_k( exp(lambda * (a_k-a_i)))
	% pi(a) = exp(Qa *lambda)/sum(exp(Qb *lambda))
	
    t = 1;
    while t<= 120
		switch (Cond(t,1))
			case {1,3}
				P(t,1)= exp(Q0(t,1)*lambda)/(exp(Q33(t,1) * lambda) + exp(Q0(t,1)*lambda));
				P(t,2)= exp(Q33(t,1)*lambda)/(exp(Q33(t,1) * lambda) + exp(Q0(t,1)*lambda));
				P(t+1,:)= P(t,:);
			case {2,5}
				P(t,1)= exp(Q0(t,1)*lambda)/(exp(Q66(t,1) * lambda) + exp(Q0(t,1)*lambda));
				P(t,3)= exp(Q66(t,1)*lambda)/(exp(Q66(t,1) * lambda) + exp(Q0(t,1)*lambda));
				P(t+1,:)= P(t,:);
			case {4,6}
				P(t,2)= exp(Q33(t,1)*lambda)/(exp(Q66(t,1) * lambda) + exp(Q33(t,1)*lambda));
				P(t,3)= exp(Q66(t,1)*lambda)/(exp(Q66(t,1) * lambda) + exp(Q33(t,1)*lambda));
				P(t+1,:)= P(t,:);
		end
        t = t+ 1;
    end

    t = 1;
	tmpP = zeros(120,1);

  while t<= 120
		switch (picked(t,1))
			case 0
				tmpP(t,1) = P(t,1);
			case 33
				tmpP(t,1) = P(t,2);
			case 66
				tmpP(t,1) = P(t,3);
		end
        t = t+ 1;
   end
	
    % MLE function
    y = y-1*sum ( log(tmpP+epsilon));
end
