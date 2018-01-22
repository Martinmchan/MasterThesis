%Calculate the TDOA for three different tests

%The image shows the setup for the experiments
img = imread('installation.png');
imshow(img);

%-------------- 1 m betweeen microphones ----------------------------%
%First test is when the sound source is closer to the microphones, approx
%1m
mic1 = '000103_244_mono1.wav';
mic2 = '000103_244_mono2.wav'; %mic2 is the microphone closest to the sound source
dist1 = calcTDOA(mic1, mic2);

%Second test is when the sound source is further away from the microphones,
%approx 2m
mic1 = '000103_245_mono1.wav'; 
mic2 = '000103_245_mono2.wav'; %mic2 is the microphone closest to the sound source
dist2 = calcTDOA(mic1, mic2);

%Thrid test is when the sound source is even further away from the microphones,
%approx 3m
mic1 = '000103_246_mono1.wav'; 
mic2 = '000103_246_mono2.wav'; %mic2 is the microphone closest to the sound source
dist3 = calcTDOA(mic1, mic2);

%-------------- 2 m betweeen microphones ----------------------------%
%First test is when the sound source is closer to the microphones, approx
%1m
mic1 = '000103_240_mono1.wav';
mic2 = '000103_240_mono2.wav'; %mic2 is the microphone closest to the sound source
dist4 = calcTDOA(mic1, mic2);

%Second test is when the sound source is further away from the microphones,
%approx 2m
mic1 = '000103_241_mono1.wav'; 
mic2 = '000103_241_mono2.wav'; %mic2 is the microphone closest to the sound source
dist5 = calcTDOA(mic1, mic2);

%Thrid test is when the sound source is even further away from the microphones,
%approx 3m
mic1 = '000103_242_mono1.wav'; 
mic2 = '000103_242_mono2.wav'; %mic2 is the microphone closest to the sound source
dist6 = calcTDOA(mic1, mic2);

%-------------- 4 m betweeen microphones ----------------------------%
%Fourth test is when the sound source is closer to the microphones, approx
%1m
mic1 = '000103_247_mono1.wav';
mic2 = '000103_247_mono2.wav'; %mic2 is the microphone closest to the sound source
dist7 = calcTDOA(mic1, mic2);

%Fifth test is when the sound source is further away from the microphones,
%approx 2m
mic1 = '000103_248_mono1.wav'; 
mic2 = '000103_248_mono2.wav'; %mic2 is the microphone closest to the sound source
dist8 = calcTDOA(mic1, mic2);

%Sixth test is when the sound source is even further away from the microphones,
%approx 3m
mic1 = '000103_249_mono1.wav'; 
mic2 = '000103_249_mono2.wav'; %mic2 is the microphone closest to the sound source
dist9 = calcTDOA(mic1, mic2);


TDOADistance = [dist1; dist2; dist3;dist4;dist5;dist6;dist7;dist8;dist9];
MeasuredDistance = {'~1';'~1';'~1';'~2';'~2';'~2';'~4';'~4';'~4'};
SourceDistance = {'~1';'~2';'~3';'~1';'~2';'~3';'~1';'~2';'~3'};
SoundSource = {'Test 1';'Test 2'; 'Test 3'; 'Test 4'; 'Test 5'; 'Test 6'; 'Test 7'; 'Test 8'; 'Test 9'};
table(TDOADistance, MeasuredDistance, SourceDistance,'RowNames',SoundSource)


