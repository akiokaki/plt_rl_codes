function y = ideas(q)

global subjects blockData 

data = blockData;
y = 0;
totalNumPlayers = 40;

cond = [unique(blockData(:,2))];

for id = 1:totalNumPlayers
    for cond = 1:6
        xtmp = data(data(:,1) == subjects(id), :);              
        r =[xtmp(:,6)];
    x = unique(blockData(:, 4));
    %one column for each shape
    
    alpha = q(2)
    lambda = q(1)
    
    Q0 = zeros(80,1);
    Q33 = zeros(80,1);
    Q66 = zeros(80,1);
    
        t=1;
        if cond ==1
            while t<length(x)
            Q(t+1,:) = (Q(t,:)) + alpha * (r-Q(t,:));
            t = t+1;
            end
        elseif cond ==2
            while t<length(x)
            Q(t+1,:) = (Q(t,:)) + alpha * (r-Q(t,:));
            t = t+1;
            end
        elseif cond ==3
            while t<length(x)
            Q(t+1,:) = (Q(t,:)) + alpha * (r-Q(t,:));
            t = t+1;
            end
        elseif cond ==4
            while t<length(x)
            Q(t+1,:) = (Q(t,:)) + alpha * (r-Q(t,:));
            t = t+1;
            end
        elseif cond ==5
            while t<length(x)
            Q(t+1,:) = (Q(t,:)) + alpha * (r-Q(t,:));
            t = t+1;
            end
        elseif cond ==6
            while t<length(x)
            Q(t+1,:) = (Q(t,:)) + alpha * (r-Q(t,:));
            t = t+1;
            end
        end
    end
end
%Q = (beta * probability^gamma)/(beta * probability^gamma +(1-probability)

%new stuff