function [xS, yS, zS] = LM2(y1, y2, y3, y4, y5, xyz)
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
    tdoa15 = ourGccphat(y1, y5);

    tdoa12 = tdoa12/f*343;
    tdoa13 = tdoa13/f*343;
    tdoa14 = tdoa14/f*343;
    tdoa15 = tdoa15/f*343;
  
    %Initial guess
    x0 = [1.05,0.7,1]';

    %Boundaries for the room
    lb = [-1,-1,0];
    ub = [3,3,3];

    scoreMatrix = zeros(4,50);
    
    %Calculate the position of the sound source using Levenberg-Marquardt
    %options.Algorithm = 'levenberg-marquardt';

    xP = lsqnonlin(@myFunc,x0, lb ,ub, [], tdoa12(1), tdoa13(1), tdoa14(1), xyz);
    err = tdoa15(1) - sqrt((xP(1,1)-xyz(1,1)).^2 + (xP(2,1)-xyz(1,2)).^2 + (xP(3,1)-xyz(1,3)).^2) + sqrt((xP(1,1)-xyz(5,1)).^2 + (xP(2,1)-xyz(5,2)).^2 + (xP(3,1)-xyz(5,3)).^2);
    scoreMatrix(1,1) = xP(1,1);scoreMatrix(2,1) = xP(2,1); scoreMatrix(3,1) = xP(3,1);
    scoreMatrix(4,1) = err;
    
    for i = 2:50
       peak2 = floor(rand*5)+1;peak3 = floor(rand*5)+1;
       peak4 = floor(rand*5)+1;peak5 = floor(rand*5)+1; 
       
       disp("" + peak2 + "" + peak3 + "" + peak4 + "" + peak5)
       
       xP = lsqnonlin(@myFunc,x0, lb ,ub, [], tdoa12(peak2), tdoa13(peak3), tdoa14(peak4), xyz);
       err1 = tdoa15(peak5) - sqrt((xP(1,1)-xyz(1,1)).^2 + (xP(2,1)-xyz(1,2)).^2 + (xP(3,1)-xyz(1,3)).^2) + sqrt((xP(1,1)-xyz(5,1)).^2 + (xP(2,1)-xyz(5,2)).^2 + (xP(3,1)-xyz(5,3)).^2);
       err2 = tdoa15(peak5) - sqrt((xP(1,1)-xyz(2,1)).^2 + (xP(2,1)-xyz(2,2)).^2 + (xP(3,1)-xyz(2,3)).^2) + sqrt((xP(1,1)-xyz(5,1)).^2 + (xP(2,1)-xyz(5,2)).^2 + (xP(3,1)-xyz(5,3)).^2);
       err3 = tdoa15(peak5) - sqrt((xP(1,1)-xyz(3,1)).^2 + (xP(2,1)-xyz(3,2)).^2 + (xP(3,1)-xyz(3,3)).^2) + sqrt((xP(1,1)-xyz(5,1)).^2 + (xP(2,1)-xyz(5,2)).^2 + (xP(3,1)-xyz(5,3)).^2);
       err4 = tdoa15(peak5) - sqrt((xP(1,1)-xyz(4,1)).^2 + (xP(2,1)-xyz(4,2)).^2 + (xP(3,1)-xyz(4,3)).^2) + sqrt((xP(1,1)-xyz(5,1)).^2 + (xP(2,1)-xyz(5,2)).^2 + (xP(3,1)-xyz(5,3)).^2);
       
       err = sqrt(err1^2 + err2^2 + err3^2 + err4^2);
       scoreMatrix(1,i) = xP(1,1);scoreMatrix(2,i) = xP(2,1); scoreMatrix(3,i) = xP(3,1);
       scoreMatrix(4,i) = err;
    end
    
    [~,idx] = min(scoreMatrix(4,:));
    
    xS = scoreMatrix(1,idx); yS = scoreMatrix(2,idx); zS = scoreMatrix(3,idx);


