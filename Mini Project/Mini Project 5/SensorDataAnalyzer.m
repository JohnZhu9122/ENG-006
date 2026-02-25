
classdef SensorDataAnalyzer < handle
    %sensorDataAnalyzer class for deadmanning acceleration signals to
    %velocity and position signal
    %Initial values are always started at 0
    % Public properties (mutable)
    properties 
        TargetSignal; % Acceleration signal
        TargetSignalTs; % Signal time stamp
        OriginalSignal; 
        OriginalSignalTs;
    end

    % Private properties (immutable)
    properties(Access=private)
        mobileDevConnection;
    end

    % Callable methods
    methods
        
        % Class constructor
        
        function obj = SensorDataAnalyzer()
            obj.mobileDevConnection = mobiledev();
           
            %Obj is the class constructor
            % Fill in this constructor method to initialize the
            % mobileDevConnection and assign it to the private
            % mobileDevConneciton attribute
            if obj.mobileDevConnection.Connected
                fprintf('Connected to device.\n');
            else
                fprintf('Failed to connect to any mobile device.\n');
            % Initializes the mobileDevConnection
            % Optional: Notify the user of a successful connection and the
            % name of the connected device
            
            end
        end
        
        % Data logger function
        
        function logSensorData(obj, timeSeconds, delaySeconds)
            
            % Fill in this method so that, when called, it logs sensor data
            fprintf('Started logging in seconds %d seconds ...\n',delaySeconds)
            pause(delaySeconds)

            % for "timeSeconds" after a delay of "delaySeconds"
            % It should notify the user of the delay time and when sensor
            % logging begins and ends.
            fprintf('Logging sensor data for %d seconds...\n', timeSeconds);
            obj.mobileDevConnection.Logging = 1;
            pause(timeSeconds);
            obj.mobileDevConnection.Logging = 0;
            fprintf('Data collection completed.\n');
        end

        % Set the target signal

        function setTargetSignal(obj, signalName)
            
            % Fill in this setTargetSignal method to do the following:
            % Extract the sensor data and time stamp from the mobile device
            [accelData,timeStamps] = accellog(obj.mobileDevConnection);
            if isempty(accelData)
                error('No sensor data. Please run LogSensorData.')
            end
            % acceleration log
            % Use conditional logic to detect the desired TargetSignal names:
            switch signalName    
                case 'X-Accel'
                    obj.TargetSignal = accelData(:, 1);
                case 'Y-Accel'
                    obj.TargetSignal = accelData(:, 2);
                case 'Z-Accel'
                    obj.TargetSignal = accelData(:, 3);
                case 'R-Accel'
                    obj.TargetSignal   = sqrt(sum(accelData.^2,2));
                otherwise
                    error('Invalid signal name. Please use "X-Accel", "Y-Accel", "Z-Accel", or "R-Accel".');
            end
            % "X-Accel", "Y-Accel", "Z-Accel", "R-Accel"
            % Throw an error if none of these strings are passed
            obj.TargetSignalTs = timeStamps;
            obj.OriginalSignal = obj.TargetSignal;
            obj.OriginalSignalTs = obj.TargetSignalTs;
        
        end

        function [signal, Ts] = getTargetSignal(obj)
            
            if isempty(obj.TargetSignal)
                error('No TargetSignal is set.');
            end
            
            % Extract the traget signal and time stamp from the properties
            signal = obj.TargetSignal;
            Ts = obj.TargetSignalTs;
            % and return it here.
        end
       
        % Signal smoothing using colvolution with a rectangular kernel.
        % This has been implemented for you.

        function smooth(obj, windowSize)
            if isempty(obj.TargetSignal)
                error('Set target signal before smoothing.');
            end

            filter = (1/windowSize)*ones(1, windowSize);
            obj.TargetSignal = conv(obj.TargetSignal, filter, 'same');
            
        
        end

        % Plotting method of target signal

        function plotTargetSignal(obj, ax, titleStr)
            % Plot the target signal with the title string here
            if isempty(obj.TargetSignal)
                error('No TargetSignal found.')
            end

            plot(ax,obj.TargetSignalTs,obj.TargetSignal)

            xlabel(ax,"Timestamp")
            ylabel(ax,"Signal Amplitude")

            title(ax,titleStr)
     
            % Throw an error if there is no TargetSignal to plot
        end

        % Integrator function

        function integrate(obj)
           % Implement your integration method here
           if isempty(obj.TargetSignal)
               error("No TargetSignal for integration");
           end

           if isempty(obj.TargetSignalTs)
               error("No TargetSignalTs");
           end
           t = obj.TargetSignalTs;
           x = obj.TargetSignal;
           y = cumtrapz(t,x);
           obj.TargetSignal = y;
           % Over-write the target signal with the integrated signal
        end

        function resetTargetSignal(obj)
            if ~isempty(obj.OriginalSignal)
                obj.TargetSignal = obj.OriginalSignal;
                obj.TargetSignalTs = obj.OriginalSignalTs;
            else
                error('No signal to reset')
            end

        end
    end
end