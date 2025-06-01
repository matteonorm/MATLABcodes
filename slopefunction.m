function [slope] = slopefunction(beta,alpha,omega,delta,gamma,phi,years)

% This function calculates the consumer price Phillips curve slope, which
% only depends on the pass-through of wages into consumer prices

[n,~] = size(beta);
slope = zeros(1,length(years));

for i = 1:length(years)

    num = beta(:,i)' * (delta(:,:,i) .* ((eye(n) - omega(:,:,i) ...
        .* delta(:,:,i))^(-1) * alpha(:,i)));
    den = 1 - beta(:,i)' * (delta(:,:,i) .* ((eye(n) - omega(:,:,i) ...
        * delta(:,:,i))^(-1) * alpha(:,i)));
    slope(:,i) = (gamma + phi) * (num / den);
end

end