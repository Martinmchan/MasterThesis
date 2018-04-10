t = 1:1/48000:2;

y = sin(18000*2*pi*t);

sound(y,48000)
audiowrite('testTone18.wav',y,48000);