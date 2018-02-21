close all;
clear all;
%Initialize camera position
cameraMatrix = [0 0 1.7; -0.1 2.5 1.7; 2 0.5 1.65; 2.0 2.6 1.85];

%Reads the data and plots them
[mic1, f] = audioread('cap168.wav');
[mic2, f] = audioread('cap99.wav');
[mic3, f] = audioread('cap38.wav');
[mic4, f] = audioread('cap250.wav');

mic1 = mic1 - mean(mic1);
mic2 = mic2 - mean(mic2);
mic3 = mic3 - mean(mic3);
mic4 = mic4 - mean(mic4);

plot(mic1)
hold on
plot(mic2)
plot(mic3)
plot(mic4)

%Syncs all the microphones using mic1 as master, then plot the result.
%Distance between the microphones are also shown as an indicator of how
%good the sync was.
s1 = 1:200000;
s2 = 200001:400000;
s3 = 400001:600000;
s4 = 600001:800000;

[mic2, dist12] = ourSync2(mic1, mic2, s1, s2);
[mic3, dist13] = ourSync2(mic1, mic3, s1, s3);
[mic4, dist14] = ourSync2(mic1, mic4, s1, s4);

figure
plot(mic1)
hold on
plot(mic2)
plot(mic3)
plot(mic4)


%%
    L = 200000;
    N = 12;
    targetF = 4000;
    f = 48000;
    freq_index = round(targetF/f*N) + 1;

    y1 = mic1(s3);
    y2 = mic4(s3);
    for i = 1:N:L-100
        dft_data = abs(goertzel(y1(i:i+N),freq_index));
        if dft_data >0.1
            cap1= i;
            break;
        end
    end

    for i = 1:N:L-100
        dft_data = abs(goertzel(y2(i:i+N),freq_index));
        if dft_data >0.1
            cap2= i;
            break;
        end
    end

    tdoa = (cap1-cap2)*343/f



