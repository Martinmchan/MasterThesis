function score = gccScore(mic1, mic2)
    
    sz = min([length(mic1) length(mic2)]);

    window = 2000;
    score = [];

    for i = 1:window:sz-window
        gcc = returnFullGCC(mic1(i:i+window), mic2(i:i+window));
        
        [~, gcc] = max(gcc);
        score = [score gcc];
    end
    
    figure
    h = histogram(score/48000*343, 150)
    
    score = mean(score);
        
%     [score, xout] = hist(score, 150);    
%     [~, maxScoresIndex] = max(score);
%     score = xout(maxScoresIndex);
    
    
    

end