function syncedSignal = manualSync(signal, samples)

    if samples > 0
        syncedSignal = [zeros(samples,1); signal];
    elseif samples < 0
        syncedSignal = signal(-samples:end);
    else
        syncedSignal = signal;
    end



end