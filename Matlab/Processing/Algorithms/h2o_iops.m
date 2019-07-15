function out = h2o_iops(lambda, str1)
% Hydrolight (v5) used these a & b for pure water

abw = ...
[200	3.07E+00	1.51E-01	;	...
205	2.48E+00	1.36E-01	;	...
210	1.99E+00	1.23E-01	;	...
215	1.61E+00	1.11E-01	;	...
220	1.31E+00	1.00E-01	;	...
225	1.09E+00	9.10E-02	;	...
230	9.27E-01	8.28E-02	;	...
235	8.12E-01	7.54E-02	;	...
240	7.20E-01	6.89E-02	;	...
245	6.34E-01	6.30E-02	;	...
250	5.59E-01	5.77E-02	;	...
255	5.03E-01	5.30E-02	;	...
260	4.57E-01	4.87E-02	;	...
265	4.15E-01	4.49E-02	;	...
270	3.73E-01	4.14E-02	;	...
275	3.30E-01	3.83E-02	;	...
280	2.88E-01	3.54E-02	;	...
285	2.51E-01	3.28E-02	;	...
290	2.15E-01	3.04E-02	;	...
295	1.76E-01	2.82E-02	;	...
300	1.41E-01	2.63E-02	;	...
305	1.16E-01	2.45E-02	;	...
310	9.90E-02	2.28E-02	;	...
315	8.52E-02	2.13E-02	;	...
320	7.30E-02	1.99E-02	;	...
325	6.11E-02	1.86E-02	;	...
330	5.00E-02	1.74E-02	;	...
335	4.06E-02	1.63E-02	;	...
340	3.25E-02	1.53E-02	;	...
345	2.56E-02	1.44E-02	;	...
350	2.04E-02	1.35E-02	;	...
355	1.76E-02	1.27E-02	;	...
360	1.56E-02	1.19E-02	;	...
365	1.32E-02	1.13E-02	;	...
370	1.14E-02	1.06E-02	;	...
375	1.15E-02	1.00E-02	;	...
380	1.14E-02	9.46E-03	;	...
385	9.41E-03	8.94E-03	;	...
390	8.51E-03	8.46E-03	;	...
395	8.13E-03	8.00E-03	;	...
400	6.63E-03	7.58E-03	;	...
405	5.30E-03	7.18E-03	;	...
410	4.73E-03	6.81E-03	;	...
415	4.44E-03	6.47E-03	;	...
420	4.54E-03	6.14E-03	;	...
425	4.78E-03	5.83E-03	;	...
430	4.95E-03	5.55E-03	;	...
435	5.30E-03	5.28E-03	;	...
440	6.35E-03	5.02E-03	;	...
445	7.51E-03	4.78E-03	;	...
450	9.22E-03	4.56E-03	;	...
455	9.62E-03	4.34E-03	;	...
460	9.79E-03	4.14E-03	;	...
465	1.01E-02	3.96E-03	;	...
470	1.06E-02	3.78E-03	;	...
475	1.14E-02	3.61E-03	;	...
480	1.27E-02	3.45E-03	;	...
485	1.36E-02	3.30E-03	;	...
490	1.50E-02	3.15E-03	;	...
495	1.73E-02	3.02E-03	;	...
500	2.04E-02	2.89E-03	;	...
505	2.56E-02	2.77E-03	;	...
510	3.25E-02	2.65E-03	;	...
515	3.96E-02	2.54E-03	;	...
520	4.09E-02	2.44E-03	;	...
525	4.17E-02	2.34E-03	;	...
530	4.34E-02	2.25E-03	;	...
535	4.52E-02	2.16E-03	;	...
540	4.74E-02	2.07E-03	;	...
545	5.11E-02	1.99E-03	;	...
550	5.65E-02	1.92E-03	;	...
555	5.96E-02	1.84E-03	;	...
560	6.19E-02	1.77E-03	;	...
565	6.42E-02	1.71E-03	;	...
570	6.95E-02	1.64E-03	;	...
575	7.72E-02	1.58E-03	;	...
580	8.96E-02	1.52E-03	;	...
585	1.10E-01	1.47E-03	;	...
590	1.35E-01	1.41E-03	;	...
595	1.67E-01	1.36E-03	;	...
600	2.22E-01	1.32E-03	;	...
605	2.58E-01	1.27E-03	;	...
610	2.64E-01	1.22E-03	;	...
615	2.68E-01	1.18E-03	;	...
620	2.76E-01	1.14E-03	;	...
625	2.83E-01	1.10E-03	;	...
630	2.92E-01	1.07E-03	;	...
635	3.01E-01	1.03E-03	;	...
640	3.18E-01	9.95E-04	;	...
645	3.25E-01	9.62E-04	;	...
650	3.40E-01	9.31E-04	;	...
655	3.71E-01	9.00E-04	;	...
660	4.10E-01	8.71E-04	;	...
665	4.29E-01	8.43E-04	;	...
670	4.39E-01	8.16E-04	;	...
675	4.48E-01	7.91E-04	;	...
680	4.65E-01	7.66E-04	;	...
685	4.86E-01	7.42E-04	;	...
690	5.16E-01	7.19E-04	;	...
695	5.59E-01	6.97E-04	;	...
700	6.24E-01	6.76E-04	;	...
705	7.04E-01	6.55E-04	;	...
710	8.27E-01	6.36E-04	;	...
715	1.01E+00	6.17E-04	;	...
720	1.23E+00	5.98E-04	;	...
725	1.49E+00	5.81E-04	;	...
730	1.80E+00	5.64E-04	;	...
735	2.13E+00	5.47E-04	;	...
740	2.38E+00	5.31E-04	;	...
745	2.46E+00	5.16E-04	;	...
750	2.47E+00	5.02E-04	;	...
755	2.51E+00	4.87E-04	;	...
760	2.55E+00	4.74E-04	;	...
765	2.55E+00	4.60E-04	;	...
770	2.51E+00	4.48E-04	;	...
775	2.45E+00	4.35E-04	;	...
780	2.36E+00	4.23E-04	;	...
785	2.25E+00	4.12E-04	;	...
790	2.16E+00	4.01E-04	;	...
795	2.10E+00	3.90E-04	;	...
800	2.07E+00	3.80E-04	;	...
805	2.05E+00	3.69E-04	;	...
810	2.09E+00	3.60E-04	;	...
815	2.25E+00	3.50E-04	;	...
820	2.47E+00	3.41E-04	;	...
825	2.82E+00	3.32E-04	;	...
830	3.10E+00	3.24E-04	;	...
835	3.34E+00	3.15E-04	;	...
840	3.71E+00	3.07E-04	;	...
845	3.98E+00	3.00E-04	;	...
850	4.38E+00	2.92E-04	;	...
855	4.63E+00	2.85E-04	;	...
860	4.94E+00	2.78E-04	;	...
865	5.15E+00	2.71E-04	;	...
870	5.37E+00	2.64E-04	;	...
875	5.61E+00	2.58E-04	;	...
880	5.83E+00	2.51E-04	;	...
885	6.01E+00	2.45E-04	;	...
890	6.26E+00	2.39E-04	;	...
895	6.47E+00	2.34E-04	;	...
900	6.82E+00	2.28E-04	;	...
905	7.10E+00	2.23E-04	;	...
910	7.90E+00	2.18E-04	;	...
915	9.48E+00	2.12E-04	;	...
920	1.12E+01	2.07E-04	;	...
925	1.47E+01	2.03E-04	;	...
930	1.93E+01	1.98E-04	;	...
935	2.34E+01	1.93E-04	;	...
940	2.93E+01	1.89E-04	;	...
945	3.47E+01	1.85E-04	;	...
950	3.83E+01	1.81E-04	;	...
955	4.20E+01	1.77E-04	;	...
960	4.41E+01	1.73E-04	;	...
965	4.49E+01	1.69E-04	;	...
970	4.53E+01	1.65E-04	;	...
975	4.49E+01	1.61E-04	;	...
980	4.37E+01	1.58E-04	;	...
985	4.24E+01	1.55E-04	;	...
990	4.14E+01	1.51E-04	;	...
995	3.97E+01	1.48E-04	;	...
1000	3.77E+01	1.45E-04	;	...
1005	3.54E+01	1.42E-04	;	...
1010	3.32E+01	1.39E-04	;	...
1015	3.12E+01	1.36E-04	;	...
1020	2.93E+01	1.33E-04	;	...
1025	2.69E+01	1.30E-04	;	...
1030	2.46E+01	1.27E-04	;	...
1035	2.24E+01	1.25E-04	;	...
1040	2.04E+01	1.22E-04	;	...
1045	1.85E+01	1.20E-04	;	...
1050	1.69E+01	1.17E-04	;	...
1055	1.61E+01	1.15E-04	;	...
1060	1.54E+01	1.13E-04	;	...
1065	1.50E+01	1.10E-04	;	...
1070	1.49E+01	1.08E-04	;	...
1075	1.52E+01	1.06E-04	;	...
1080	1.57E+01	1.04E-04	;	...
1085	1.66E+01	1.02E-04	;	...
1090	1.75E+01	9.97E-05	;	...
1095	1.86E+01	9.78E-05	;	...
1100	1.99E+01	9.59E-05	;	...
1105	2.16E+01	9.40E-05	;	...
1110	2.35E+01	9.22E-05	;	...
1115	2.66E+01	9.04E-05	;	...
1120	3.02E+01	8.87E-05	;	...
1125	3.62E+01	8.70E-05	;	...
1130	4.34E+01	8.54E-05	;	...
1135	5.32E+01	8.38E-05	;	...
1140	6.51E+01	8.22E-05	;	...
1145	8.00E+01	8.06E-05	;	...
1150	9.83E+01	7.91E-05		];



