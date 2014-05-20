function [labels] = gensvclabels(Y)

Y(1:10) = 1;
Y(11:20) = 2;
Y(21:30) = 3;
Y(31:40) = 4;
Y(41:50) = 5;
Y(51:end) = 6;
labels = Y;
