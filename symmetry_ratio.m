function [ratio] = symmetry_ratio(click)

env = abs(hilbert(click));
ratio = sum(env(1:floor(end/2)))/sum(env(floor(end/2)+1:end));
