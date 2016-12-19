#clear the environment if necessary
#rm(list = ls())
library("ggplot2")


# Question
# Of the four types of sources indicated by the 𝚝𝚢𝚙𝚎 (point, nonpoint, onroad, nonroad) variab
# le, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question

# Assumptions: just use the data is. Don't try to figure out if the collecting stations were all the same.

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("/Users/mooncalf/Dropbox/skb/coursera/ExploratoryDataAnalysis/exdata_FinalData/summarySCC_PM25.rds")
SCC <- readRDS("/Users/mooncalf/Dropbox/skb/coursera/ExploratoryDataAnalysis/exdata_FinalData/Source_Classification_Code.rds")

#example subset from class
# > pm0sub <- subset(cnt0, County.Code == 63 & Site.ID == 2008)

# > table(NEI$type)
# NON-ROAD NONPOINT  ON-ROAD    POINT 
# 2324262   473759  3183599   516031 

pointBaltNEI <- subset(NEI, fips==24510 & type=="POINT")
nonpointBaltNEI <- subset(NEI, fips==24510 & type=="NONPOINT")
onroadBaltNEI <- subset(NEI, fips==24510 & type=="ON-ROAD")
nonroadBaltNEI <- subset(NEI, fips==24510 & type=="NON-ROAD")

# using with and tapply from class...
# totally badass
pointTotes <- with(pointBaltNEI, tapply(Emissions, year, sum, na.rm=TRUE))
nonpointTotes <- with(nonpointBaltNEI, tapply(Emissions, year, sum, na.rm=TRUE))
onroadTotes <- with(onroadBaltNEI, tapply(Emissions, year, sum, na.rm=TRUE))
nonroadTotes <- with(nonroadBaltNEI, tapply(Emissions, year, sum, na.rm=TRUE))
myYears = dimnames(pointTotes)[[1]]

#set up dataframe for ggplot
# this was wrong dataframe
# df = data.frame("POINT"=numeric(4),"NON.POINT"=numeric(4),"ON.ROAD"=numeric(4),"NON.ROAD"=numeric(4))
# df[1:4,"POINT"] = pointTotes
# df[1:4,"NON.POINT"] = nonpointTotes
# df[1:4,"ON.ROAD"] = onroadTotes
# df[1:4,"NON.ROAD"] = nonroadTotes
# rownames(df) <- myYears
# df

df2 = data.frame("Year"=character(16),"Type"=character(16),"Emissions"=numeric(16),stringsAsFactors=FALSE)
df2[1:4,"Year"] = as.character(myYears)
df2[1:4,"Type"] = "POINT"
df2[1:4,"Emissions"] = pointTotes
df2[5:8,"Year"] = as.character(myYears)
df2[5:8,"Type"] = "NON-POINT"
df2[5:8,"Emissions"] = nonpointTotes
df2[9:12,"Year"] = as.character(myYears)
df2[9:12,"Type"] = "ON-ROAD"
df2[9:12,"Emissions"] = onroadTotes
df2[13:16,"Year"] = as.character(myYears)
df2[13:16,"Type"] = "NON-ROAD"
df2[13:16,"Emissions"] = nonroadTotes


## ggplot panels
sp <- ggplot(data=df2, aes(x=Year, y=Emissions, color=factor(Type))) + geom_point() + facet_wrap(~Type, nrow=1) + scale_color_brewer(palette="Set1")
print(sp)
ggsave("/Users/mooncalf/Dropbox/skb/coursera/ExData_FinalProject/plot3.png")