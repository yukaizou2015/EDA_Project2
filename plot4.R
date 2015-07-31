NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 4
library(proto, lib.loc = "//R01SFCHSM03.r01.med.va.gov/homedir$/vhasfczouy/My Documents/Coursera/library/")
library(sqldf, lib.loc = "//R01SFCHSM03.r01.med.va.gov/homedir$/vhasfczouy/My Documents/Coursera/library/")
library(ggplot2, lib.loc = "//R01SFCHSM03.r01.med.va.gov/homedir$/vhasfczouy/My Documents/Coursera/library/")


SCC_Coal <- SCC[SCC$EI.Sector == "Fuel Comb - Comm/Institutional - Coal", ] # Subset the coal out
# Query from NEI inner join SCC_Coal on SCC is equal
join_string <- "select NEI.SCC, NEI.Emissions, NEI.year, SCC_Coal.SCC,
                        SCC_Coal.[EI.Sector], SCC_Coal.[SCC.Level.Three] from NEI inner join SCC_Coal on
                        NEI.SCC = SCC_Coal.SCC" # Now I understand how inner join works
Query4 <- sqldf(join_string, stringsAsFactors = FALSE)
png("plot4.png", height = 600, width = 800)
        g <- ggplot(data = Query4, aes(x = year, y = Emissions)) + geom_bar(fill = "darkred", stat = "identity", width = 1.5)
        g <- g + ggtitle("Total PM2.5 Emissions in Baltimore City from Coal Combustion-related Sources")
        g <- g + scale_y_continuous("Total Emissions") + scale_x_continuous("Year", breaks = c(1999, 2002, 2005, 2008)) 
        g <- g + theme(title = element_text(face="bold", size = 15), axis.title.x = element_text(face="bold"), axis.title.y = element_text(face="bold"))
        g
dev.off()