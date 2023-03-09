clear
clc
% close all

rng(10)

%% Simulation time
dt = 0.05;
totalTime = 100;
tVec = 0:dt:totalTime;


%% Teams
num_teams = 2;
robot_radius = 0.15;
sensorRange = 2;
showEnv = false;
Positions = {'Goalkeeper','Attacker','Attacker','Defender','Defender'};


sim = simulation(dt,totalTime,num_teams,robot_radius,showEnv,Positions,sensorRange);



for idx = 2:numel(tVec)
    %% Update
    sim.ball = sim.ball.update_kick(idx,sim.ball.V,sim.ball.orientation);

    for i = 1:sim.numRobots
        %% robot state flow goes here
        % If the robot hasnt arrived go to the ball else drone mode
        if sim.robots(i).arrived == false
            if sim.robots(i).searchBall(sim.ball.Pose)
                disp("Robot "+i+" found the ball")
            end
            sim.robots(i) = sim.robots(i).ToPoint(idx,sim.ball.Pose,sim.ball.orientation,sim.ball.V);
        else
            sim.robots(i) = sim.robots(i).DroneMode(idx,sim.ball.Pose,sim.ball.orientation,sim.ball.V);
        end
    end



    %% Figure
    
    figure(2); clf; hold on; grid off; axis([0 11,0 8]); %set(gca,'visible','off');
    hold on
    sim.ball.show();
    for i = 1:sim.numRobots
        sim.robots(i).show(idx);
    end
    sim.drawpitch();    
    hold off
end



% figure(3); clf; hold on; grid on; axis([0 totalTime,-3 5]);
% % disp(tVec(1:idx))
% % disp(numel(sim.robots(i).poses(1:idx,1)))
% plot(tVec(1:idx),sim.robots(i).poses(1:idx,1))
% plot(tVec,sim.robots(i).poses(:,2))
% title('x and y movement vs Time')
% xlabel('Time')
% ylabel('Position (m)')
% legend('x-position','y-position')
% hold off
% 
% figure(4); clf; hold on; grid on; axis([0 totalTime,-1 2]);
% plot(tVec,sim.robots(i).vels(:,1))
% plot(tVec,sim.robots(i).vels(:,2))
% title('Velocity vs Time')
% xlabel('Time')
% ylabel('Velocity (m/s)')
% legend('x-velocity','y-velocity')
% hold off
% 
% figure(5); clf; hold on; grid on; axis equal;
% plot(tVec,sim.robots(i).angles)
% title('angle vs Time')
% xlabel('Time (s)')
% ylabel('Angle (Rad)')
% hold off

%% Plot figures
% figure(3); clf; hold on; grid on; axis([0 totalTime,-3 5]);
% % disp(tVec(1:idx))
% % disp(numel(sim.robots(i).poses(1:idx,1)))
% plot(tVec(1:idx),sim.robots(i).poses(1:idx,1))
% plot(tVec,sim.robots(i).poses(:,2))
% title('x and y movement vs Time')
% xlabel('Time')
% ylabel('Position (m)')
% legend('x-position','y-position')
% hold off
% 
% figure(4); clf; hold on; grid on; axis([0 totalTime,-1 2]);
% plot(tVec,sim.robots(i).vels(:,1))
% plot(tVec,sim.robots(i).vels(:,2))
% title('Velocity vs Time')
% xlabel('Time')
% ylabel('Velocity (m/s)')
% legend('x-velocity','y-velocity')
% hold off
% 
% figure(5); clf; hold on; grid on; axis equal;
% plot(tVec,sim.robots(i).angles)
% title('angle vs Time')
% xlabel('Time (s)')
% ylabel('Angle (Rad)')
% hold off

% figure(6); clf; hold on; grid off; axis([0 11,0 8]); %set(gca,'visible','off');
% hold on
% sim.ball.show();
% for i = 1:sim.numRobots
%     sim.robots(i).show(1);
% end
% sim.drawpitch();    
% hold off
% saveas(figure(6),'Images\Startstate.png')


figure(7); clf; hold on; grid off; axis([0 11,0 8]); %set(gca,'visible','off');
hold on
sim.ball.show();
for i = 1:sim.numRobots
    sim.robots(i).show(idx);
end
sim.drawpitch();    
hold off
saveas(figure(7),'Images\Finalstate.png')
