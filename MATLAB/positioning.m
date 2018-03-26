function positionMatrix = positioning(signalMatrix, micMatrix, f, x0, lsb, usb, nbrOfSpeakers, methods);
    positionMatrix = zeros(length(methods),3);
    for i=1:length(methods)
        if length(methods{i,1}) == length('SRPphat')
            if methods{i,1} == 'SRPphat'
                microphones = [];
                for j=1:nbrOfSpeakers
                   mic = signalMatrix{j};
                   microphones = [microphones mic];
                end
                SRPMatrix = zeros(3,methods{j,2});

                for j = 1:length(SRPMatrix(1,:))
                    [finalpos,~,~]=srplems(microphones, micMatrix, f, lsb, usb);
                    xSRP = finalpos(1,1); ySRP = finalpos(1,2); zSRP = finalpos(1,3);
                    SRPMatrix(1,j) = xSRP; SRPMatrix(2,j) = ySRP; SRPMatrix(3,j) = zSRP;
                end
                positionMatrix(i,1) = mean(SRPMatrix(1,:)); positionMatrix(i,2) = mean(SRPMatrix(2,:)); positionMatrix(i,3) = mean(SRPMatrix(3,:));
            end
        end
        
        if length(methods{i,1}) == length('calcPos')
            if methods{i,1} == 'calcPos'
                pos = calcPos(signalMatrix, nbrOfSpeakers, micMatrix, f, x0, lsb, usb, methods{i,2});
                positionMatrix(i,1) = pos(1,1); positionMatrix(i,2) = pos(1,2); positionMatrix(i,3) = pos(1,3);
            end
        end









end