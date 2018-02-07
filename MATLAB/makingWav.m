t = 1:1/48000:3;

y = sin(250*2*pi*t);

audiowrite('testTone.wav',y,48000);