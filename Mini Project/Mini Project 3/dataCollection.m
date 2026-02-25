%dataAnalysis.m
%m = mobiledev;
m.Logging = 1;
% Change times to 15 seconds as lab 2 required
pause(10);
m.Logging = 0;
[a, t] = accellog(m);
sensorData = [a, t];
save('sensorData.mat','sensorData')

load('sensorData.mat')
% Process the loaded sensor data for analysis
time = sensorData(:, 4);
accelerationX = sensorData(:, 1);
accelerationY = sensorData(:, 2);
accelerationZ = sensorData(:, 3);

%As the TA mention absoulate the value before the maximum
absX = abs(accelerationX);
absY = abs(accelerationY);
absZ = abs(accelerationZ);
accM = sqrt(accelerationX.^2 + accelerationY.^2 + accelerationZ.^2);

% Help people to check the peck
[peakX, idxX] = max(absX);
peakTimeX = time(idxX);
[peakY, idxY] = max(absY);
peakTimeY = time(idxY);
[peakZ, idxZ] = max(absZ);
peakTimeZ = time(idxZ);
[peakMag, idxMag] = max(accM);
peakTimeM = time(idxMag);

peakTimes = [peakTimeX, peakTimeY, peakTimeZ, peakTimeM];

% Plot the acceleration magnitude over time
figure;

subplot(4,1,1)
plot(time, absX);
xlabel('Time (s)');
ylabel('|Ax| (m/s^2)');
xline(peakTimeX, 'r')
text(peakTimeX + 0.1, peakX, string(peakX));
grid on;

subplot(4,1,2)
plot(time, absY);
xlabel('Time (s)');
ylabel('|Ay| (m/s^2)');
xline(peakTimeY, 'r')
text(peakTimeY + 0.1, peakY, string(peakY));
title('Y Acceleration');
grid on;


subplot(4,1,3)
plot(time, absZ);
xlabel('Time (s)');
ylabel('|Az| (m/s^2)');
xline(peakTimeZ, 'r')
text(peakTimeZ + 0.1, peakZ, string(peakZ));
title('Z Acceleration');
grid on;


subplot(4,1,4)
plot(time, accM);
xlabel('Time (s)');
ylabel('|A| (m/s^2)');
xline(peakTimeM, 'r')
text(peakTimeM + 0.1, peakMag, string(peakMag));
title('Resultant Acceleration');
grid on;


saveas(gcf,'accelerationPeak.png')