% %%% water absorption --- Pope and Fry (1997); 
% %%% water backscattering ---- Zhang et al(2009);
% 
% abw = [...
% 350	2.04E-02	1.12152E+16	;	...
% 355	1.76E-02	2.12225E+16	;	...
% 360	1.56E-02	3.57365E+16	;	...
% 365	1.32E-02	7.35412E+16	;	...
% 370	1.14E-02	1.38542E+17	;	...
% 375	1.15E-02	1.33412E+17	;	...
% 380	1.14E-02	1.38542E+17	;	...
% 385	9.41E-03	3.17324E+17	;	...
% 390	8.51E-03	4.89908E+17	;	...
% 395	8.13E-03	5.96787E+17	;	...
% 400	6.63E-03	1.44036E+18	;	...
% 405	5.30E-03	3.78912E+18	;	...
% 410	4.73E-03	6.19456E+18	;	...
% 415	4.44E-03	8.14171E+18	;	...
% 420	4.54E-03	7.39484E+18	;	...
% 425	4.78E-03	5.91946E+18	;	...
% 430	4.95E-03	5.08998E+18	;	...
% 435	5.30E-03	3.78912E+18	;	...
% 440	6.35E-03	1.73551E+18	;	...
% 445	7.51E-03	8.40709E+17	;	...
% 450	9.22E-03	3.46555E+17	;	...
% 455	9.62E-03	2.88466E+17	;	...
% 460	9.79E-03	2.67442E+17	;	...
% 465	1.01E-02	2.33745E+17	;	...
% 470	1.06E-02	1.89709E+17	;	...
% 475	1.14E-02	1.38542E+17	;	...
% 480	1.27E-02	8.68917E+16	;	...
% 485	1.36E-02	6.46431E+16	;	...
% 490	1.50E-02	4.23347E+16	;	...
% 495	1.73E-02	2.28587E+16	;	...
% 500	2.04E-02	1.12152E+16	;	...
% 505	2.56E-02	4.20546E+15	;	...
% 510	3.25E-02	1.49994E+15	;	...
% 515	3.96E-02	6.38803E+14	;	...
% 520	4.09E-02	5.55604E+14	;	...
% 525	4.17E-02	5.11002E+14	;	...
% 530	4.34E-02	4.29986E+14	;	...
% 535	4.52E-02	3.60755E+14	;	...
% 540	4.74E-02	2.93797E+14	;	...
% 545	5.11E-02	2.1234E+14	;	...
% 550	5.65E-02	1.37582E+14	;	...
% 555	5.96E-02	1.09231E+14	;	...
% 560	6.19E-02	9.27485E+13	;	...
% 565	6.42E-02	7.92244E+13	;	...
% 570	6.95E-02	5.62388E+13	;	...
% 575	7.72E-02	3.57193E+13	;	...
% 580	8.96E-02	1.87689E+13	;	...
% 585	1.10E-01	7.73738E+12	;	...
% 590	1.35E-01	3.19425E+12	;	...
% 595	1.67E-01	1.27431E+12	;	...
% 600	2.22E-01	3.72534E+11	;	...
% 605	2.58E-01	1.94632E+11	;	...
% 610	2.64E-01	1.76231E+11	;	...
% 615	2.68E-01	1.65146E+11	;	...
% 620	2.76E-01	1.4544E+11	;	...
% 625	2.83E-01	1.30525E+11	;	...
% 630	2.92E-01	1.14014E+11	;	...
% 635	3.01E-01	1.00001E+11	;	...
% 640	3.18E-01	78872412355	;	...
% 645	3.25E-01	71791687714	;	...
% 650	3.40E-01	59077398250	;	...
% 655	3.71E-01	40524250656	;	...
% 660	4.10E-01	26313827385	;	...
% 665	4.29E-01	21636887164	;	...
% 670	4.39E-01	19586802988	;	...
% 675	4.48E-01	17942760575	;	...
% 680	4.65E-01	15276136347	;	...
% 685	4.86E-01	12622390134	;	...
% 690	5.16E-01	9744590009	;	...
% 695	5.59E-01	6895905040	;	...
% 700	6.24E-01	4287586107	;	...
% 705	7.04E-01	2546222755	;	...
% 710	8.27E-01	1269949587	;	...
% 715	1.01E+00	535478388.5	;	...
% 720	1.23E+00	228570512	;	...
% 725	1.49E+00	99826444.44	;	...
% 730	1.80E+00	44119751.78	;	...
% 735	2.13E+00	21321138.71	;	...
% 740	2.38E+00	13200726.34	;	...
% 745	2.46E+00	11443809.5	;	...
% 750	2.47E+00	11244999.6	;	...
% 755	2.51E+00	10491070.5	;	...
% 760	2.55E+00	9798434.707	;	...
% 765	2.55E+00	9798434.707	;	...
% 770	2.51E+00	10491070.5	;	...
% 775	2.45E+00	11646965.74	;	...
% 780	2.36E+00	13690850.55	;	...
% 785	2.25E+00	16826035.63	;	...
% 790	2.16E+00	20071049.29	;	...
% 795	2.10E+00	22668507.62	;	...
% 800	2.07E+00	24122281.99	];




tot = length(lambda);

a = []; b = [];

% for i = 1 : tot
    a  = interp1(abw(:,1), abw(:,2), lambda, 'spline');
    b  = interp1(abw(:,1), abw(:,3), lambda, 'spline');
% end

if strcmp(str1,'a')
    out = a;
elseif strcmp(str1,'b')
    out = b;
elseif strcmp(str1,'bb')
    out = 0.5 * b;
else
    out = [a; b];
end

end


