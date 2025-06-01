function [beta, alpha, omega, delta] = inputoutput(data, years)

% This function calculates the consumption shares, labor shares,
% input-output matrix, and price adjustments matrix

[F,C] = size(data.(['Make',years(1,:)])); % should be all the same,
% but check input data

beta       = zeros(F,length(years));
alpha      = zeros(F,length(years));
omega      = zeros(F,F,length(years));

cons_share      = zeros(F,C);
total_cost      = zeros(F,1);

for i = 1:length(years)     
    % Consider domestic consumption
    temp_cons     = data.(['Consumption',years(i,:)]);
    temp_import   = data.(['Import',years(i,:)]);
    temp_export   = data.(['Export',years(i,:)]);

    dom_cons_temp = temp_cons - temp_import ...
                - temp_export;

    % Consider use net of import
    temp_use            = data.(['Use',years(i,:)]);
    temp_import_use     = data.(['ImportUse',years(i,:)]);
    temp_net_use        = temp_use - temp_import_use;

    % Consider labor
    temp_labor          = data.(['Labor',years(i,:)]);
    temp_labor          = temp_labor';

    for f = 1:F
            % Compute nominal sectoral consumption shares
            temp_make     = data.(['Make',years(i,:)]);
            for c = 1:C
                cons_share(f,c)    = temp_make(f,c) / sum(temp_make(:,c));
            end
    end

    % Compute the expenditure on intermediate goods
    exp_inter_goods   =  cons_share * temp_net_use;

    for f = 1:F

        % Compute total expenditure by firm
        total_cost(f,:)       = sum(exp_inter_goods(f,:)) + temp_labor(f,:);

    end

    % Compute nominal sectoral consumption shares in 
    % nominal consumption
    beta(:,i)    = cons_share*dom_cons_temp / sum(cons_share*dom_cons_temp);
    
    % Compute sectoral labor shares in 
    % total cost
    alpha(:,i)     = temp_labor./total_cost;
    
    % Compute sectoral expenditur in intermediate goods in 
    % total cost
    
    omega(:,:,i)  = exp_inter_goods ./ total_cost;
   
end

% Vector of uniform random variables in [0,1] (price adjustment
% parameters) % assumed constant over time
delta  = diag(rand(F, 1));
delta  = repmat(delta,[1,1,length(years)]);

end