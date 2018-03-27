function outSignal = ourTotalNoiseRemoval(signal)
    maxValue = max(signal);
    
    noiseMean = mean(signal(1:10000));
    
    removalConstant = (maxValue + noiseMean)/2;
    
    for i = 1:length(signal)
        signal(i) = max(0,signal(i)-removalConstant);
    end
    outSignal = signal;
end