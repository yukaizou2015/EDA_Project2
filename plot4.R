NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

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
dev.copy(png, file = "plot4.png")
dev.off()