t = 1:1/48000:2;

y = sin(22000*2*pi*t);

sound(y,48000)
audiowrite('testTone22.wav',y,48000);