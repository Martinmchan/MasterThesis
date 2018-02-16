close all;
clear all;

t = 1:48000;

normford1 = 25*normpdf(t,12000,5);
normford2 = 25*normpdf(t,24000,5);
normford3 = 25*normpdf(t,36000,5);

normford = normford1 + normford2 + normford3;


plot(normford)


sound(normford, 48000)

audiowrite('gaussTone.wav',normford,48000)