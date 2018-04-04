function [signalMatrix, f] = readData(type, namebase, nbrOfSpeakers)

%     microphones{1} = 0;
%     if type == 'n'
%         for i=1:nbrOfSpeakers
%             microphones{i} = sprintf('%s%d%s','./NCS/mic',i,namebase);
%         end
%     elseif type == 't'
%         for i=1:nbrOfSpeakers
%             microphones{i} = sprintf('%s%d%s',namebase,i,'.wav');
%         end
%     end
% 
%     signalMatrix = [];
%     f=0;
%     for i = 1:nbrOfSpeakers
%         [mic, f] = audioread(microphones{i});
%         mic = mic - mean(mic);
%         signalMatrix{i} = mic;
%     end
%     

    [signalMatrix{1}, f] = audioread('test1.wav');
    [signalMatrix{2}, f] = audioread('test2.wav');
    [signalMatrix{3}, f] = audioread('test3.wav');
    [signalMatrix{4}, f] = audioread('test4.wav');
end
    