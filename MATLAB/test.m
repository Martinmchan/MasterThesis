
clear all
close all
%Reads the data and plots them
[mic1, f] = audioread('mic1.wav');
[mic2, f] = audioread('mic2.wav');
[mic3, f] = audioread('mic3.wav');
[mic4, f] = audioread('mic4.wav');
[mic5, f] = audioread('mic5.wav');

plot(mic1)
figure
plot(mic5)
