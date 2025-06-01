% Continuation to the Main_File
% Import input data code

years = years';
years = num2str(years);

data = {};

for i = 1:length(years)

    % Import Make Tables for Omega

    temp  = readmatrix('BEA_Make_Table.xlsx','Sheet',years(i,:),...
        'Range', 'C8:BU78');
    temp(isnan(temp)) = 0;
    data.(['Make',years(i,:)]) = temp;
    
    % Import Use Tables for Omega, Labor, Consumption, and Export

    temp  = readmatrix('BEA_Use_ProdPrices_Table.xlsx','Sheet',years(i,:),...
        'Range', 'C8:BU78');
    temp(isnan(temp)) = 0;
    data.(['Use',years(i,:)]) = temp;

    % Consumption

    temp  = readmatrix('BEA_Use_ProdPrices_Table.xlsx','Sheet',years(i,:),...
        'Range', 'CQ8:CQ78');
    temp(isnan(temp)) = 0;
    data.(['Consumption',years(i,:)]) = temp;

    % Labor

    temp  = readmatrix('BEA_Use_ProdPrices_Table.xlsx','Sheet',years(i,:),...
        'Range', 'C82:BU82');
    temp(isnan(temp)) = 0;
    data.(['Labor',years(i,:)]) = temp;

    % Export

    temp  = readmatrix('BEA_Use_ProdPrices_Table.xlsx','Sheet',years(i,:),...
        'Range', 'CC8:CC78');
    temp(isnan(temp)) = 0;
    data.(['Export',years(i,:)]) = temp;

    % Import

    temp  = readmatrix('BEA_Use_ProdPrices_Table.xlsx','Sheet',years(i,:),...
        'Range', 'CD8:CD78');
    temp(isnan(temp)) = 0;
    data.(['Import',years(i,:)]) = temp;

    % Use Imports breakdown

    temp  = readmatrix('ImportMatrices_Before_Redefinitions_SUM_1997-2023.xlsx','Sheet',years(i,:),...
        'Range', 'C8:BU78');
    temp(isnan(temp)) = 0;
    data.(['ImportUse',years(i,:)]) = temp;

end

cd(basepath + "\" + outputpath)
save('InputData.mat', "-struct","data")
cd(basepath)

clear temp