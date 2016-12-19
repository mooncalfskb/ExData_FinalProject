#clear the environment if necessary
#rm(list = ls())

# Question:
#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("/Users/mooncalf/Dropbox/skb/coursera/ExploratoryDataAnalysis/exdata_FinalData/summarySCC_PM25.rds")
SCC <- readRDS("/Users/mooncalf/Dropbox/skb/coursera/ExploratoryDataAnalysis/exdata_FinalData/Source_Classification_Code.rds")

# figure out which Sectors are coal
Motor <- grep("On-Road", SCC$EI.Sector)
motorSCC <- SCC[Motor,]
# subset NEI on coal
motorNEI <- subset(NEI, fips==24510 & SCC %in% motorSCC$SCC)

# using with and tapply from class...
# totally badass
motorTotes <- with(motorNEI, tapply(Emissions, year, sum, na.rm=TRUE))

# totes = amounts
myYears = dimnames(totes)[[1]]

dev.off(dev.list()["RStudioGD"])
dev.set(2)
dev.cur()
plot(myYears, motorTotes, pch=19, ylab = "PM2.5 Total Emissions in Tons", xlab = "Year", main="Baltimore Motor Vehicle Emissions")
lines(myYears, motorTotes) 

#write to png
dev.off(dev.list()["RStudioGD"])
png("/Users/mooncalf/Dropbox/skb/coursera/ExData_FinalProject/plot5.png", width=480, height=480)
#set up plot, make fonts smaller, x, y labels
plot(myYears, motorTotes, pch=19, ylab = "PM2.5 Total Emissions in Tons", xlab = "Year", main="Baltimore Motor Vehicle Emissions")
lines(myYears, motorTotes) 
dev.off()

