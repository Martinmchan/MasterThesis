function [xS, yS, zS] = LM(y1, y2, y3, y4, xyzMic)
%LM Computes the position for the sound source using Levenberg-Marquardt.
%   INPUT
%       y1, y2, y3, y4 - is the audio files from the microphones, synced
%       and cut so that we only look at the sound the source made.
%       xyzMic - a matrix with the coordinates for the four microphones
%   OUTPUT
%       xS, yS, zS - the coordinates for the sound source

    f = 48000;

    %Compute tdoa
    tdoa12 = ourGccphat(y1, y2);
    tdoa13 = ourGccphat(y1, y3);
    tdoa14 = ourGccphat(y1, y4);

    tdoa12 = tdoa12/f*343;
    tdoa13 = tdoa13/f*343;
    tdoa14 = tdoa14/f*343;
    
    %Initial guess
    x0 = [1.05,0.7,1]';

    %Boundaries for the room
    lb = [-1,-1,0];
    ub = [3,3,3];

    %Calculate the position of the sound source using Levenberg-Marquardt
    %options.Algorithm = 'levenberg-marquardt';
    xP = lsqnonlin(@myFunc,x0, lb ,ub, [], tdoa12, tdoa13, tdoa14, xyzMic);
    
    xS = xP(1,1); yS = xP(2,1); zS = xP(3,1);

end