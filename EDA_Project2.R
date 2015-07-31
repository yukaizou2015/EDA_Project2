setwd("C:/Users/vhasfczouy/Desktop/Coursera/exdata_data_NEI_data")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 1
te <- with(NEI, tapply(Emissions, year, sum)) # Total emissions per year
barplot(te)
dev.copy(png, file = "Question1.png")
dev.off()

# Question 2
NEI_Balt <- NEI[NEI$fips == "24510",] # Subset Baltimore out
te2 <- with(NEI_Balt, tapply(Emissions, year, sum)) # Total emissions per year in Baltimore
barplot(te2)
dev.copy(png, file = "Question2.png")
dev.off()

# Question 3
library(ggplot2, lib.loc = "//R01SFCHSM03.r01.med.va.gov/homedir$/vhasfczouy/My Documents/Coursera/library/")
qplot(x = year, y = Emissions, geom = "bar", stat = "identity", data = NEI_Balt, facets = . ~ type, fill = type)
dev.copy(png, file = "Question3.png")
dev.off()

# Question 4
library(xlsx, lib.loc = "//R01SFCHSM03.r01.med.va.gov/homedir$/vhasfczouy/My Documents/Coursera/library/")
library(proto, lib.loc = "//R01SFCHSM03.r01.med.va.gov/homedir$/vhasfczouy/My Documents/Coursera/library/")
library(sqldf, lib.loc = "//R01SFCHSM03.r01.med.va.gov/homedir$/vhasfczouy/My Documents/Coursera/library/")
library(ggplot2, lib.loc = "//R01SFCHSM03.r01.med.va.gov/homedir$/vhasfczouy/My Documents/Coursera/library/")

SCC_Coal <- SCC[SCC$EI.Sector == "Fuel Comb - Comm/Institutional - Coal", ] # Subset the coal out
        # Query from NEI inner join SCC_Coal on SCC is equal
        join_string <- "select NEI.SCC, NEI.Emissions, NEI.year, SCC_Coal.SCC,
                        SCC_Coal.[EI.Sector], SCC_Coal.[SCC.Level.Three] from NEI inner join SCC_Coal on
                        NEI.SCC = SCC_Coal.SCC" # Now I understand how inner join works
        Query4 <- sqldf(join_string, stringsAsFactors = FALSE)
        g <- ggplot(data = Query4, aes(x = year, y = Emissions)) + geom_bar(aes(fill = SCC.Level.Three), stat = "identity") + facet_wrap( ~ SCC.Level.Three)
        g
dev.copy(png, file = "Question4.png")
dev.off()

# Question 5
# Useful reference: http://www.cookbook-r.com/Graphs/Colors_%28ggplot2%29/
library(xlsx, lib.loc = "//R01SFCHSM03.r01.med.va.gov/homedir$/vhasfczouy/My Documents/Coursera/library/")
library(proto, lib.loc = "//R01SFCHSM03.r01.med.va.gov/homedir$/vhasfczouy/My Documents/Coursera/library/")
library(sqldf, lib.loc = "//R01SFCHSM03.r01.med.va.gov/homedir$/vhasfczouy/My Documents/Coursera/library/")
library(ggplot2, lib.loc = "//R01SFCHSM03.r01.med.va.gov/homedir$/vhasfczouy/My Documents/Coursera/library/")

NEI_Balt <- NEI[NEI$fips == "24510",] # Subset Baltimore out
SCC_MC <- SCC[SCC$SCC.Level.Three == "Motorcycles (MC)", ]
        # Query from NEI inner join SCC_Coal on SCC is equal
        join_string2 <- "select NEI_Balt.SCC, NEI_Balt.Emissions, NEI_Balt.year, SCC_MC.SCC,
                        SCC_MC.[EI.Sector], SCC_MC.[SCC.Level.Three] from NEI_Balt inner join SCC_MC on
                        NEI_Balt.SCC = SCC_MC.SCC"
        Query5 <- sqldf(join_string2, stringsAsFactors = FALSE)
        g <- ggplot(data = Query5, aes(x = year, y = Emissions))
        g <- g + geom_bar(stat = "identity")
        g
dev.copy(png, file = "Question5.png")
dev.off()

# Question 6
NEI_BL <- NEI[NEI$fips == "24510" | NEI$fips == "06037",] # Subset Baltimore and LA out
SCC_MC <- SCC[SCC$SCC.Level.Three == "Motorcycles (MC)", ]
        # Query from NEI inner join SCC_Coal on SCC is equal
        join_string3 <- "select NEI_BL.SCC, NEI_BL.fips, NEI_BL.Emissions, NEI_BL.year, SCC_MC.SCC,
                                SCC_MC.[EI.Sector], SCC_MC.[SCC.Level.Three] from NEI_BL inner join SCC_MC on
                                NEI_BL.SCC = SCC_MC.SCC"
        Query6 <- sqldf(join_string3, stringsAsFactors = FALSE)
        g <- ggplot(data = Query6, aes(x = year, y = Emissions))
        g <- g + geom_bar(aes(fill = fips), stat = "identity", position = position_dodge())
        g <- g + scale_fill_discrete(name="Location", labels = c("Baltimore City", "Los Angeles County"))
        g
dev.copy(png, file = "Question6.png")
dev.off()