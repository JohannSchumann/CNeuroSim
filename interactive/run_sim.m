%
% script to run the simulation with a fixed random seed
% for reproduceability of runs
%
%	$Revision:$

rand('seed',99);
randn('seed',1387);

fprintf('Starting simulation...\n');
run_sr4;
