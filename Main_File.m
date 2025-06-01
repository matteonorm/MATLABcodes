clear all
tic
disp("started");

%----------------------------------------------------------------------------------------------------------------
% Settings
%----------------------------------------------------------------------------------------------------------------
basepath             = ...; # hidden due to username
cd(basepath)

% Set years of analysis
years                = (1997:2017);

% Saving directory 
outputname           = "CPI panel Figure 1 Replication";
outputpath           = datestr(datetime, 'yyyy-mm-dd HH-MM-SS') + outputname;
mkdir(outputpath);

%----------------------------------------------------------------------------------------------------------------
% Upload and Cleaning
%----------------------------------------------------------------------------------------------------------------

run("Cleaning.m");

%----------------------------------------------------------------------------------------------------------------
% Input-Output parameters
%----------------------------------------------------------------------------------------------------------------

[beta, alpha, omega, delta] = inputoutput(data, years);

%----------------------------------------------------------------------------------------------------------------
% Phillips curve slope
%----------------------------------------------------------------------------------------------------------------

% Preference parameters calibartion
gamma = 1;
phi   = 2;

% Slope function
[slope] = slopefunction(beta,alpha,omega,delta,gamma,phi,years);

%----------------------------------------------------------------------------------------------------------------
% Constant consumption + constant input shares
%----------------------------------------------------------------------------------------------------------------

% Constant consumption shares
beta_constant       = mean(beta, 2);
beta_constant       = repmat(beta_constant,[1,length(years)]);
[slope_cons_share]  = slopefunction(beta_constant,alpha,omega,delta,gamma,phi,years);

% Constant input shares
omega_constant      = mean(omega, 3);
alpha_constant      = mean(alpha,2);
omega_constant      = repmat(omega_constant,[1,1,length(years)]);
alpha_constant      = repmat(alpha_constant,[1,length(years)]);
[slope_input_share] = slopefunction(beta,alpha_constant,omega_constant,delta,gamma,phi,years);

%----------------------------------------------------------------------------------------------------------------
% Graph
%----------------------------------------------------------------------------------------------------------------

years = (1997:2017);
figure;
plot(years, slope, '-o', 'LineWidth', 2); hold on;
plot(years, slope_input_share, '-s', 'LineWidth', 2);
plot(years, slope_cons_share, '-d', 'LineWidth', 2);
hold off;
xlabel('Years');
title('CPI Phillips Curve');
legend('Calibrated slope', 'Constant Input Shares', 'Constant Consumption Shares', 'Location','best');
grid on;
set(gca, 'FontSize', 12);
xlim([min(years), max(years)]);

% Save
saveas(gcf,fullfile(outputpath, 'CPI_Phillips_Curve_Slope.png'))

disp("end");
toc