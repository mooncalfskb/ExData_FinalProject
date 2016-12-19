#clear the environment if necessary
#rm(list = ls())

# Question:
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (𝚏𝚒𝚙𝚜 == "𝟸𝟺𝟻𝟷𝟶") from 1999 to 2008? Use the base plotting system to make a plot answering this question

# Assumptions: just use the data is. Don't try to figure out if the collecting stations were all the same.

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("/Users/mooncalf/Dropbox/skb/coursera/ExploratoryDataAnalysis/exdata_FinalData/summarySCC_PM25.rds")
SCC <- readRDS("/Users/mooncalf/Dropbox/skb/coursera/ExploratoryDataAnalysis/exdata_FinalData/Source_Classification_Code.rds")

#example subset from class
# > pm0sub <- subset(cnt0, County.Code == 63 & Site.ID == 2008)

#remember to use ==
# test values like this
baltNEI <- subset(NEI, fips==24510)

# using with and tapply from class...
# totally badass
totes <- with(baltNEI, tapply(Emissions, year, sum, na.rm=TRUE))
myYears = dimnames(totes)[[1]]

dev.off(dev.list()["RStudioGD"])
dev.set(2)
dev.cur()
plot(myYears, totes, pch=19, ylab = "Total Emissions in Tons", xlab = "Year", main="Baltimore City, Maryland")
lines(myYears, totes) 

#write to png
dev.off(dev.list()["RStudioGD"])
png("/Users/mooncalf/Dropbox/skb/coursera/ExData_FinalProject/plot2.png", width=480, height=480)
#set up plot, make fonts smaller, x, y labels
plot(myYears, totes, pch=19, ylab = "Total Emissions in Tons", xlab = "Year", main="Baltimore City, Maryland")
lines(myYears, totes) 
dev.off()

