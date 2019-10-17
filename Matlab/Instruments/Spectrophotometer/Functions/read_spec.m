function [wl, blank_p, blank_g, ap, anap, ag]  = read_spec(filename)
    
    % Blank
    blank_p = readtable(filename,'Sheet','blank_p');
    blank_g = readtable(filename,'Sheet','blank_g');
    
    ap = readtable(filename, 'Sheet', 'ap');
    
    % anap
    anap = readtable(filename, 'Sheet', 'anap');
    
    % ag
    ag = readtable(filename, 'Sheet', 'ag');
    
    % wl 
    wl = readtable(filename, 'Sheet', 'wl');

end

    
