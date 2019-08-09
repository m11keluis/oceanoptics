function ap = particleCompute(od, l)

% ab = particle absorbance on filter pad
% blank = blank absorbance
% null = NIR correction
% A = area of filter 
% V = volume filtered

% Beta correction
b = 0.679 .* exp(1.248 .* log(od));

ap = (2.303./l).*b;

end

