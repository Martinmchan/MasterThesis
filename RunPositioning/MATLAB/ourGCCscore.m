function score = ourGCCscore(mic1, mic2)
    
    sz = min([length(mic1) length(mic2)]);
    window = 4000;
    Ncorr = 2*window-1;
    
    score = [];

    for i = 1:window:sz-window
        gcc = returnFullGCC(mic1(i:i+window), mic2(i:i+window));
        lags = (-(Ncorr-1)/2:(Ncorr-1)/2).';
        [~, idx] = max(gcc);
        gcc = floor((window/2+lags(idx)));
        score = [score gcc];
    end
        
    [score, xout] = hist(score, 150);    
    [~, maxScoresIndex] = max(score);
    score = xout(maxScoresIndex);
end