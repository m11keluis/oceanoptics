Notes of using the software to process spectral evolution data
from Radiance measurements to Remote Sensing Reflectance (Rrs).

Nick Tufillaro and Ivan Lalovic 
(includes spectralon plaque calibration file 'refcal' input and 
plot of extrema)

For measurement protocols see:  C. Davis ...

Data Folder:  
All the measurements and process data for a typical station
meaurement should sit in a Folder with a name like:

    sev_2016_05_19_S03
	
the general folder name is

    sev_YYYY_MM_DD_SNN
	
where sev stands for "Spectral EVolution" and 
SNN is Station Number Number. 

Inside this folder there will typically be 30
spectral evolution data files with names such as:

    sev_2016_05_19_M0060.sed
	
The first 3 letters should reference the instrument
or station (eg sfb instead of sev) followed by

    _YY_MM_DD_MNNNN.sed
	
The suffix MNNNN.sed is added by the spectral 
evolution softare to indicate the measurement
number and file type (.sed).

The processing software generally expects the
the file and folder names to follow this convention
and folder/file name lengths.

Typically there will be '30' *.sed measurement
files. The first 10 are typically the white
Reference plaque, followed by 10 measuremnts of
the water, then 10 of the sky. The order is helpful
but not essential. The software uses 'clustering'
to identify the meaurement type.

    1  Water     (lower values of radiance)
    2  Sky       (medium values of radiance)
	3  Reference (high values of radiance)
	
If the folder is 'missing' a type of measurement
(eg. Sky) then the user can add a surrogate 
measurement file from another station. Otherwise,
the processing software will probably create miss
identity, say, Sky measurements as Reference 
measurements in an attempt to create 3 clusters
of spectral data. 

To see the identifed measurement type see the 
file:

  d_processing_parameters.txt
  
which shows, for example,

    Processed Files 
    (1 Water; 2 Sky; 3 Reference; Neg - Not Used) 
    NAME                       TYPE 
    sev_2016_05_19__M0069.sed  3
    sev_2016_05_19__M0071.sed  1
    sev_2016_05_19__M0076.sed  1
    sev_2016_05_19__M0077.sed -1
    sev_2016_05_19__M0078.sed  1
    sev_2016_05_19__M0080.sed -2
    sev_2016_05_19__M0081.sed  2
    sev_2016_05_19__M0082.sed  2
	
a 'negative' number means the spectra was
identified but not used (because
it lies outside a preset limit sigma, typicall
on standard deviation from the median spectrum).

Additionally you should find files such as:

   p_shr.jpg
   p_sky.jpg
   p_wat.jpg
 
which are pictures of the station 
SHouRE, SKY, and WATer respectively.

One file,

  c_settings.txt
  
MUST BE CREATED for the 'rrs' processing
software to operate. It consists of
a array of 15 numbers, one per line, such
as

   2016
   5
   19
   16
   56
   0
   38.4351
   -121.5235
   0
   0
   2
   1.5
   1
   3
   0
   1
   
This provides 'meta data' and processing parameters
for the station data set, namely,

   2016		    Year
   5			Month
   19			Day
   16			Hour (UTC)
   56			Minute
   0			Second
   38.4351		Latitude  (Digital North)
   -121.5235	Longitude (Digital East)
   0			Altitude (km)
   0			Wind Speed (m/s)
   2 			Sigma Water
   1.5 		    Sigma Sky
   1			Sigma Reference
   3			Plot Scale (0 Fixed-30; 1 Water Max; 2 Sky Max; 3 Reference Max)
   0			Plaque Reflectance (0 = constant 99%, 1 = use 'c_refcal/refcal.cal' file)
   1			Baseline Removal (0 = none, 1 = min[750-800], 2=mean[750-850], 3=other/TBD)
   
The c_settings file should be a 'plain' text file and can be created with
a text editor such as notepad ++ on Microsoft Windos, or text wranger on 
Apple OS X. File with the prefix 'd_*.txt/, and 'f_*.png) are 
are created by the processing software and contain data and
and figures.




   

  
  