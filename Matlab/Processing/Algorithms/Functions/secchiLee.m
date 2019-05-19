function [zsd] = secchiLee(kdmin,rrs)

    zsd = 1./(2.5.*kdmin).*log(abs(0.14-rrs)./0.013);

end

