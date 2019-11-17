function [rcaDataALL, W, A] = rcRun(eegSrc, dirResData, varargin)

    nReg = 7;
    nComp = 3;
    
    if (~exist(dirResData, 'dir'))
        mkdir(dirResData);
    end

   
    fileRCA = fullfile(dirResData, 'resultRCA.mat');
    
    % run RCA
    if(~exist(fileRCA, 'file'))
        [rcaDataALL, W, A, ~, ~, ~, ~] = rcaRun(eegSrc', nReg, nComp);
        save(fileRCA, 'rcaDataALL', 'W', 'A');
    else
        load(fileRCA);
    end
end