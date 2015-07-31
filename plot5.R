NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

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
dev.copy(png, file = "plot5.png")
dev.off()