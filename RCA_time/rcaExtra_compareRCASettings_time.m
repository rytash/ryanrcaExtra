function res = rcaExtra_compareRCASettings_time(settingsLoaded, settingsCurrent)
    
    % compare subject list
    diff_subjects = isequal(settingsLoaded.subjList, settingsCurrent.subjList);
    
    % compare number of components
    diff_ncomp = (settingsLoaded.nComp == settingsCurrent.nComp);
    
    % compare number of regs
    diff_nreg = (settingsLoaded.nReg == settingsCurrent.nReg);
    
    % compare frequencies
    diff_freq = (settingsLoaded.samplingRate == settingsCurrent.samplingRate);
    
    % compare conditions
    try
        diff_cnd = (settingsLoaded.useConds == settingsCurrent.useConds);
    catch err
        disp('No info on conditions used for analysis, loading data at your own risk');
        diff_cnd = 1; 
    end
       
    res = diff_subjects && diff_ncomp && diff_nreg && diff_freq && diff_cnd;
end