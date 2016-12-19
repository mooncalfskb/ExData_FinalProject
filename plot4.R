#clear the environment if necessary
#rm(list = ls())

# Question:
# Across the United States, how have emissions 
# from coal combustion-related sources changed from 1999–2008?

# Assumptions: just use the data is. Don't try to figure out if the collecting stations were all the same.

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("/Users/mooncalf/Dropbox/skb/coursera/ExploratoryDataAnalysis/exdata_FinalData/summarySCC_PM25.rds")
SCC <- readRDS("/Users/mooncalf/Dropbox/skb/coursera/ExploratoryDataAnalysis/exdata_FinalData/Source_Classification_Code.rds")

# figure out which Sectors are coal
Coal <- grep("Coal", SCC$EI.Sector)
coalSCC <- SCC[Coal,]
# subset NEI on coal
coalNEI <- subset(NEI, SCC %in% coalSCC$SCC)

# using with and tapply from class...
# totally badass
coalTotes <- with(coalNEI, tapply(Emissions, year, sum, na.rm=TRUE))

# totes = amounts
myYears = dimnames(totes)[[1]]

dev.off(dev.list()["RStudioGD"])
dev.set(2)
dev.cur()
plot(myYears, coalTotes, pch=19, ylab = "PM2.5 Total Emissions in Tons", xlab = "Year", main="United States Coal Combustion Emissions")
lines(myYears, coalTotes) 

#write to png
dev.off(dev.list()["RStudioGD"])
png("/Users/mooncalf/Dropbox/skb/coursera/ExData_FinalProject/plot4.png", width=480, height=480)
#set up plot, make fonts smaller, x, y labels
plot(myYears, coalTotes, pch=19, ylab = "PM2.5 Total Emissions in Tons", xlab = "Year", main="United States Coal Combustion Emissions")
lines(myYears, coalTotes) 
dev.off()

