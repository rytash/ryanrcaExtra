function [proj, subj, projectedMeanSubj] = averageSweepData(inputData, nBs, nFs)
% Alexandra Yakovleva, Stanford University 2012-2020. 
% modified by LLV
    nComps = size(inputData{1, 1}, 2);
     
    %% Step 2. Split into Real/Imag components
    [data_Re, data_Im] = getRealImag_byBin(inputData, nBs, nFs, nComps);
    
    % data_X is cell array Subjs x Cnds, each element is 1:nBs x 1:nFs x nTrials  
    % avg project -- subjects's data is merged together and computed weighted average
    % avg subject -- subject's data is averaged separately
    
    %% Step 3. Computed weighted avg across subjects (every subj is a trial)
    
    [avgProj_Re, avgSubj_Re, ~] = averageProjectSweep(data_Re, nBs);
    [avgProj_Im, avgSubj_Im, ~] = averageProjectSweep(data_Im, nBs);
    
    %% Step 4. Computed weighted avg for subjects
    data_aRe = averageSubjectsSweep(data_Re);
    data_aIm = averageSubjectsSweep(data_Im);

    %% Step 5. Fit error ellipse for project and subject data 
    errSubj = computeErrorSubjSweep(data_aRe, data_aIm);
    [ampErrP, phaseErrP, ellipse] = computeErrorProjSweep(avgSubj_Re, avgSubj_Im);
    
    %% Step 6. Calc Proj/Subj amplitude and phase 
    [ampProj, phaseProj] = computeAmpPhaseSweep(avgProj_Re, avgProj_Im);
    [ampSubj, phaseSubj] = computeAmpPhaseSweep(avgSubj_Re, avgSubj_Im);
    
    %% Step 7. Get rid of cells?
    proj = projectProjDataSweep(ampProj, phaseProj, ampErrP, phaseErrP);
    proj.avgRe = cat(4, avgProj_Re{:});
    proj.avgIm = cat(4, avgProj_Im{:}); 
    proj.ellipseErr = ellipse;
    proj.subjsRe = cat(4, avgSubj_Re(:, :));
    proj.subjsIm = cat(4, avgSubj_Im(:, :));
    subj = projectSubjDataSweep(ampSubj, phaseSubj, errSubj);
    
    %% Step 8. Add projected mean subject data
    projectedMeanSubj = projectSubjectAmplitudesSweep(proj);
    projectedMeanSubj.err = subj.err;
end