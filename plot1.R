#clear the environment if necessary
#rm(list = ls())

# Question:
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008.

# Assumptions: just use the data is. Don't try to figure out if the collecting stations were all the same.

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("/Users/mooncalf/Dropbox/skb/coursera/ExploratoryDataAnalysis/exdata_FinalData/summarySCC_PM25.rds")
SCC <- readRDS("/Users/mooncalf/Dropbox/skb/coursera/ExploratoryDataAnalysis/exdata_FinalData/Source_Classification_Code.rds")

# using with and tapply from class...
# totally badass
totes <- with(NEI, tapply(Emissions, year, sum, na.rm=TRUE))

# totes = amounts
myYears = dimnames(totes)[[1]]

dev.off(dev.list()["RStudioGD"])
dev.set(2)
dev.cur()
plot(myYears, totes, pch=19, ylab = "Total Emissions in Tons", xlab = "Year", main="PM2.5 Emissions in the United States")
lines(myYears, totes) 

#write to png
dev.off(dev.list()["RStudioGD"])
png("/Users/mooncalf/Dropbox/skb/coursera/ExData_FinalProject/plot1.png", width=480, height=480)
#set up plot, make fonts smaller, x, y labels
plot(myYears, totes, pch=19, ylab = "Total Emissions in Tons", xlab = "Year", main="PM2.5 Emissions in the United States")
lines(myYears, totes) 
dev.off()

