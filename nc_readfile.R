setwd('/Users/Ryan/Desktop/Spring/EDAV/HW2/EDAV2/')
#install.packages('ncdf4')
library(ncdf4)
#useful ncdf4 reference: http://geog.uoregon.edu/GeogR/topics/netCDF-read-ncdf4.html

data <- nc_open('NOAA_Daily_phi_500mb.nc')
print(data)
#T Time: number of days since 1/1/1948 (24,873 total)
#X Longitude: degrees east in increments of 2.5 (144 total) from 0 to 360
#Y Latitude: degrees north in increments of 2.5 (15 total) from 70N to 35N (includes most of US, Canada, Europe, Russia, part of China)
#phi Geopotential height: 3d array organized by [lon,lat,t] so there are 54 million observations
# This is the height (in meters) to reach a pressure of 500mb
# Info about geopotential height
#So we have 2,160 locations within a slice of the northern hemisphere with one pressure reading per day since 1948

lon <- ncvar_get(data,"X")
lat <- ncvar_get(data,"Y")
t <- ncvar_get(data,"T")
p <- ncvar_get(data,"phi")

dimnames(p)[[1]] <- lon
dimnames(p)[[2]] <- lat
dimnames(p)[[3]] <- t

# summary(p)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 4522    5338    5529    5504    5685    6054 

#dates to make it easier
#may need to change depending on what is easiest
dates = as.Date(t, origin = "1948-01-01")
year = as.numeric(format(dates, format='%Y'))
month = as.numeric(format(dates, format='%m'))
day = as.numeric(format(dates, format='%d'))

#example: March 15p pressure readings from lat: 65, long: 65 since 2001:
window = month == 3 & day == 15 & year > 2000
cbind(year[window],p['65','65',window])
