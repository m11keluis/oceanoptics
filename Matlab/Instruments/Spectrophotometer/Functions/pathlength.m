function L = pathlength(volume, diameter)
    
    if nargin < 2
        diameter = 22.12; % mm
    end
    
    diameter_cm = diameter./10; % mm to cm

    % Compute Area 
    area = (pi./4).*(diameter_cm.^2); % cm^2

    % Compute Pathlength 
    L = volume/area; % cm
    
end

