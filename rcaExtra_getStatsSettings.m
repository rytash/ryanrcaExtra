function statSettings = rcaExtra_getStatsSettings(rcInfoStruct)
% Copies relevant fields for stat analysis

    statSettings.domain = rcInfoStruct.domain;
    switch statSettings.domain
        case 'time'
            statSettings.samplingRate = rcInfoStruct.samplingRate;
            statSettings.timecourseLen = rcInfoStruct.timecourseLen;
            % copy defaults for time-domain test permute
            statSettings.tParams = {'dim', 2, 'alpha', 0.05};
            statSettings.deletePool = true;
            
        case 'freq'
            statSettings.nBins = numel(rcInfoStruct.binsToUse);
            statSettings.nFreqs = numel(rcInfoStruct.freqsToUse);
        otherwise
    end
    statSettings.nComp = rcInfoStruct.nComp;
end