end   
%     xP = lsqnonlin(@myFunc,x0, lb ,ub, [], tdoa12(1), tdoa13(1), tdoa14(1), xyz);
%     err = tdoa15(2) - sqrt((xP(1,1)-xyz(1,1)).^2 + (xP(2,1)-xyz(1,2)).^2 + (xP(3,1)-xyz(1,3)).^2) + sqrt((xP(1,1)-xyz(5,1)).^2 + (xP(2,1)-xyz(5,2)).^2 + (xP(3,1)-xyz(5,3)).^2);
%     scoreMatrix(1,2) = xP(1,1);scoreMatrix(2,2) = xP(2,1); scoreMatrix(3,2) = xP(3,1);
%     scoreMatrix(4,2) = err;
%     
%     xP = lsqnonlin(@myFunc,x0, lb ,ub, [], tdoa12(1), tdoa13(1), tdoa14(2), xyz);
%     err = tdoa15(1) - sqrt((xP(1,1)-xyz(1,1)).^2 + (xP(2,1)-xyz(1,2)).^2 + (xP(3,1)-xyz(1,3)).^2) + sqrt((xP(1,1)-xyz(5,1)).^2 + (xP(2,1)-xyz(5,2)).^2 + (xP(3,1)-xyz(5,3)).^2);
%     scoreMatrix(1,3) = xP(1,1);scoreMatrix(2,3) = xP(2,1); scoreMatrix(3,3) = xP(3,1);
%     scoreMatrix(4,3) = err;
%     
%     xP = lsqnonlin(@myFunc,x0, lb ,ub, [], tdoa12(1), tdoa13(2), tdoa14(1), xyz);
%     err = tdoa15(1) - sqrt((xP(1,1)-xyz(1,1)).^2 + (xP(2,1)-xyz(1,2)).^2 + (xP(3,1)-xyz(1,3)).^2) + sqrt((xP(1,1)-xyz(5,1)).^2 + (xP(2,1)-xyz(5,2)).^2 + (xP(3,1)-xyz(5,3)).^2);
%     scoreMatrix(1,4) = xP(1,1);scoreMatrix(2,4) = xP(2,1); scoreMatrix(3,4) = xP(3,1);
%     scoreMatrix(4,4) = err;
%     
%     xP = lsqnonlin(@myFunc,x0, lb ,ub, [], tdoa12(2), tdoa13(1), tdoa14(1), xyz);
%     err = tdoa15(1) - sqrt((xP(1,1)-xyz(1,1)).^2 + (xP(2,1)-xyz(1,2)).^2 + (xP(3,1)-xyz(1,3)).^2) + sqrt((xP(1,1)-xyz(5,1)).^2 + (xP(2,1)-xyz(5,2)).^2 + (xP(3,1)-xyz(5,3)).^2);
%     scoreMatrix(1,5) = xP(1,1);scoreMatrix(2,5) = xP(2,1); scoreMatrix(3,5) = xP(3,1);
%     scoreMatrix(4,5) = err;
%     
%     xP = lsqnonlin(@myFunc,x0, lb ,ub, [], tdoa12(1), tdoa13(1), tdoa14(1), xyz);
%     err = tdoa15(3) - sqrt((xP(1,1)-xyz(1,1)).^2 + (xP(2,1)-xyz(1,2)).^2 + (xP(3,1)-xyz(1,3)).^2) + sqrt((xP(1,1)-xyz(5,1)).^2 + (xP(2,1)-xyz(5,2)).^2 + (xP(3,1)-xyz(5,3)).^2);
%     scoreMatrix(1,6) = xP(1,1);scoreMatrix(2,6) = xP(2,1); scoreMatrix(3,6) = xP(3,1);
%     scoreMatrix(4,6) = err;
%     
%     xP = lsqnonlin(@myFunc,x0, lb ,ub, [], tdoa12(1), tdoa13(1), tdoa14(3), xyz);
%     err = tdoa15(1) - sqrt((xP(1,1)-xyz(1,1)).^2 + (xP(2,1)-xyz(1,2)).^2 + (xP(3,1)-xyz(1,3)).^2) + sqrt((xP(1,1)-xyz(5,1)).^2 + (xP(2,1)-xyz(5,2)).^2 + (xP(3,1)-xyz(5,3)).^2);
%     scoreMatrix(1,7) = xP(1,1);scoreMatrix(2,7) = xP(2,1); scoreMatrix(3,7) = xP(3,1);
%     scoreMatrix(4,7) = err;
%     
%     xP = lsqnonlin(@myFunc,x0, lb ,ub, [], tdoa12(1), tdoa13(3), tdoa14(1), xyz);
%     err = tdoa15(1) - sqrt((xP(1,1)-xyz(1,1)).^2 + (xP(2,1)-xyz(1,2)).^2 + (xP(3,1)-xyz(1,3)).^2) + sqrt((xP(1,1)-xyz(5,1)).^2 + (xP(2,1)-xyz(5,2)).^2 + (xP(3,1)-xyz(5,3)).^2);
%     scoreMatrix(1,8) = xP(1,1);scoreMatrix(2,8) = xP(2,1); scoreMatrix(3,8) = xP(3,1);
%     scoreMatrix(4,8) = err;
%     
%     xP = lsqnonlin(@myFunc,x0, lb ,ub, [], tdoa12(3), tdoa13(1), tdoa14(1), xyz);
%     err = tdoa15(1) - sqrt((xP(1,1)-xyz(1,1)).^2 + (xP(2,1)-xyz(1,2)).^2 + (xP(3,1)-xyz(1,3)).^2) + sqrt((xP(1,1)-xyz(5,1)).^2 + (xP(2,1)-xyz(5,2)).^2 + (xP(3,1)-xyz(5,3)).^2);
%     scoreMatrix(1,9) = xP(1,1);scoreMatrix(2,9) = xP(2,1); scoreMatrix(3,9) = xP(3,1);
%     scoreMatrix(4,9) = err;
%     
%     xP = lsqnonlin(@myFunc,x0, lb ,ub, [], tdoa12(1), tdoa13(1), tdoa14(2), xyz);
%     err = tdoa15(2) - sqrt((xP(1,1)-xyz(1,1)).^2 + (xP(2,1)-xyz(1,2)).^2 + (xP(3,1)-xyz(1,3)).^2) + sqrt((xP(1,1)-xyz(5,1)).^2 + (xP(2,1)-xyz(5,2)).^2 + (xP(3,1)-xyz(5,3)).^2);
%     scoreMatrix(1,10) = xP(1,1);scoreMatrix(2,10) = xP(2,1); scoreMatrix(3,10) = xP(3,1);
%     scoreMatrix(4,10) = err;
%     
%     xP = lsqnonlin(@myFunc,x0, lb ,ub, [], tdoa12(1), tdoa13(2), tdoa14(2), xyz);
%     err = tdoa15(1) - sqrt((xP(1,1)-xyz(1,1)).^2 + (xP(2,1)-xyz(1,2)).^2 + (xP(3,1)-xyz(1,3)).^2) + sqrt((xP(1,1)-xyz(5,1)).^2 + (xP(2,1)-xyz(5,2)).^2 + (xP(3,1)-xyz(5,3)).^2);
%     scoreMatrix(1,11) = xP(1,1);scoreMatrix(2,11) = xP(2,1); scoreMatrix(3,11) = xP(3,1);
%     scoreMatrix(4,11) = err;
%     
%     xP = lsqnonlin(@myFunc,x0, lb ,ub, [], tdoa12(2), tdoa13(1), tdoa14(1), xyz);
%     err = tdoa15(2) - sqrt((xP(1,1)-xyz(1,1)).^2 + (xP(2,1)-xyz(1,2)).^2 + (xP(3,1)-xyz(1,3)).^2) + sqrt((xP(1,1)-xyz(5,1)).^2 + (xP(2,1)-xyz(5,2)).^2 + (xP(3,1)-xyz(5,3)).^2);
%     scoreMatrix(1,12) = xP(1,1);scoreMatrix(2,12) = xP(2,1); scoreMatrix(3,12) = xP(3,1);
%     scoreMatrix(4,12) = err;
%     
%     xP = lsqnonlin(@myFunc,x0, lb ,ub, [], tdoa12(1), tdoa13(2), tdoa14(1), xyz);
%     err = tdoa15(2) - sqrt((xP(1,1)-xyz(1,1)).^2 + (xP(2,1)-xyz(1,2)).^2 + (xP(3,1)-xyz(1,3)).^2) + sqrt((xP(1,1)-xyz(5,1)).^2 + (xP(2,1)-xyz(5,2)).^2 + (xP(3,1)-xyz(5,3)).^2);
%     scoreMatrix(1,13) = xP(1,1);scoreMatrix(2,13) = xP(2,1); scoreMatrix(3,13) = xP(3,1);
%     scoreMatrix(4,13) = err;
%     
%     xP = lsqnonlin(@myFunc,x0, lb ,ub, [], tdoa12(2), tdoa13(1), tdoa14(2), xyz);
%     err = tdoa15(1) - sqrt((xP(1,1)-xyz(1,1)).^2 + (xP(2,1)-xyz(1,2)).^2 + (xP(3,1)-xyz(1,3)).^2) + sqrt((xP(1,1)-xyz(5,1)).^2 + (xP(2,1)-xyz(5,2)).^2 + (xP(3,1)-xyz(5,3)).^2);
%     scoreMatrix(1,14) = xP(1,1);scoreMatrix(2,14) = xP(2,1); scoreMatrix(3,14) = xP(3,1);
%     scoreMatrix(4,14) = err;
%     
%     xP = lsqnonlin(@myFunc,x0, lb ,ub, [], tdoa12(2), tdoa13(2), tdoa14(1), xyz);
%     err = tdoa15(1) - sqrt((xP(1,1)-xyz(1,1)).^2 + (xP(2,1)-xyz(1,2)).^2 + (xP(3,1)-xyz(1,3)).^2) + sqrt((xP(1,1)-xyz(5,1)).^2 + (xP(2,1)-xyz(5,2)).^2 + (xP(3,1)-xyz(5,3)).^2);
%     scoreMatrix(1,15) = xP(1,1);scoreMatrix(2,15) = xP(2,1); scoreMatrix(3,15) = xP(3,1);
%     scoreMatrix(4,15) = err;
    
  
    
    

    %a = myFunc([xS, yS, zS], tdoa12, tdoa13, tdoa14, xyzMic)
     