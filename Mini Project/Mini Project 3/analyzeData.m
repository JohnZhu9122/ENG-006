clear;
clc;

%load for sensorData
load('sensorData.mat')



%Calculate for each acceleration
aX = sensorData(:, 1);
aY = sensorData(:, 2);
aZ = sensorData(:, 3);
aT = sensorData(:, 4);
accM = sqrt(aX.^2 + aY.^2 + aZ.^2);


threshold = 10;

%Using material formula in the lab
[ts, A, avgA] = detectRapidAcceleration( sensorData, threshold );

%Make the plot 
figure;
hold on;


%Plot the main accelerate
plot_main = plot(aT,accM,'b-','LineWidth',1.5);

for i = 1:length(ts)
    xline(ts(i), 'r-', 'LineWidth', 1, 'Alpha', 0.7);
end

%Plot the horizontal line
plot_hor = yline(threshold,'r--','LineWidth',1.5);

%label the units in x and y-axis
xlabel('Time(s)');
ylabel('Resultant Accerelration');
title('Rapid Acceleration')
grid on;


hold off;