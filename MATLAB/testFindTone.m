close all;
clear all;


[mic1, f] = audioread('cap168.wav');
[mic2, f] = audioread('cap99.wav');
[mic3, f] = audioread('cap38.wav');


mic1 = mic1 - mean(mic1);
mic2 = mic2 - mean(mic2);
mic3 = mic3 - mean(mic3);

s1 = 1:200000;
s2 = 200001:400000;
s3 = 400001:600000;

[x1Start x1End] = findTone(mic1(s1),mic2(s1),mic3(s1));
[x2Start x2End] = findTone(mic1(s2),mic2(s2),mic3(s2));
[x3Start x3End] = findTone(mic1(s3),mic2(s3),mic3(s3));






