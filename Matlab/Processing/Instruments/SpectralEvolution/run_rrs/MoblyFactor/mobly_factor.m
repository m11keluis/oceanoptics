function [ mf ] = mobly_factor(wind_speed, solar_zenith)
addpath('MoblyFactor');
% Mobly Factor for 40, 90. Column 4 is data for 40 135.
load mobly_table.mat
X = mobly_table(:,1); Y = mobly_table(:,2); V = mobly_table(:,3);
for ccnt = 1:9
     ws(1:5,ccnt) = [0 2 4 6 8];
end
for rcnt = 1:5
     sz(rcnt,1:9) = [0 10 20 30 40 50 60 70 80]';
end
mt = zeros(5, 9);
for rcnt = 1:5
   mt(rcnt,:) = V( ((rcnt-1)*9+1): ...
                   ((rcnt)  *9  ));
end
mf = interp2(sz,ws,mt,solar_zenith,wind_speed);
if((wind_speed > 8) || (wind_speed < 0))
    mf = -1; % Wind Speed Out of Range
    disp(' ')
    disp('% WARNING: Wind Speed Out of Range')
end
if((solar_zenith > 80) || (solar_zenith < 0))
    mf = -2; % Solar Zenith Out of Range
    disp(' ')
    disp('% WARNING:  Solar Zenith Out of Range')
end
end