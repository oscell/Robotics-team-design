clear
clc
rng(10)

num_robots = 5;
dt = 0.1;
totalTime = 10;

sim = simulation(num_robots,dt,totalTime);
sim.run();

