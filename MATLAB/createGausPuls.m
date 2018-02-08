tc = gauspuls('cutoff',250e3,0.6,[],-40); 
t1 = -tc : 1/4800000 : tc; 
y1 = gauspuls(t1,250e3,0.6);
plot(t1,y1)
sound(y1,48000);


