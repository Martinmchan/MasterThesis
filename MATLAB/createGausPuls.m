tc = gauspuls('cutoff',250e3,0.6,[],-40); 
t1 = -tc : 1/4800000 : tc; 
y1 = gauspuls(t1,250e3,0.6);
plot(t1,y1)
sound(y1,48000);

%%
t2 = -0.3:1/48000:0.3;
y2 = 10*sinc(400*t2);
plot(t2,y2)
sound(y2, 48000)
audiowrite('sinc.wav', y2, 48000)
