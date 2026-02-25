function [ts, A, avgA] = detectRapidAcceleration( sensorData, threshold )
%   Detailed explanation goes here
    AX = sensorData(:, 1);
    AY = sensorData(:, 2);
    AZ = sensorData(:, 3);
    TT = sensorData(:, 4);



    accM = sqrt(AX.^2 + AY.^2 + AZ.^2);

    C = find (accM > threshold);

    ts = TT(C); % Extract timestamps corresponding to rapid acceleration events
    A = accM(C);  % Get the acceleration values that exceed the threshold

    if numel(A) == 0
        avgA = 0.0;
    else
        avgA = mean(A);
    end

end

