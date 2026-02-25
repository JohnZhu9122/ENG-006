% This script assumes you have assigned your mobiledev connection to a
% variable called m

[a, ts] = accellog(m);

figure;

subplot(3,1,1);
plot(ts, a(:,1));
ylabel('A(X) (m/s^2)');
xlabel('Time (s)');
title('X-axis Acceleration');

subplot(3,1,2);
plot(ts, a(:,2));
ylabel('A(Y) (m/s^2)');
xlabel('Time (s)');
title('Y-axis Acceleration');

subplot(3,1,3);
plot(ts, a(:,3));
ylabel('A(Z) (m/s^2)');
xlabel('Time (s)');
title('Z-axis Acceleration');

% Save the figure as a PNG
saveas(gcf, 'accelerometerReadings.png');