function ag = cdomCompute(l, ab, blank, null)

    % ag: CDOM absorption calculation
    % l: cuvette pathlength (default = 0.1 m)
    % ab: sample absorbance
    % blank: blank absorbance
    % null: NIR Correction
    
    if nargin < 4
        l = 0.1;
    end
        
    ag = (2.303./l).*((ab-blank)-null);
    
end