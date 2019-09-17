function [ag]=getag(g,s)
% calculate absorption of adg
% adg=G*exp(-S*(lambda-440))
global WL WN; 
   for i=1:WN
        ag(i)=g*exp(-s*(WL(i)-440));
   end
end
