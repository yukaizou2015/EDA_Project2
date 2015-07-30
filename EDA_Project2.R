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

SCC_Coal <- SCC[SCC$EI.Sector == "Fuel Comb - Comm/Institutional - Coal", ] # Subset the coal out
        # Query from NEI inner join SCC_Coal on SCC is equal
        join_string <- "select NEI.SCC, NEI.Emissions, NEI.year, SCC_Coal.SCC,
                        SCC_Coal.[EI.Sector], SCC_Coal.[SCC.Level.Three] from NEI inner join SCC_Coal on
                        NEI.SCC = SCC_Coal.SCC" # Now I understand how inner join works
        Query4 <- sqldf(join_string, stringsAsFactors = FALSE)
        qplot(x = year, y = Emissions, geom = "bar", stat = "identity", data = Query4, fill = SCC.Level.Three)
        g <- ggplot(data = Query4, aes(x = year, y = Emissions))
        g + geom_bar(stat = "identity", aes(color = Scc.Level.Three))