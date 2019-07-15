function [N, R2, RMSD, MAPE, Bias] = valstats(derived,measured)
    
   fit = fitlm(measured,derived);
   N = fit.NumObservations;
   R2 = round(fit.Rsquared.Ordinary,2); 
   RMSD = round(sqrt(sum((derived-measured).^2)./N),2);
   MAPE = round(sum(abs((derived-measured)./measured))./N*100,2);
   Bias = round((1/N).*sum(derived-measured),2);
   
end

