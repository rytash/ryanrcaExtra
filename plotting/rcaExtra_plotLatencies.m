function fh_PhasesFreqs = rcaExtra_plotLatencies(rcaResult, plotSettings)

% Function will plot amplitude bars for a given RC result structure.
% input arguments: rcaResult structure       
    
    if (isempty(plotSettings))
       % fill settings template
       plotSettings = rcaExtra_getPlotSettings(rcaResult.rcaSettings);
       plotSettings.legendLabels = arrayfun(@(x) strcat('Condition ', num2str(x)), ...
           1:size(rcaResult.projAvg.ellipseErr, 1), 'uni', false);
       % default settings for all plotting: 
       % font type, font size
       
       plotSettings.Title = 'Latency Plot';
       plotSettings.RCsToPlot = 3;
       % legend background (transparent)
       % xTicks labels
       % xAxis, yAxis labels
       % hatching (yes/no) 
       % plot title 
        
    end
    
    freqIdx = cellfun(@(x) str2double(x(1)), rcaResult.rcaSettings.useFrequencies, 'uni', true);
    freqVals = rcaResult.rcaSettings.useFrequenciesHz*freqIdx;
    fh_PhasesFreqs = cell(rcaResult.rcaSettings.nComp, 1);
    for cp = 1:rcaResult.rcaSettings.nComp
        
        %dims nF by nConditions
        rcaAngles = squeeze(rcaResult.projAvg.phase(:, cp, :));
        rcaAngErrs = squeeze(rcaResult.projAvg.errP(:, cp, :, :));
        fh_PhasesFreqs{cp} = rcaExtra_latplot_freq(freqVals, rcaAngles, rcaAngErrs, ...
            plotSettings.useColors, plotSettings.legendLabels);
        fh_PhasesFreqs{cp}.Name = strcat('Latencies RC ', num2str(cp),...
            ' F = ', num2str(rcaResult.rcaSettings.useFrequenciesHz));        
        title(fh_PhasesFreqs{cp}.Name);
        try
            saveas(fh_PhasesFreqs{cp}, ...
                fullfile(rcaResult.rcaSettings.destDataDir_FIG, [fh_PhasesFreqs{cp}.Name '.fig']));
        catch err
            rcaExtra_displayError(err);
        end
    end
end