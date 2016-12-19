#clear the environment if necessary
#rm(list = ls())

# Question:
#Compare emissions from motor vehicle sources in Baltimore City 
#with emissions from motor vehicle sources in Los Angeles County, California 
#(𝚏𝚒𝚙𝚜 == "𝟶𝟼𝟶𝟹𝟽"). Which city has seen greater changes o
#ver time in motor vehicle emissions?

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("/Users/mooncalf/Dropbox/skb/coursera/ExploratoryDataAnalysis/exdata_FinalData/summarySCC_PM25.rds")
SCC <- readRDS("/Users/mooncalf/Dropbox/skb/coursera/ExploratoryDataAnalysis/exdata_FinalData/Source_Classification_Code.rds")

# figure out which Sectors are coal
Motor <- grep("On-Road", SCC$EI.Sector)
motorSCC <- SCC[Motor,]
# subset NEI on coal
baltMotorNEI <- subset(NEI, fips=="24510" & SCC %in% motorSCC$SCC)
laMotorNEI <- subset(NEI, fips=="06037" & SCC %in% motorSCC$SCC)

# using with and tapply from class...
# totally badass
baltTotes <- with(baltMotorNEI, tapply(Emissions, year, sum, na.rm=TRUE))
laTotes <- with(laMotorNEI, tapply(Emissions, year, sum, na.rm=TRUE))

# totes = amounts
myYears = dimnames(baltTotes)[[1]]
df3 = data.frame("Year"=character(8),"City"=character(8),"Emissions"=numeric(8),stringsAsFactors=FALSE)
df3[1:4,"Year"] = as.character(myYears)
df3[1:4,"City"] = "Baltimore"
df3[1:4,"Emissions"] = baltTotes
df3[5:8,"Year"] = as.character(myYears)
df3[5:8,"City"] = "Los Angeles"
df3[5:8,"Emissions"] = laTotes


## ggplot panels
# Line walmTemp<-lm(Emissions~Year, data=df3)
# Line was difficult to figure out. aes important.
plot(data=df3, aes(x=Year, y=Emissions, color=factor(City))) + geom_point() + geom_line(aes(color=City, group=City)) + facet_wrap(~City, nrow=1) + scale_color_brewer(name="City",palette="Set1") + labs(x="Year", y="PM2.5 Emissions in Tons", title="Emissions by City") 
print(sp2)
ggsave("/Users/mooncalf/Dropbox/skb/coursera/ExData_FinalProject/plot6.png")

#+ stat_smooth(aes(group=City) 

la_drop = sum(df3$Emissions[7] - df3$Emissions[8])
#la_drop = 500.0939
#la_increase: -170.201
balt_drop =  sum(df3$Emissions[1] - df3$Emissions[4])
# balt_drop = 258.5445