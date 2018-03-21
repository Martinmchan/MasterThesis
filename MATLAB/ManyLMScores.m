function [xS, yS, zS] = ManyLMScores(signalMatrix, nbrOfSpeakers, micMatrix, lsb, usb)
%LM Computes the position for the sound source using Levenberg-Marquardt.
%   INPUT
%       y1, y2, y3, y4 - is the audio files from the microphones, synced
%       and cut so that we only look at the sound the source made.
%       xyzMic - a matrix with the coordinates for the four microphones
%   OUTPUT
%       xS, yS, zS - the coordinates for the sound source
    
    f = 48000;
    
    %Calculate the TDOA
    for i = 2:nbrOfSpeakers
        tmp = gccScore(signalMatrix{1}, signalMatrix{i})
        tdoa{i} = tmp/f*343
    end
  
    %Initial guess
    x0 = [1.05,0.7,1]';

    %Calculate the position of the sound source using Levenberg-Marquardt
    %options.Algorithm = 'levenberg-marquardt';
    xP = lsqnonlin(@ManymyFunc,x0, lsb ,usb, [], tdoa, nbrOfSpeakers, micMatrix);
    xS = xP(1,1); yS = xP(2,1); zS = xP(3,1);

end