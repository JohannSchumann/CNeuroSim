

%=========================================================
startup.m:
must be called at start-up time to set the path

README.txt: this file

analysis:
various routines to generate plots of simulation results

ch_analysis:
scripts for plots of V_m over uA/cm^2 and mS/cm^2

gain_filter:
scripts to produce a gain plot (firing frequency over strength of input)
for various neuron types and parameters

graphs:
empty

gui:
draft of a gui for parameter exploration (not finished; used
simulated synaptic input only and only 4 \mu parameters can be changed


input:
utilities to generate different kinds of input signals
(poisson-distributed EPSPs, IPSPs, single spikes, sin, DC, etc.)

input_analysis:
scripts to plot various types of inputs
for demonstration

interactive:
This directory contains a number of scripts to initialize the sim,
to generate inputs, produce plots and save the results.
These scripts can be used in an interactive mode.
Two examples of simple scripts are given:
* ex_001.m:   runs 5 variable neurons on generated input and produces plots
* ex_izh_001.n:  runs 4 2D neurons

netsim
simulation scripts for networks of neurons
needs external programs

neuron:
contains definitions of the ion channels execution (simulation)
mechanisms for one neuron or a vector of neurons

syn_response:
contains main simulator functionality; run_sr4 called from various
other directories

